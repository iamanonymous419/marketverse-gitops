# AWS RDS CLI Cheatsheet

Quick reference for Amazon Relational Database Service (RDS) using the AWS CLI.

## Instance Management

### Create & Describe Instances
```bash
# Create DB instance
aws rds create-db-instance \
  --db-instance-identifier my-db \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password mypassword \
  --allocated-storage 20

# List all instances
aws rds describe-db-instances

# Get specific instance details
aws rds describe-db-instances --db-instance-identifier my-db

# Query specific fields
aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceStatus]"
```

### Modify Instance
```bash
# Resize instance
aws rds modify-db-instance \
  --db-instance-identifier my-db \
  --db-instance-class db.t3.small \
  --apply-immediately

# Increase storage
aws rds modify-db-instance \
  --db-instance-identifier my-db \
  --allocated-storage 50 \
  --apply-immediately

# Enable Performance Insights
aws rds modify-db-instance \
  --db-instance-identifier my-db \
  --enable-performance-insights \
  --performance-insights-retention-period 7 \
  --apply-immediately
```

### Start, Stop & Reboot
```bash
# Start instance
aws rds start-db-instance --db-instance-identifier my-db

# Stop instance
aws rds stop-db-instance --db-instance-identifier my-db

# Normal reboot
aws rds reboot-db-instance --db-instance-identifier my-db

# Force failover (Multi-AZ)
aws rds reboot-db-instance --db-instance-identifier my-db --force-failover
```

### Delete Instance
```bash
# Delete with final snapshot
aws rds delete-db-instance \
  --db-instance-identifier my-db \
  --final-db-snapshot-identifier my-final-snapshot

# Delete without snapshot
aws rds delete-db-instance \
  --db-instance-identifier my-db \
  --skip-final-snapshot
```

## Snapshot Operations

### Create & List Snapshots
```bash
# Create manual snapshot
aws rds create-db-snapshot \
  --db-instance-identifier my-db \
  --db-snapshot-identifier my-snapshot

# List all snapshots
aws rds describe-db-snapshots

# List snapshots for specific instance
aws rds describe-db-snapshots --db-instance-identifier my-db

# Filter by type (manual/automated)
aws rds describe-db-snapshots --snapshot-type manual
```

### Copy & Delete Snapshots
```bash
# Copy snapshot within region
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier my-snapshot \
  --target-db-snapshot-identifier my-snapshot-copy

# Copy to another region
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier my-snapshot \
  --target-db-snapshot-identifier my-snapshot-copy \
  --source-region us-east-1 \
  --region us-west-2

# Delete snapshot
aws rds delete-db-snapshot --db-snapshot-identifier my-snapshot
```

### Restore from Snapshot
```bash
# Basic restore
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db \
  --db-snapshot-identifier my-snapshot

# Restore with different instance class
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db \
  --db-snapshot-identifier my-snapshot \
  --db-instance-class db.t3.large
```

## Parameter Groups

```bash
# Create parameter group
aws rds create-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --db-parameter-group-family mysql8.0 \
  --description "Custom MySQL parameters"

# Modify parameters
aws rds modify-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --parameters "ParameterName=max_connections,ParameterValue=500,ApplyMethod=immediate"

# List parameter groups
aws rds describe-db-parameter-groups

# List parameters in group
aws rds describe-db-parameters --db-parameter-group-name my-param-group

# Show only modified parameters
aws rds describe-db-parameters \
  --db-parameter-group-name my-param-group \
  --source user

# Delete parameter group
aws rds delete-db-parameter-group --db-parameter-group-name my-param-group
```

## Subnet Groups

```bash
# Create subnet group
aws rds create-db-subnet-group \
  --db-subnet-group-name my-subnet-group \
  --db-subnet-group-description "My DB subnet group" \
  --subnet-ids subnet-12345678 subnet-87654321

# List subnet groups
aws rds describe-db-subnet-groups

# Modify subnet group
aws rds modify-db-subnet-group \
  --db-subnet-group-name my-subnet-group \
  --subnet-ids subnet-12345678 subnet-87654321 subnet-56781234

# Delete subnet group
aws rds delete-db-subnet-group --db-subnet-group-name my-subnet-group
```

## Read Replicas

```bash
# Create read replica
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-replica \
  --source-db-instance-identifier my-source-db

# Cross-region read replica
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-replica \
  --source-db-instance-identifier my-source-db \
  --source-region us-east-1 \
  --region us-west-2

# Promote read replica
aws rds promote-read-replica \
  --db-instance-identifier my-replica \
  --backup-retention-period 7
```

## Multi-AZ & Failover

```bash
# Convert to Multi-AZ
aws rds modify-db-instance \
  --db-instance-identifier my-db \
  --multi-az \
  --apply-immediately

# Trigger failover
aws rds failover-db-instance --db-instance-identifier my-db
```

## Logs & Monitoring

```bash
# List log files
aws rds describe-db-log-files --db-instance-identifier my-db

# Download log file
aws rds download-db-log-file-portion \
  --db-instance-identifier my-db \
  --log-file-name error/mysql-error.log \
  --output text

# View events (last 24 hours)
aws rds describe-events --duration 1440

# Enable enhanced monitoring
aws rds modify-db-instance \
  --db-instance-identifier my-db \
  --monitoring-interval 30 \
  --monitoring-role-arn arn:aws:iam::123456789012:role/rds-monitoring-role \
  --apply-immediately
```

## Maintenance

```bash
# Apply pending maintenance
aws rds apply-pending-maintenance-action \
  --resource-identifier arn:aws:rds:region:account:db:my-db \
  --apply-action system-update \
  --opt-in-type immediate

# List pending maintenance actions
aws rds describe-pending-maintenance-actions
```

## Aurora Clusters

```bash
# Create Aurora cluster
aws rds create-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --engine aurora-mysql \
  --master-username admin \
  --master-user-password mypassword \
  --db-subnet-group-name my-subnet-group

# Create instance in cluster
aws rds create-db-instance \
  --db-instance-identifier my-aurora-instance \
  --db-instance-class db.r5.large \
  --engine aurora-mysql \
  --db-cluster-identifier my-aurora-cluster

# List clusters
aws rds describe-db-clusters

# Create cluster snapshot
aws rds create-db-cluster-snapshot \
  --db-cluster-identifier my-aurora-cluster \
  --db-cluster-snapshot-identifier my-cluster-snapshot

# Delete cluster
aws rds delete-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --skip-final-snapshot
```

## Tagging

```bash
# Add tags
aws rds add-tags-to-resource \
  --resource-name arn:aws:rds:region:account:db:my-db \
  --tags "Key=Environment,Value=Production" "Key=Owner,Value=DBTeam"

# List tags
aws rds list-tags-for-resource \
  --resource-name arn:aws:rds:region:account:db:my-db

# Remove tags
aws rds remove-tags-from-resource \
  --resource-name arn:aws:rds:region:account:db:my-db \
  --tag-keys "Environment" "Owner"
```

## RDS Proxy

```bash
# Create DB proxy
aws rds create-db-proxy \
  --db-proxy-name my-db-proxy \
  --engine-family MYSQL \
  --auth '{"AuthScheme":"SECRETS","IAMAuth":"DISABLED","SecretArn":"arn:aws:secretsmanager:region:account:secret:mySecret"}' \
  --role-arn arn:aws:iam::account:role/RDSProxyRole \
  --vpc-subnet-ids subnet-12345678 subnet-87654321 \
  --vpc-security-group-ids sg-0123456789abcdef

# Register targets
aws rds register-db-proxy-targets \
  --db-proxy-name my-db-proxy \
  --db-instance-identifiers my-db

# List proxies
aws rds describe-db-proxies

# Delete proxy
aws rds delete-db-proxy --db-proxy-name my-db-proxy
```

## Output Formatting

```bash
# Format as table
aws rds describe-db-instances --output table

# Format as JSON
aws rds describe-db-instances --output json

# Query for specific fields
aws rds describe-db-instances \
  --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus]" \
  --output table

# Filter by engine type
aws rds describe-db-instances \
  --query "DBInstances[?Engine=='mysql'].[DBInstanceIdentifier,DBInstanceClass]" \
  --output json
```