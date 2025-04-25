# AWS CLI Cheatsheet for Container Services

Quick reference guide for managing AWS container services (EKS, ECS, and ECR) using the AWS CLI.

## Amazon Elastic Kubernetes Service (EKS)

### Clusters
```bash
# Create cluster
aws eks create-cluster \
  --name my-cluster \
  --role-arn arn:aws:iam::123456789012:role/eks-cluster-role \
  --resources-vpc-config subnetIds=subnet-abc,subnet-def,securityGroupIds=sg-123 \
  --kubernetes-version 1.28

# List clusters
aws eks list-clusters

# Describe cluster
aws eks describe-cluster --name my-cluster

# Update cluster version
aws eks update-cluster-version --name my-cluster --kubernetes-version 1.29

# Delete cluster
aws eks delete-cluster --name my-cluster
```

### Node Groups
```bash
# Create node group
aws eks create-nodegroup \
  --cluster-name my-cluster \
  --nodegroup-name my-nodegroup \
  --subnets subnet-abc subnet-def \
  --node-role arn:aws:iam::123456789012:role/eks-node-role \
  --scaling-config minSize=2,maxSize=5,desiredSize=3 \
  --instance-types t3.medium

# List node groups
aws eks list-nodegroups --cluster-name my-cluster

# Describe node group
aws eks describe-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup

# Update node group
aws eks update-nodegroup-config \
  --cluster-name my-cluster \
  --nodegroup-name my-nodegroup \
  --scaling-config minSize=3,maxSize=6,desiredSize=3

# Delete node group
aws eks delete-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup
```

### Access Management
```bash
# Update kubeconfig for kubectl
aws eks update-kubeconfig --name my-cluster --region us-east-1

# Create access entry
aws eks create-access-entry \
  --cluster-name my-cluster \
  --principal-arn arn:aws:iam::123456789012:role/developer-role \
  --type STANDARD

# Associate access policy
aws eks associate-access-policy \
  --cluster-name my-cluster \
  --principal-arn arn:aws:iam::123456789012:role/developer-role \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy
```

### Add-ons
```bash
# Create add-on
aws eks create-addon \
  --cluster-name my-cluster \
  --addon-name vpc-cni \
  --addon-version v1.12.0-eksbuild.1

# List add-ons
aws eks list-addons --cluster-name my-cluster

# Update add-on
aws eks update-addon \
  --cluster-name my-cluster \
  --addon-name vpc-cni \
  --addon-version v1.12.2-eksbuild.1

# Delete add-on
aws eks delete-addon --cluster-name my-cluster --addon-name vpc-cni
```

## Amazon Elastic Container Service (ECS)

### Clusters
```bash
# Create cluster
aws ecs create-cluster --cluster-name my-ecs-cluster

# Create with capacity providers
aws ecs create-cluster \
  --cluster-name my-ecs-cluster \
  --capacity-providers FARGATE FARGATE_SPOT \
  --default-capacity-provider-strategy capacityProvider=FARGATE,weight=1

# List clusters
aws ecs list-clusters

# Describe cluster
aws ecs describe-clusters --clusters my-ecs-cluster

# Enable container insights
aws ecs update-cluster-settings \
  --cluster my-ecs-cluster \
  --settings name=containerInsights,value=enabled

# Delete cluster
aws ecs delete-cluster --cluster my-ecs-cluster
```

### Task Definitions
```bash
# Register task definition
aws ecs register-task-definition \
  --family web-app \
  --cpu 256 \
  --memory 512 \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --execution-role-arn arn:aws:iam::123456789012:role/ecsTaskExecutionRole \
  --container-definitions "[{\"name\":\"web\",\"image\":\"123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest\",\"essential\":true,\"portMappings\":[{\"containerPort\":80,\"hostPort\":80}]}]"

# List task definitions
aws ecs list-task-definitions

# Describe task definition
aws ecs describe-task-definition --task-definition web-app:1

# Deregister task definition
aws ecs deregister-task-definition --task-definition web-app:1
```

### Services
```bash
# Create service
aws ecs create-service \
  --cluster my-ecs-cluster \
  --service-name web-service \
  --task-definition web-app:1 \
  --desired-count 2 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-abc,subnet-def],securityGroups=[sg-123],assignPublicIp=ENABLED}" \
  --load-balancers "targetGroupArn=arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/web-tg/1234567890abcdef,containerName=web,containerPort=80"

# List services
aws ecs list-services --cluster my-ecs-cluster

# Update service
aws ecs update-service \
  --cluster my-ecs-cluster \
  --service web-service \
  --task-definition web-app:2 \
  --desired-count 3

# Delete service
aws ecs delete-service --cluster my-ecs-cluster --service web-service --force
```

### Tasks
```bash
# Run task
aws ecs run-task \
  --cluster my-ecs-cluster \
  --task-definition web-app:1 \
  --count 1 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-abc,subnet-def],securityGroups=[sg-123],assignPublicIp=ENABLED}"

# List tasks
aws ecs list-tasks --cluster my-ecs-cluster

# List running tasks
aws ecs list-tasks \
  --cluster my-ecs-cluster \
  --desired-status RUNNING

# Stop task
aws ecs stop-task --cluster my-ecs-cluster --task arn:aws:ecs:us-east-1:123456789012:task/my-ecs-cluster/1234567890abcdef
```

## Amazon Elastic Container Registry (ECR)

### Repositories
```bash
# Create repository
aws ecr create-repository --repository-name web-app

# Create repository with tags
aws ecr create-repository \
  --repository-name web-app \
  --tags Key=Project,Value=MyApp

# List repositories
aws ecr describe-repositories

# Delete repository
aws ecr delete-repository --repository-name web-app --force
```

### Images
```bash
# List images
aws ecr list-images --repository-name web-app

# Describe images
aws ecr describe-images --repository-name web-app

# Delete image
aws ecr batch-delete-image \
  --repository-name web-app \
  --image-ids imageTag=v1.0
```

### Authentication
```bash
# Get login password (for docker login)
aws ecr get-login-password --region us-east-1

# Full login command
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

### Lifecycle Policies
```bash
# Apply lifecycle policy
aws ecr put-lifecycle-policy \
  --repository-name web-app \
  --lifecycle-policy-text file://lifecycle-policy.json

# Delete lifecycle policy
aws ecr delete-lifecycle-policy --repository-name web-app
```

### Image Scanning
```bash
# Start image scan
aws ecr start-image-scan \
  --repository-name web-app \
  --image-id imageTag=latest

# Get scan findings
aws ecr describe-image-scan-findings \
  --repository-name web-app \
  --image-id imageTag=latest

# Configure scan on push
aws ecr put-image-scanning-configuration \
  --repository-name web-app \
  --image-scanning-configuration scanOnPush=true
```

## Common Workflows

### Build, Tag and Push to ECR
```bash
# Build Docker image
docker build -t web-app .

# Tag Docker image
docker tag web-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

# Push image to ECR
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest
```

### Resource Tagging
```bash
# Tag an EKS cluster
aws eks tag-resource \
  --resource-arn arn:aws:eks:us-east-1:123456789012:cluster/my-cluster \
  --tags Environment=Production,Team=DevOps

# Tag an ECS cluster
aws ecs tag-resource \
  --resource-arn arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster \
  --tags key=Environment,value=Production

# Tag an ECR repository
aws ecr tag-resource \
  --resource-arn arn:aws:ecr:us-east-1:123456789012:repository/web-app \
  --tags Key=Environment,Value=Production
```

### Resource Cleanup
```bash
# Basic EKS cleanup
aws eks delete-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup
aws eks wait nodegroup-deleted --cluster-name my-cluster --nodegroup-name my-nodegroup
aws eks delete-cluster --name my-cluster

# Basic ECS cleanup
aws ecs update-service --cluster my-ecs-cluster --service web-service --desired-count 0
aws ecs delete-service --cluster my-ecs-cluster --service web-service --force
aws ecs delete-cluster --cluster my-ecs-cluster

# Basic ECR cleanup
aws ecr batch-delete-image --repository-name web-app --image-ids "$(aws ecr list-images --repository-name web-app --query 'imageIds[*]' --output json)"
aws ecr delete-repository --repository-name web-app --force
```