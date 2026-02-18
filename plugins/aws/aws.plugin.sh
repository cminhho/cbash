#!/usr/bin/env bash
# AWS plugin for CBASH - AWS infrastructure utilities

readonly AWS_LOCALSTACK_ENDPOINT="http://localhost:4566"
readonly AWS_SSM_REGION="ap-southeast-1"

# Valid environments for SSH gateway
readonly -a VALID_ENVS=("dev" "test" "staging" "production")

# Helper Functions

_aws_validate_env() {
    local env="$1"
    [[ " ${VALID_ENVS[*]} " == *" ${env} "* ]]
}

_aws_check_cli() {
    command -v aws &>/dev/null || {
        log_error "AWS CLI not installed. Run: brew install awscli"
        return 1
    }
}

_aws_check_profile() {
    local profile="$1"
    aws configure list --profile "$profile" &>/dev/null || {
        log_error "Profile '$profile' not found. Run: aws configure --profile $profile"
        return 1
    }
}

# Commands

aws_ssh_gateway() {
    [[ $# -eq 2 ]] || {
        log_error "Usage: cbash aws ssh <profile> <env>"
        return 1
    }

    local profile="$1" env="$2"

    _aws_validate_env "$env" || {
        log_error "Invalid environment. Use: ${VALID_ENVS[*]}"
        return 1
    }

    _aws_check_cli || return 1
    _aws_check_profile "$profile" || return 1

    log_info "Connecting to $env using profile $profile..."
    aws ssm start-session \
        --profile "$profile" \
        --target "ssh-gateway-$env" \
        --region "$AWS_SSM_REGION"
}

aws_sqs_create() {
    _aws_check_cli || return 1

    read -rp "Queue name: " queue_name
    [[ -n "$queue_name" ]] || {
        log_error "Queue name required"
        return 1
    }

    local response ret
    response=$(aws sqs create-queue \
        --queue-name "$queue_name" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" 2>&1)
    ret=$?
    if [[ $ret -eq 0 ]]; then
        log_success "Queue created: $response"
    else
        log_error "$response"
        return 1
    fi
}

aws_sqs_test() {
    _aws_check_cli || return 1
    command -v jq &>/dev/null || {
        log_error "jq not installed. Run: brew install jq"
        return 1
    }

    read -rp "Queue name: " queue_name
    read -rp "Message: " message
    [[ -n "$queue_name" && -n "$message" ]] || {
        log_error "Queue name and message required"
        return 1
    }

    local queue_url="$AWS_LOCALSTACK_ENDPOINT/000000000000/$queue_name"

    # Send message
    local send_response
    send_response=$(aws sqs send-message \
        --queue-url "$queue_url" \
        --message-body "$message" \
        --endpoint-url "$AWS_LOCALSTACK_ENDPOINT" 2>&1) || {
        log_error "Error sending message: $send_response"
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
        log_error "Error receiving message: $receive_response"
        return 1
    }

    local received_body receipt_handle
    received_body=$(echo "$receive_response" | jq -r '.Body')
    receipt_handle=$(echo "$receive_response" | jq -r '.ReceiptHandle')

    # Verify
    if [[ "$received_body" == "$message" ]]; then
        log_success "Message sent and received successfully"
    else
        log_error "Message mismatch"
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
        log_error "Profile and parameter name required"
        return 1
    }

    _aws_check_profile "$profile" || return 1

    local value ret
    value=$(aws ssm get-parameter \
        --name "$param_name" \
        --profile "$profile" \
        --query "Parameter.Value" \
        --output text 2>&1)
    ret=$?
    if [[ $ret -eq 0 ]]; then
        log_info "$param_name: $value"
    else
        log_error "$value"
        return 1
    fi
}

# Main Router

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
    case "${1:-}" in
        help|--help|-h|"") aws_help ;;
        aliases)           aws_list_aliases ;;
        ssh)               shift; aws_ssh_gateway "$@" ;;
        sqs-create)        shift; aws_sqs_create "$@" ;;
        sqs-test)          shift; aws_sqs_test "$@" ;;
        ssm-get)           shift; aws_ssm_get "$@" ;;
        *)                 log_error "Unknown: $1"; return 1 ;;
    esac
}

