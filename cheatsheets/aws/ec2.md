
# AWS CLI Commands for EC2 - Cheatsheet

This cheatsheet provides commonly used AWS CLI commands to manage EC2 resources including instances, volumes, security groups, key pairs, and more.

## 1. Instances

**Launch a new instance**
```
aws ec2 run-instances --image-id ami-xxxx --count 1 --instance-type t2.micro --key-name MyKey --security-groups MySecurityGroup
```

**List all instances**
```
aws ec2 describe-instances
```

**Start an instance**
```
aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

**Stop an instance**
```
aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

**Reboot an instance**
```
aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

**Terminate an instance**
```
aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx
```

## 2. AMIs (Amazon Machine Images)

**List all available AMIs**
```
aws ec2 describe-images --owners self amazon
```

**Create an AMI from an instance**
```
aws ec2 create-image --instance-id i-xxxxxxxxxxxxxxxxx --name "MyAMI"
```

## 3. Key Pairs

**Create a key pair**
```
aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem
```

**List key pairs**
```
aws ec2 describe-key-pairs
```

**Delete a key pair**
```
aws ec2 delete-key-pair --key-name MyKey
```

## 4. Security Groups

**Create a security group**
```
aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"
```

**Authorize inbound rule**
```
aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0
```

**List security groups**
```
aws ec2 describe-security-groups
```

**Delete a security group**
```
aws ec2 delete-security-group --group-name MySecurityGroup
```

## 5. Elastic IPs

**Allocate a new Elastic IP**
```
aws ec2 allocate-address
```

**Associate Elastic IP with an instance**
```
aws ec2 associate-address --instance-id i-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxx
```

**Release an Elastic IP**
```
aws ec2 release-address --allocation-id eipalloc-xxxxxxxx
```

## 6. Volumes and Snapshots

**Create a volume**
```
aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp2
```

**Attach a volume**
```
aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id i-xxxxxxxx --device /dev/sdf
```

**Detach a volume**
```
aws ec2 detach-volume --volume-id vol-xxxxxxxx
```

**Create a snapshot**
```
aws ec2 create-snapshot --volume-id vol-xxxxxxxx --description "My snapshot"
```

**Describe snapshots**
```
aws ec2 describe-snapshots --owner-ids self
```

## 7. Advanced Search Queries

**Find all instances with instance type t3.large**
```
aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large"
```

**Find all EBS volumes with size 25 GB**
```
aws ec2 describe-volumes \
  --filters "Name=size,Values=25"
```

**Find all AMIs with 'ubuntu' in the name (public AMIs)**
```
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=*ubuntu*"
```

**Find all AMIs with 'ubuntu' in the name (your own AMIs)**
```
aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=*ubuntu*"
```

**Example: Combine multiple filters (e.g., instance type and AZ)**
```
aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large" "Name=availability-zone,Values=us-east-1a"
```

## 8. Output Formats

**JSON Output**
```
aws ec2 describe-instances --output json
```
Returns all EC2 instance data in raw JSON. Useful for scripting or automation.

**Text Output**
```
aws ec2 describe-instances --output text
```
Returns a plain text, tab-separated format. Useful for quick command-line viewing.

**Table Output**
```
aws ec2 describe-instances --output table
```
Returns nicely formatted, human-readable table output. Useful for quick insights.

## 9. Using --query for Filtering Specific Fields

**Example: List only EC2 Instance IDs**
```
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
```
This retrieves only the InstanceId of all EC2 instances, skipping the rest of the metadata.

**Example: List Instance IDs and Types**
```
aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId, InstanceType]" \
  --output table
```
Outputs a table showing each instance's ID and its type.

**Example: Get running instance IDs only**
```
aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
```
Returns only running instance IDs.

## 10. Tagging Resources

**Add a tag to an EC2 instance**
```
aws ec2 create-tags \
  --resources i-xxxxxxxxxxxxxxxxx \
  --tags Key=Name,Value=MyServer
```

**Remove a tag from an EC2 instance**
```
aws ec2 delete-tags \
  --resources i-xxxxxxxxxxxxxxxxx \
  --tags Key=Name
```

## 11. Spot Instances

**Request a Spot instance**
```
aws ec2 request-spot-instances \
  --spot-price "0.03" \
  --instance-count 1 \
  --type "one-time" \
  --launch-specification file://config.json
```

**Cancel a Spot request**
```
aws ec2 cancel-spot-instance-requests \
  --spot-instance-request-ids sir-xxxxxxxx
```

## 12. Elastic Load Balancers

**List all Classic Load Balancers**
```
aws elb describe-load-balancers
```

**List all Application/Network Load Balancers (v2)**
```
aws elbv2 describe-load-balancers
```

**List listeners for a load balancer**
```
aws elbv2 describe-listeners --load-balancer-arn arn:aws:elasticloadbalancing:...
```

**Describe target groups**
```
aws elbv2 describe-target-groups
```