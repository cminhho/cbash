# AWS Plugin — AWS infrastructure utilities

SSH gateway (SSM), SQS (localstack), and SSM Parameter Store. Source CBASH to get aliases.

## Commands

| Command | Description |
|---------|-------------|
| `cbash aws` / `help` | Show help |
| `cbash aws aliases` | List aliases |
| `cbash aws ssh <profile> <env>` | Connect to SSH gateway (SSM). Env: dev, test, staging, production |
| `cbash aws sqs-create` | Create SQS queue (localstack, prompts for name) |
| `cbash aws sqs-test` | Test SQS send/receive (localstack, requires jq) |
| `cbash aws ssm-get` | Get SSM parameter (prompts for profile and param name) |

## Aliases

| Alias | Command |
|-------|--------|
| `awsssh <profile> <env>` | aws ssh |
| `awssqscreate` | aws sqs-create |
| `awssqstest` | aws sqs-test |
| `awsssmget` | aws ssm-get |

## Plugin commands (detail)

* `cbash aws ssh <profile> <env>`: connects to EC2 instances via AWS Systems Manager Session Manager.
  The `<profile>` is your AWS profile name from `~/.aws/credentials`. The `<env>` must be one of:
  `dev`, `test`, `staging`, or `production`. Requires target instances named `ssh-gateway-{env}` with
  SSM agent installed. Region is hardcoded to `ap-southeast-1`.

* `cbash aws sqs-create`: creates an SQS queue in localstack for local development. Interactively
  prompts for queue name. Connects to localstack at `http://localhost:4566` in `us-west-2` region.

* `cbash aws sqs-test`: tests SQS operations by sending a message, receiving it, verifying content,
  and deleting it. Interactively prompts for queue name and message body. Requires `jq` for JSON
  parsing and localstack running on `localhost:4566`.

* `cbash aws ssm-get`: retrieves parameter value from AWS Systems Manager Parameter Store.
  Interactively prompts for AWS profile name and SSM parameter name.

## Prerequisites

The plugin requires [AWS CLI](https://aws.amazon.com/cli/) to be installed and configured:

```bash
# Install AWS CLI
brew install awscli  # macOS
apt-get install awscli  # Linux

# Configure credentials
aws configure --profile your-profile-name
```

Optional dependencies:
- `jq` - Required for SQS operations
- `localstack` - Required for local SQS testing

## Configuration

### AWS Credentials

Configure your AWS credentials in `~/.aws/credentials`:

```ini
[myprofile]
aws_access_key_id = AKIAIOSFODNN7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

Configure profiles in `~/.aws/config`:

```ini
[profile myprofile]
region = ap-southeast-1
output = json
```

### SSH Gateway Infrastructure

EC2 instances must follow this naming convention:
- `ssh-gateway-dev`
- `ssh-gateway-test`
- `ssh-gateway-staging`
- `ssh-gateway-production`

Requirements:
- SSM agent installed and running
- Instance must have SSM IAM role attached
- Located in `ap-southeast-1` region

IAM permissions required:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["ssm:StartSession"],
      "Resource": ["arn:aws:ec2:ap-southeast-1:*:instance/*"],
      "Condition": {
        "StringLike": {
          "ssm:resourceTag/Name": "ssh-gateway-*"
        }
      }
    }
  ]
}
```

### Localstack Setup

For local SQS testing, run localstack:

```bash
docker run -d --name localstack -p 4566:4566 localstack/localstack
```

Verify it's running:

```bash
curl http://localhost:4566/_localstack/health
```

## Examples

Connect to development SSH gateway:

```bash
cbash aws ssh myprofile dev
```

Create and test SQS queue locally:

```bash
cbash aws sqs-create
# Enter the name of the SQS queue to create: my-test-queue

cbash aws sqs-test
# Enter the name of the SQS queue to use: my-test-queue
# Enter the message to send to the SQS queue: Hello World
```

Retrieve SSM parameter:

```bash
cbash aws ssm-get
# Enter the name of the AWS profile to use: myprofile
# Enter the name of the SSM parameter to retrieve: /app/database/password
```

## Troubleshooting

**AWS CLI not found:**
```bash
brew install awscli
```

**Profile not found:**
```bash
cat ~/.aws/credentials  # Check existing profiles
aws configure --profile myprofile  # Configure new profile
```

**SSH gateway connection failed:**
- Verify instance exists and is running
- Check SSM agent status on instance
- Verify IAM permissions for `ssm:StartSession`
- Ensure instance is tagged correctly

**SQS operations failed:**
```bash
brew install jq  # Install jq if missing
docker ps | grep localstack  # Verify localstack is running
docker logs localstack  # Check localstack logs
```

**SSM parameter not found:**
- Verify parameter exists: `aws ssm get-parameter --name /your/param --profile myprofile`
- Check parameter name is correct (case-sensitive)
- Verify profile has `ssm:GetParameter` permission
