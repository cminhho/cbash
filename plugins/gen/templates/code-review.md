# Code Review - Merchant Cash Advance

## Review Information
- **Date**: {{DATE}}
- **Pull Request**: [Link]
- **Reviewer**: [Your Name]
- **Author**: [Author Name]
- **JIRA Ticket**: [TICKET-ID]

## Change Overview
### Purpose
Brief description of the changes...

### Scope
- **Services Affected**:
  - [ ] API Gateway endpoints
  - [ ] Lambda functions
  - [ ] Step Functions
  - [ ] DynamoDB tables
  - [ ] S3 buckets
  - [ ] Databricks notebooks
  - [ ] SQS queues
  - [ ] EventBridge rules

## Technical Review

### AWS Lambda Review
- [ ] Handler function properly structured
- [ ] Error handling comprehensive
  - [ ] AWS SDK errors handled
  - [ ] Business logic errors handled
  - [ ] Input validation errors handled
- [ ] Memory size appropriate
- [ ] Timeout configuration reasonable
- [ ] Environment variables properly used
- [ ] IAM permissions follow least privilege
- [ ] Cold start optimization considered
- [ ] Async/await properly used
- [ ] Resources cleaned up properly

### Serverless Architecture
- [ ] CloudFormation/SAM template changes reviewed
- [ ] Resource naming follows conventions
- [ ] Event source mappings correct
- [ ] Dead letter queues configured
- [ ] Retry policies appropriate
- [ ] CloudWatch log groups properly set
- [ ] Service quotas/limits considered

### Databricks Integration
- [ ] Notebook changes reviewed
- [ ] Data processing logic verified
- [ ] Performance optimization checked
- [ ] Error handling in place
- [ ] Data schema changes documented
- [ ] Job scheduling configured
- [ ] Delta table operations optimized

### Observability
#### Datadog Integration
- [ ] Custom metrics added if needed
- [ ] Tracing instrumented
- [ ] Log correlation IDs used
- [ ] Error tracking configured
- [ ] Dashboards updated
- [ ] Alerts configured appropriately

#### Logging
- [ ] Appropriate log levels used
- [ ] Structured logging implemented
- [ ] PII data masked
- [ ] Financial data redacted
- [ ] Context information included
- [ ] Performance metrics logged

### Security Review
- [ ] Input validation comprehensive
- [ ] Authentication properly handled
- [ ] Authorization checks in place
- [ ] Sensitive data encrypted
- [ ] Secure communication enforced
- [ ] Injection vulnerabilities prevented
- [ ] Dependencies are secure
- [ ] Secrets properly managed

### Data Handling
- [ ] Data validation complete
- [ ] Transaction handling correct
- [ ] Financial calculations verified
- [ ] Data consistency maintained
- [ ] Cleanup processes in place
- [ ] Backup strategy considered

### Testing
- [ ] Unit tests added/updated
  - [ ] Happy path tested
  - [ ] Error cases tested
  - [ ] Edge cases covered
- [ ] Integration tests included
- [ ] Performance tests if needed
- [ ] Mocks used appropriately
- [ ] Test coverage adequate

### Performance Considerations
- [ ] Database queries optimized
- [ ] Batch processing used where appropriate
- [ ] Caching strategy implemented
- [ ] Async operations used effectively
- [ ] Resource consumption reasonable
- [ ] Scaling considerations addressed

### Error Handling & Resilience
- [ ] Error messages are clear
- [ ] Fallback mechanisms in place
- [ ] Circuit breakers implemented
- [ ] Retry logic appropriate
- [ ] Transaction boundaries clear
- [ ] Data consistency maintained in failures

## Standards Compliance

### Code Quality
- [ ] Follows coding standards
- [ ] Properly documented
- [ ] Variables/functions well named
- [ ] No hardcoded values
- [ ] Code is DRY
- [ ] Complexity is reasonable

### Financial Logic
- [ ] Payment processing logic verified
- [ ] Currency handling correct
- [ ] Rounding rules followed
- [ ] Fee calculations accurate
- [ ] Transaction limits enforced
- [ ] Audit trail maintained

### Best Practices
- [ ] AWS Well-Architected principles followed
- [ ] Serverless best practices applied
- [ ] Security best practices followed
- [ ] Performance best practices considered
- [ ] Cost optimization considered

## Migration & Deployment
- [ ] Database migrations included
- [ ] Backward compatibility maintained
- [ ] Feature flags used if needed
- [ ] Deployment order documented
- [ ] Rollback plan included
- [ ] Dependencies addressed

## Documentation
- [ ] API changes documented
- [ ] README updated if needed
- [ ] Architecture diagrams updated
- [ ] Configuration changes documented
- [ ] Release notes prepared

## Review Feedback
### Major Concerns
1. 

### Minor Suggestions
1. 

### Questions
1. 

## Sign-off Checklist
- [ ] Code functions as intended
- [ ] Tests pass and cover changes
- [ ] Documentation complete
- [ ] Security requirements met
- [ ] Performance acceptable
- [ ] Monitoring in place
