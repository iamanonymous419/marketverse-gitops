# AWS IAM CLI Cheatsheet

This cheatsheet provides quick reference for common AWS Identity and Access Management (IAM) operations using the AWS CLI.

## User Management

```bash
# Create a user
aws iam create-user --user-name username

# List all users
aws iam list-users

# Get user details
aws iam get-user --user-name username

# Delete a user
aws iam delete-user --user-name username

# Create console access
aws iam create-login-profile --user-name username --password P@ssw0rd --password-reset-required
```

## Group Management

```bash
# Create a group
aws iam create-group --group-name Developers

# Add user to group
aws iam add-user-to-group --user-name username --group-name Developers

# List users in group
aws iam get-group --group-name Developers

# Remove user from group
aws iam remove-user-from-group --user-name username --group-name Developers
```

## Role Management

```bash
# Create a role
aws iam create-role --role-name RoleName --assume-role-policy-document file://trust-policy.json

# List all roles
aws iam list-roles

# Update role description
aws iam update-role --role-name RoleName --description "Role description"

# Delete role
aws iam delete-role --role-name RoleName
```

## Policy Management

```bash
# Create policy
aws iam create-policy --policy-name PolicyName --policy-document file://policy.json

# List policies
aws iam list-policies

# Get policy details
aws iam get-policy --policy-arn arn:aws:iam::aws:policy/PolicyName

# Delete policy
aws iam delete-policy --policy-arn arn:aws:iam::123456789012:policy/PolicyName
```

## Policy Attachments

```bash
# Attach policy to user
aws iam attach-user-policy --user-name username --policy-arn policy-arn

# Attach policy to group
aws iam attach-group-policy --group-name GroupName --policy-arn policy-arn

# Attach policy to role
aws iam attach-role-policy --role-name RoleName --policy-arn policy-arn

# List policies for user
aws iam list-attached-user-policies --user-name username

# Detach policy from user
aws iam detach-user-policy --user-name username --policy-arn policy-arn
```

## Access Keys

```bash
# Create access key
aws iam create-access-key --user-name username

# List access keys
aws iam list-access-keys --user-name username

# Get last used info
aws iam get-access-key-last-used --access-key-id AKIAIOSFODNN7EXAMPLE

# Deactivate access key
aws iam update-access-key --user-name username --access-key-id key-id --status Inactive

# Delete access key
aws iam delete-access-key --user-name username --access-key-id key-id
```

## MFA Management

```bash
# Enable virtual MFA
aws iam enable-mfa-device --user-name username --serial-number device-arn \
  --authentication-code1 code1 --authentication-code2 code2

# List MFA devices
aws iam list-mfa-devices --user-name username

# Deactivate MFA device
aws iam deactivate-mfa-device --user-name username --serial-number device-arn
```

## Security Tools

```bash
# Get account summary
aws iam get-account-summary

# Get password policy
aws iam get-account-password-policy

# Update password policy
aws iam update-account-password-policy --minimum-password-length 12 --require-symbols

# Generate credential report
aws iam generate-credential-report

# Get credential report
aws iam get-credential-report
```

## Identity Providers

```bash
# Create SAML provider
aws iam create-saml-provider --saml-metadata-document file://saml-metadata.xml --name ProviderName

# Create OIDC provider
aws iam create-open-id-connect-provider --url https://provider.url \
  --client-id-list client-id --thumbprint-list thumbprint
```

## Tagging

```bash
# Tag a user
aws iam tag-user --user-name username --tags '[{"Key":"Department","Value":"IT"}]'

# List tags for user
aws iam list-user-tags --user-name username

# Remove tags
aws iam untag-user --user-name username --tag-keys '["Department"]'
```

## Best Practices

```bash
# Find users without MFA
aws iam generate-credential-report
aws iam get-credential-report --output text --query 'Content' | base64 -d | grep -v "^user" | grep "false" | cut -d, -f1,4 | grep ",false"

# Rotate access keys
NEW_KEY=$(aws iam create-access-key --user-name username --output json)
# Store new key securely before deactivating old key
aws iam update-access-key --user-name username --access-key-id old-key-id --status Inactive
```

## User Cleanup

```bash
# Remove all policies, groups, MFA devices, and access credentials before deleting user
# See full example in documentation for complete user cleanup script
```