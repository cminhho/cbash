#!/usr/bin/env bash
# AWS plugin for CBASH
# Provides utilities for AWS infrastructure management

[[ -n "$CBASH_DIR" ]] && source "$CBASH_DIR/lib/common.sh"

# Localstack configuration
readonly AWS_LOCALSTACK_ENDPOINT="http://localhost:4566"
readonly AWS_LOCALSTACK_REGION="us-west-2"
readonly AWS_SSM_REGION="ap-southeast-1"

# Valid environments for SSH gateway
readonly -a VALID_ENVS=("dev" "test" "staging" "production")

# -----------------------------------------------------------------------------
# Aliases
# -----------------------------------------------------------------------------

alias awsssh='aws_ssh_gateway'
alias awssqscreate='aws_sqs_create'
alias awssqstest='aws_sqs_test'
alias awsssmget='aws_ssm_get'

# -----------------------------------------------------------------------------
# Helper Functions
# -----------------------------------------------------------------------------

_aws_validate_env() {
    local env="$1"
    [[ " ${VALID_ENVS[*]} " =~ " ${env} " ]]
}

_aws_check_cli() {
    command -v aws &>/dev/null || {
        err "AWS CLI not installed. Run: brew install awscli"
        return 1
    }
}

_aws_check_profile() {
    local profile="$1"
    aws configure list --profile "$profile" &>/dev/null || {
        err "Profile '$profile' not found. Run: aws configure --profile $profile"
        return 1
    }
}

# -----------------------------------------------------------------------------
# Commands
# -----------------------------------------------------------------------------

aws_ssh_gateway() {
    [[ $# -eq 2 ]] || {
        err "Usage: cbash aws ssh <profile> <env>"
        return 1
    }

    local profile="$1" env="$2"

    _aws_validate_env "$env" || {
        err "Invalid environment. Use: ${VALID_ENVS[*]}"
        return 1
    }

    _aws_check_cli || return 1
    _aws_check_profile "$profile" || return 1

    info "Connecting to $env using profile $profile..."
    aws ssm start-session \
        --profile "$profile" \
        --target "ssh-gateway-$env" \
        --region "$AWS_SSM_REGION"
}

aws_sqs_create() {
    _aws_check_cli || return 1

    read -rp "Queue name: " queue_name
    [[ -n "$queue_name" ]] || {
        echo "Error: Queue name required"
        return 1
    }

    local response
    response=$(aws sqs create-queue \
        --queue-name "$queue_name" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "Queue created: $response"
    else
        echo "Error: $response"
        return 1
    fi
}

aws_sqs_test() {
    _aws_check_cli || return 1
    command -v jq &>/dev/null || {
        echo "Error: jq not installed. Run: brew install jq"
        return 1
    }

    read -rp "Queue name: " queue_name
    read -rp "Message: " message
    [[ -n "$queue_name" && -n "$message" ]] || {
        echo "Error: Queue name and message required"
        return 1
    }

    local queue_url="$AWS_LOCALSTACK_ENDPOINT/000000000000/$queue_name"

    # Send message
    local send_response
    send_response=$(aws sqs send-message \
        --queue-url "$queue_url" \
        --message-body "$message" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" 2>&1) || {
        echo "Error sending message: $send_response"
        return 1
    }

    # Receive message
    local receive_response
    receive_response=$(aws sqs receive-message \
        --queue-url "$queue_url" \
        --max-number-of-messages 1 \
        --wait-time-seconds 20 \
        --query "Messages[0]" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" 2>&1) || {
        echo "Error receiving message: $receive_response"
        return 1
    }

    local received_body receipt_handle
    received_body=$(echo "$receive_response" | jq -r '.Body')
    receipt_handle=$(echo "$receive_response" | jq -r '.ReceiptHandle')

    # Verify
    if [[ "$received_body" == "$message" ]]; then
        echo "✓ Message sent and received successfully"
    else
        echo "✗ Message mismatch"
        return 1
    fi

    # Delete message
    aws sqs delete-message \
        --queue-url "$queue_url" \
        --receipt-handle "$receipt_handle" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" &>/dev/null
}

aws_ssm_get() {
    _aws_check_cli || return 1

    read -rp "Profile: " profile
    read -rp "Parameter name: " param_name
    [[ -n "$profile" && -n "$param_name" ]] || {
        echo "Error: Profile and parameter name required"
        return 1
    }

    _aws_check_profile "$profile" || return 1

    local value
    value=$(aws ssm get-parameter \
        --name "$param_name" \
        --profile "$profile" \
        --query "Parameter.Value" \
        --output text 2>&1)

    if [[ $? -eq 0 ]]; then
        echo "$param_name: $value"
    else
        echo "Error: $value"
        return 1
    fi
}

# -----------------------------------------------------------------------------
# Main Router
# -----------------------------------------------------------------------------

aws_help() {
    _describe command 'aws' \
        'ssh <profile> <env>  Connect to SSH gateway (SSM)' \
        'sqs-create          Create SQS queue (localstack)' \
        'sqs-test            Test SQS send/receive (localstack)' \
        'ssm-get             Get SSM parameter value' \
        'aliases             List AWS aliases' \
        'AWS infrastructure utilities'
}

aws_list_aliases() {
    echo "AWS aliases: awsssh, awssqscreate, awssqstest, awsssmget"
    echo "  awsssh <profile> <env> = aws ssh"
    echo "  awssqscreate / awssqstest = SQS (localstack)"
    echo "  awsssmget = SSM get parameter"
}

_main() {
    local cmd="$1"

    if [[ -z "$cmd" ]]; then
        aws_help
        return 0
    fi

    case "$cmd" in
        help|--help|-h) aws_help ;;
        aliases)        aws_list_aliases ;;
        ssh)            shift; aws_ssh_gateway "$@" ;;
        sqs-create)     shift; aws_sqs_create "$@" ;;
        sqs-test)       shift; aws_sqs_test "$@" ;;
        ssm-get)        shift; aws_ssm_get "$@" ;;
        *)              abort "Invalid command: $cmd" ;;
    esac
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && _main "$@"
