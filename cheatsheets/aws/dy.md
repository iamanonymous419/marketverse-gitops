# AWS DynamoDB CLI Cheatsheet

## Table Management

### Create Tables
```bash
# Basic table with hash key
aws dynamodb create-table \
  --table-name Users \
  --attribute-definitions AttributeName=UserId,AttributeType=S \
  --key-schema AttributeName=UserId,KeyType=HASH \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

# Table with hash and range key
aws dynamodb create-table \
  --table-name Orders \
  --attribute-definitions \
    AttributeName=CustomerId,AttributeType=S \
    AttributeName=OrderId,AttributeType=S \
  --key-schema \
    AttributeName=CustomerId,KeyType=HASH \
    AttributeName=OrderId,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=5

# On-demand capacity
aws dynamodb create-table \
  --table-name Events \
  --attribute-definitions \
    AttributeName=EventId,AttributeType=S \
    AttributeName=EventDate,AttributeType=S \
  --key-schema \
    AttributeName=EventId,KeyType=HASH \
    AttributeName=EventDate,KeyType=RANGE \
  --billing-mode PAY_PER_REQUEST
```

### Indexes
```bash
# Add Global Secondary Index (GSI)
aws dynamodb update-table \
  --table-name Products \
  --attribute-definitions AttributeName=Price,AttributeType=N \
  --global-secondary-index-updates "[{\"Create\": {\"IndexName\": \"PriceIndex\", \"KeySchema\": [{\"AttributeName\":\"Price\",\"KeyType\":\"HASH\"}], \"Projection\": {\"ProjectionType\":\"ALL\"}, \"ProvisionedThroughput\": {\"ReadCapacityUnits\":3,\"WriteCapacityUnits\":2}}}]"

# Create table with Local Secondary Index (LSI)
aws dynamodb create-table \
  --table-name GameScores \
  --attribute-definitions \
    AttributeName=UserId,AttributeType=S \
    AttributeName=GameId,AttributeType=S \
    AttributeName=Score,AttributeType=N \
  --key-schema \
    AttributeName=UserId,KeyType=HASH \
    AttributeName=GameId,KeyType=RANGE \
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --local-secondary-indexes \
    "[{\"IndexName\": \"ScoreIndex\", \"KeySchema\": [{\"AttributeName\":\"UserId\",\"KeyType\":\"HASH\"}, {\"AttributeName\":\"Score\",\"KeyType\":\"RANGE\"}], \"Projection\": {\"ProjectionType\":\"ALL\"}}]"
```

### Table Operations
```bash
# List tables
aws dynamodb list-tables

# Describe table
aws dynamodb describe-table --table-name Users

# Update provisioned throughput
aws dynamodb update-table \
  --table-name Users \
  --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=10

# Delete table
aws dynamodb delete-table --table-name Users

# Enable streams
aws dynamodb update-table \
  --table-name Users \
  --stream-specification StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES
```

## Item Operations

### Write Items
```bash
# Add item
aws dynamodb put-item \
  --table-name Users \
  --item '{"UserId": {"S": "user123"}, "Name": {"S": "John Doe"}, "Age": {"N": "30"}}'

# Add with condition
aws dynamodb put-item \
  --table-name Users \
  --item '{"UserId": {"S": "user789"}, "Name": {"S": "Bob"}}' \
  --condition-expression "attribute_not_exists(UserId)"

# Update item
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --update-expression "SET Age = :newage, Email = :email" \
  --expression-attribute-values '{":newage": {"N": "31"}, ":email": {"S": "john@example.com"}}'

# Add to list
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user456"}}' \
  --update-expression "SET Interests = list_append(if_not_exists(Interests, :empty_list), :interest)" \
  --expression-attribute-values '{":empty_list": {"L": []}, ":interest": {"L": [{"S": "Reading"}]}}'

# Delete item
aws dynamodb delete-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}'
```

### Read Items
```bash
# Get item
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}'

# Get with projection
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --projection-expression "Name, Email, Age"

# Strong consistency
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --consistent-read
```

## Query & Scan

### Query
```bash
# Query primary key
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :id" \
  --expression-attribute-values '{":id": {"S": "customer123"}}'

# Query with range key
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :id AND OrderId > :orderId" \
  --expression-attribute-values '{":id": {"S": "customer123"}, ":orderId": {"S": "2023-01-01"}}'

# Query GSI
aws dynamodb query \
  --table-name Products \
  --index-name CategoryIndex \
  --key-condition-expression "ProductCategory = :cat" \
  --expression-attribute-values '{":cat": {"S": "Electronics"}}'

# Query with filter
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :id" \
  --filter-expression "OrderStatus = :status" \
  --expression-attribute-values '{":id": {"S": "customer123"}, ":status": {"S": "Shipped"}}'

# Descending order
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :id" \
  --expression-attribute-values '{":id": {"S": "customer123"}}' \
  --scan-index-forward false
```

### Scan
```bash
# Basic scan
aws dynamodb scan --table-name Users

# Scan with filter
aws dynamodb scan \
  --table-name Users \
  --filter-expression "Age > :age" \
  --expression-attribute-values '{":age": {"N": "30"}}'

# Scan with projection
aws dynamodb scan \
  --table-name Users \
  --projection-expression "UserId, Name, Email"

# Parallel scan
aws dynamodb scan \
  --table-name Users \
  --segment 0 \
  --total-segments 4
```

## Batch & Transactions

### Batch Operations
```bash
# Batch get
aws dynamodb batch-get-item \
  --request-items '{
    "Users": {
      "Keys": [
        {"UserId": {"S": "user123"}},
        {"UserId": {"S": "user456"}}
      ]
    }
  }'

# Batch write
aws dynamodb batch-write-item \
  --request-items '{
    "Users": [
      {
        "PutRequest": {
          "Item": {"UserId": {"S": "user789"}, "Name": {"S": "Alex"}}
        }
      },
      {
        "DeleteRequest": {
          "Key": {"UserId": {"S": "user101"}}
        }
      }
    ]
  }'
```

### Transactions
```bash
# Transaction write
aws dynamodb transact-write-items \
  --transact-items '[
    {
      "Put": {
        "TableName": "Orders",
        "Item": {
          "CustomerId": {"S": "customer123"},
          "OrderId": {"S": "order789"},
          "OrderStatus": {"S": "Pending"}
        }
      }
    },
    {
      "Update": {
        "TableName": "Inventory",
        "Key": {"ProductId": {"S": "prod123"}},
        "UpdateExpression": "SET Stock = Stock - :dec",
        "ExpressionAttributeValues": {":dec": {"N": "1"}}
      }
    }
  ]'

# Transaction get
aws dynamodb transact-get-items \
  --transact-items '[
    {
      "Get": {
        "TableName": "Orders",
        "Key": {
          "CustomerId": {"S": "customer123"},
          "OrderId": {"S": "order789"}
        }
      }
    },
    {
      "Get": {
        "TableName": "Customers",
        "Key": {"CustomerId": {"S": "customer123"}}
      }
    }
  ]'
```

## Backups & Recovery

```bash
# Create backup
aws dynamodb create-backup \
  --table-name Users \
  --backup-name Users-Backup-2023-04-15

# List backups
aws dynamodb list-backups --table-name Users

# Enable point-in-time recovery
aws dynamodb update-continuous-backups \
  --table-name Users \
  --point-in-time-recovery-specification PointInTimeRecoveryEnabled=true

# Restore from backup
aws dynamodb restore-table-from-backup \
  --target-table-name Users-Restored \
  --backup-arn arn:aws:dynamodb:region:account:table/Users/backup/backup-id

# Restore to point in time
aws dynamodb restore-table-to-point-in-time \
  --source-table-name Users \
  --target-table-name Users-Restored \
  --restore-date-time 2023-04-10T12:00:00Z
```

## Other Features

```bash
# Enable TTL
aws dynamodb update-time-to-live \
  --table-name Sessions \
  --time-to-live-specification "Enabled=true,AttributeName=ExpirationTime"

# Export to S3
aws dynamodb export-table-to-point-in-time \
  --table-arn arn:aws:dynamodb:region:account:table/Users \
  --s3-bucket my-dynamodb-exports \
  --s3-prefix exports/users \
  --export-format DYNAMODB_JSON

# Tag resources
aws dynamodb tag-resource \
  --resource-arn arn:aws:dynamodb:region:account:table/Users \
  --tags Key=Environment,Value=Production
```