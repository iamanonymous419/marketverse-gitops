AWS CLI Commands for EC2

This README provides commonly used AWS CLI commands to manage EC2 resources including instances, volumes, security groups, key pairs, and more.


---

1. Instances

Launch a new instance

aws ec2 run-instances --image-id ami-xxxx --count 1 --instance-type t2.micro --key-name MyKey --security-groups MySecurityGroup

List all instances

aws ec2 describe-instances

Start an instance

aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Stop an instance

aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Reboot an instance

aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Terminate an instance

aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx


---

2. AMIs (Amazon Machine Images)

List all available AMIs

aws ec2 describe-images --owners self amazon

Create an AMI from an instance

aws ec2 create-image --instance-id i-xxxxxxxxxxxxxxxxx --name "MyAMI"


---

3. Key Pairs

Create a key pair

aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem

List key pairs

aws ec2 describe-key-pairs

Delete a key pair

aws ec2 delete-key-pair --key-name MyKey


---

4. Security Groups

Create a security group

aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"

Authorize inbound rule

aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0

List security groups

aws ec2 describe-security-groups

Delete a security group

aws ec2 delete-security-group --group-name MySecurityGroup


---

5. Elastic IPs

Allocate a new Elastic IP

aws ec2 allocate-address

Associate Elastic IP with an instance

aws ec2 associate-address --instance-id i-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxx

Release an Elastic IP

aws ec2 release-address --allocation-id eipalloc-xxxxxxxx


---

6. Volumes and Snapshots

Create a volume

aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp2

Attach a volume

aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id i-xxxxxxxx --device /dev/sdf

Detach a volume

aws ec2 detach-volume --volume-id vol-xxxxxxxx

Create a snapshot

aws ec2 create-snapshot --volume-id vol-xxxxxxxx --description "My snapshot"

Describe snapshots

aws ec2 describe-snapshots --owner-ids self



AWS CLI Commands for EC2

This README provides commonly used AWS CLI commands to manage EC2 resources including instances, volumes, security groups, key pairs, and more.


---

1. Instances

Launch a new instance

aws ec2 run-instances --image-id ami-xxxx --count 1 --instance-type t2.micro --key-name MyKey --security-groups MySecurityGroup

List all instances

aws ec2 describe-instances

Start an instance

aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Stop an instance

aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Reboot an instance

aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Terminate an instance

aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx


---

2. AMIs (Amazon Machine Images)

List all available AMIs

aws ec2 describe-images --owners self amazon

Create an AMI from an instance

aws ec2 create-image --instance-id i-xxxxxxxxxxxxxxxxx --name "MyAMI"


---

3. Key Pairs

Create a key pair

aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem

List key pairs

aws ec2 describe-key-pairs

Delete a key pair

aws ec2 delete-key-pair --key-name MyKey


---

4. Security Groups

Create a security group

aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"

Authorize inbound rule

aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0

List security groups

aws ec2 describe-security-groups

Delete a security group

aws ec2 delete-security-group --group-name MySecurityGroup


---

5. Elastic IPs

Allocate a new Elastic IP

aws ec2 allocate-address

Associate Elastic IP with an instance

aws ec2 associate-address --instance-id i-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxx

Release an Elastic IP

aws ec2 release-address --allocation-id eipalloc-xxxxxxxx


---

6. Volumes and Snapshots

Create a volume

aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp2

Attach a volume

aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id i-xxxxxxxx --device /dev/sdf

Detach a volume

aws ec2 detach-volume --volume-id vol-xxxxxxxx

Create a snapshot

aws ec2 create-snapshot --volume-id vol-xxxxxxxx --description "My snapshot"

Describe snapshots

aws ec2 describe-snapshots --owner-ids self


---

7. Advanced Search Queries

Find all instances with instance type t3.large

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large"

Find all EBS volumes with size 25 GB

aws ec2 describe-volumes \
  --filters "Name=size,Values=25"

Find all AMIs with 'ubuntu' in the name (public AMIs)

aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=*ubuntu*"

Find all AMIs with 'ubuntu' in the name (your own AMIs)

aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=*ubuntu*"

Example: Combine multiple filters (e.g., instance type and AZ)

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large" "Name=availability-zone,Values=us-east-1a"

Format output as table

aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name]' \
  --output table




AWS CLI Commands for EC2

This README provides commonly used AWS CLI commands to manage EC2 resources including instances, volumes, security groups, key pairs, and more.


---

1. Instances

Launch a new instance

aws ec2 run-instances --image-id ami-xxxx --count 1 --instance-type t2.micro --key-name MyKey --security-groups MySecurityGroup

List all instances

aws ec2 describe-instances

Start an instance

aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Stop an instance

aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Reboot an instance

aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Terminate an instance

aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx


---

2. AMIs (Amazon Machine Images)

List all available AMIs

aws ec2 describe-images --owners self amazon

Create an AMI from an instance

aws ec2 create-image --instance-id i-xxxxxxxxxxxxxxxxx --name "MyAMI"


---

3. Key Pairs

Create a key pair

aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem

List key pairs

aws ec2 describe-key-pairs

Delete a key pair

aws ec2 delete-key-pair --key-name MyKey


---

4. Security Groups

Create a security group

aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"

Authorize inbound rule

aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0

List security groups

aws ec2 describe-security-groups

Delete a security group

aws ec2 delete-security-group --group-name MySecurityGroup


---

5. Elastic IPs

Allocate a new Elastic IP

aws ec2 allocate-address

Associate Elastic IP with an instance

aws ec2 associate-address --instance-id i-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxx

Release an Elastic IP

aws ec2 release-address --allocation-id eipalloc-xxxxxxxx


---

6. Volumes and Snapshots

Create a volume

aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp2

Attach a volume

aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id i-xxxxxxxx --device /dev/sdf

Detach a volume

aws ec2 detach-volume --volume-id vol-xxxxxxxx

Create a snapshot

aws ec2 create-snapshot --volume-id vol-xxxxxxxx --description "My snapshot"

Describe snapshots

aws ec2 describe-snapshots --owner-ids self


---

7. Advanced Search Queries

Find all instances with instance type t3.large

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large"

Find all EBS volumes with size 25 GB

aws ec2 describe-volumes \
  --filters "Name=size,Values=25"

Find all AMIs with 'ubuntu' in the name (public AMIs)

aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=*ubuntu*"

Find all AMIs with 'ubuntu' in the name (your own AMIs)

aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=*ubuntu*"

Example: Combine multiple filters (e.g., instance type and AZ)

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large" "Name=availability-zone,Values=us-east-1a"


---

8. Output Formats

You can format output using the --output flag.

JSON Output

aws ec2 describe-instances --output json

Description: Returns all EC2 instance data in raw JSON. Useful for scripting or automation.

Text Output

aws ec2 describe-instances --output text

Description: Returns a plain text, tab-separated format. Useful for quick command-line viewing.

Table Output

aws ec2 describe-instances --output table

Description: Returns nicely formatted, human-readable table output. Useful for quick insights.


---

9. Using --query for Filtering Specific Fields

The --query flag uses JMESPath to extract specific parts of the output.

Example: List only EC2 Instance IDs

aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

Description: This retrieves only the InstanceId of all EC2 instances, skipping the rest of the metadata.

Example: List Instance IDs and Types

aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId, InstanceType]" \
  --output table

Description: Outputs a table showing each instance's ID and its type.

Example: Get running instance IDs only

aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

Description: Returns only running instance IDs.

JMESPath lets you fine-tune what data you want. You can pull nested values, filter, map, and format results precisely.


AWS CLI Commands for EC2

This README provides commonly used AWS CLI commands to manage EC2 resources including instances, volumes, security groups, key pairs, and more.


---

1. Instances

Launch a new instance

aws ec2 run-instances --image-id ami-xxxx --count 1 --instance-type t2.micro --key-name MyKey --security-groups MySecurityGroup

List all instances

aws ec2 describe-instances

Start an instance

aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Stop an instance

aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Reboot an instance

aws ec2 reboot-instances --instance-ids i-xxxxxxxxxxxxxxxxx

Terminate an instance

aws ec2 terminate-instances --instance-ids i-xxxxxxxxxxxxxxxxx


---

2. AMIs (Amazon Machine Images)

List all available AMIs

aws ec2 describe-images --owners self amazon

Create an AMI from an instance

aws ec2 create-image --instance-id i-xxxxxxxxxxxxxxxxx --name "MyAMI"


---

3. Key Pairs

Create a key pair

aws ec2 create-key-pair --key-name MyKey --query 'KeyMaterial' --output text > MyKey.pem

List key pairs

aws ec2 describe-key-pairs

Delete a key pair

aws ec2 delete-key-pair --key-name MyKey


---

4. Security Groups

Create a security group

aws ec2 create-security-group --group-name MySecurityGroup --description "My security group"

Authorize inbound rule

aws ec2 authorize-security-group-ingress --group-name MySecurityGroup --protocol tcp --port 22 --cidr 0.0.0.0/0

List security groups

aws ec2 describe-security-groups

Delete a security group

aws ec2 delete-security-group --group-name MySecurityGroup


---

5. Elastic IPs

Allocate a new Elastic IP

aws ec2 allocate-address

Associate Elastic IP with an instance

aws ec2 associate-address --instance-id i-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxx

Release an Elastic IP

aws ec2 release-address --allocation-id eipalloc-xxxxxxxx


---

6. Volumes and Snapshots

Create a volume

aws ec2 create-volume --availability-zone us-east-1a --size 8 --volume-type gp2

Attach a volume

aws ec2 attach-volume --volume-id vol-xxxxxxxx --instance-id i-xxxxxxxx --device /dev/sdf

Detach a volume

aws ec2 detach-volume --volume-id vol-xxxxxxxx

Create a snapshot

aws ec2 create-snapshot --volume-id vol-xxxxxxxx --description "My snapshot"

Describe snapshots

aws ec2 describe-snapshots --owner-ids self


---

7. Advanced Search Queries

Find all instances with instance type t3.large

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large"

Find all EBS volumes with size 25 GB

aws ec2 describe-volumes \
  --filters "Name=size,Values=25"

Find all AMIs with 'ubuntu' in the name (public AMIs)

aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=*ubuntu*"

Find all AMIs with 'ubuntu' in the name (your own AMIs)

aws ec2 describe-images \
  --owners self \
  --filters "Name=name,Values=*ubuntu*"

Example: Combine multiple filters (e.g., instance type and AZ)

aws ec2 describe-instances \
  --filters "Name=instance-type,Values=t3.large" "Name=availability-zone,Values=us-east-1a"


---

8. Output Formats

You can format output using the --output flag.

JSON Output

aws ec2 describe-instances --output json

Description: Returns all EC2 instance data in raw JSON. Useful for scripting or automation.

Text Output

aws ec2 describe-instances --output text

Description: Returns a plain text, tab-separated format. Useful for quick command-line viewing.

Table Output

aws ec2 describe-instances --output table

Description: Returns nicely formatted, human-readable table output. Useful for quick insights.


---

9. Using --query for Filtering Specific Fields

The --query flag uses JMESPath to extract specific parts of the output.

Example: List only EC2 Instance IDs

aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

Description: This retrieves only the InstanceId of all EC2 instances, skipping the rest of the metadata.

Example: List Instance IDs and Types

aws ec2 describe-instances \
  --query "Reservations[*].Instances[*].[InstanceId, InstanceType]" \
  --output table

Description: Outputs a table showing each instance's ID and its type.

Example: Get running instance IDs only

aws ec2 describe-instances \
  --filters "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text

Description: Returns only running instance IDs.

JMESPath lets you fine-tune what data you want. You can pull nested values, filter, map, and format results precisely.


---

10. Tagging Resources

Add a tag to an EC2 instance

aws ec2 create-tags \
  --resources i-xxxxxxxxxxxxxxxxx \
  --tags Key=Name,Value=MyServer

Remove a tag from an EC2 instance

aws ec2 delete-tags \
  --resources i-xxxxxxxxxxxxxxxxx \
  --tags Key=Name


---

11. Spot Instances

Request a Spot instance

aws ec2 request-spot-instances \
  --spot-price "0.03" \
  --instance-count 1 \
  --type "one-time" \
  --launch-specification file://config.json

Cancel a Spot request

aws ec2 cancel-spot-instance-requests \
  --spot-instance-request-ids sir-xxxxxxxx


---

12. Elastic Load Balancers

List all Classic Load Balancers

aws elb describe-load-balancers

List all Application/Network Load Balancers (v2)

aws elbv2 describe-load-balancers

List listeners for a load balancer

aws elbv2 describe-listeners --load-balancer-arn arn:aws:elasticloadbalancing:...

Describe target groups

aws elbv2 describe-target-groups


---




# AWS CLI Commands for S3

This README provides commonly used AWS CLI commands to manage S3 resources including buckets, objects, access control, versioning, and more.

---

## 1. Buckets

**Create a bucket**
```
aws s3 mb s3://bucket-name
```

**List all buckets**
```
aws s3 ls
```

**Delete an empty bucket**
```
aws s3 rb s3://bucket-name
```

**Delete a bucket and all its contents**
```
aws s3 rb s3://bucket-name --force
```

---

## 2. Objects

**Upload a file to a bucket**
```
aws s3 cp file.txt s3://bucket-name/
```

**Download a file from a bucket**
```
aws s3 cp s3://bucket-name/file.txt ./
```

**List objects in a bucket**
```
aws s3 ls s3://bucket-name/
```

**Delete an object**
```
aws s3 rm s3://bucket-name/file.txt
```

**Sync a local directory to a bucket**
```
aws s3 sync ./local-directory s3://bucket-name/prefix/
```

**Sync a bucket to a local directory**
```
aws s3 sync s3://bucket-name/prefix/ ./local-directory
```

---

## 3. Object Operations

**Copy an object between buckets**
```
aws s3 cp s3://source-bucket/file.txt s3://destination-bucket/
```

**Move an object (copy and delete original)**
```
aws s3 mv s3://source-bucket/file.txt s3://destination-bucket/
```

**Create a public URL for an object**
```
aws s3 presign s3://bucket-name/file.txt --expires-in 3600
```

**Get object metadata**
```
aws s3api head-object --bucket bucket-name --key file.txt
```

---

## 4. Access Control

**Set bucket policy**
```
aws s3api put-bucket-policy --bucket bucket-name --policy file://policy.json
```

**Get bucket policy**
```
aws s3api get-bucket-policy --bucket bucket-name
```

**Delete bucket policy**
```
aws s3api delete-bucket-policy --bucket bucket-name
```

**Make an object public**
```
aws s3api put-object-acl --bucket bucket-name --key file.txt --acl public-read
```

**Set private access for an object**
```
aws s3api put-object-acl --bucket bucket-name --key file.txt --acl private
```

---

## 5. Versioning

**Enable versioning on a bucket**
```
aws s3api put-bucket-versioning --bucket bucket-name --versioning-configuration Status=Enabled
```

**Disable versioning on a bucket**
```
aws s3api put-bucket-versioning --bucket bucket-name --versioning-configuration Status=Suspended
```

**List object versions**
```
aws s3api list-object-versions --bucket bucket-name
```

**Retrieve a specific version of an object**
```
aws s3api get-object --bucket bucket-name --key file.txt --version-id versionID output.txt
```

**Delete a specific version of an object**
```
aws s3api delete-object --bucket bucket-name --key file.txt --version-id versionID
```

---

## 6. Website Configuration

**Configure a bucket for static website hosting**
```
aws s3 website s3://bucket-name/ --index-document index.html --error-document error.html
```

**Get website configuration**
```
aws s3api get-bucket-website --bucket bucket-name
```

**Delete website configuration**
```
aws s3api delete-bucket-website --bucket bucket-name
```

---

## 7. Advanced Search and Operations

**Find all objects with a specific prefix**
```
aws s3 ls s3://bucket-name/prefix/ --recursive
```

**Find objects modified after a specific date**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[?LastModified>='2023-01-01'].{Key: Key, LastModified: LastModified}"
```

**Filter objects by size**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[?Size>`10240`].{Key: Key, Size: Size}"
```

**List objects with specific file extension**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[?ends_with(Key, '.pdf')].Key"
```

---

## 8. Output Formats

**JSON Output**
```
aws s3 ls s3://bucket-name/ --output json
```
Description: Returns all S3 object data in raw JSON. Useful for scripting or automation.

**Text Output**
```
aws s3 ls s3://bucket-name/ --output text
```
Description: Returns a plain text, tab-separated format. Useful for quick command-line viewing.

**Table Output**
```
aws s3 ls s3://bucket-name/ --output table
```
Description: Returns nicely formatted, human-readable table output. Useful for quick insights.

---

## 9. Using --query for Filtering

**List only object keys**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[].Key" --output text
```

**List keys and sizes in a table format**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[].[Key, Size]" --output table
```

**Get large objects (> 1MB)**
```
aws s3api list-objects-v2 --bucket bucket-name --query "Contents[?Size>`1048576`].[Key, Size]" --output table
```

---

## 10. Tagging

**Add tags to a bucket**
```
aws s3api put-bucket-tagging --bucket bucket-name --tagging 'TagSet=[{Key=Project,Value=Website},{Key=Environment,Value=Production}]'
```

**Add tags to an object**
```
aws s3api put-object-tagging --bucket bucket-name --key file.txt --tagging 'TagSet=[{Key=Status,Value=Approved}]'
```

**Get object tags**
```
aws s3api get-object-tagging --bucket bucket-name --key file.txt
```

**Delete object tags**
```
aws s3api delete-object-tagging --bucket bucket-name --key file.txt
```

---

## 11. Lifecycle Policies

**Set lifecycle configuration**
```
aws s3api put-bucket-lifecycle-configuration --bucket bucket-name --lifecycle-configuration file://lifecycle.json
```

**Get lifecycle configuration**
```
aws s3api get-bucket-lifecycle-configuration --bucket bucket-name
```

**Delete lifecycle configuration**
```
aws s3api delete-bucket-lifecycle --bucket bucket-name
```

---

## 12. Cross-Region Replication

**Enable replication**
```
aws s3api put-bucket-replication --bucket source-bucket --replication-configuration file://replication.json
```

**Get replication configuration**
```
aws s3api get-bucket-replication --bucket source-bucket
```

**Delete replication configuration**
```
aws s3api delete-bucket-replication --bucket source-bucket
```

---



# AWS CLI Commands for Networking

This README provides commonly used AWS CLI commands to manage AWS networking resources including VPCs, subnets, route tables, internet gateways, NAT gateways, and more.

---

## 1. Virtual Private Cloud (VPC)

**Create a VPC**
```
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=MyVPC}]'
```

**List all VPCs**
```
aws ec2 describe-vpcs
```

**Describe a specific VPC**
```
aws ec2 describe-vpcs --vpc-ids vpc-xxxxxxxxxxxxxxxxx
```

**Delete a VPC**
```
aws ec2 delete-vpc --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**Modify VPC attributes (Enable DNS hostnames)**
```
aws ec2 modify-vpc-attribute --vpc-id vpc-xxxxxxxxxxxxxxxxx --enable-dns-hostnames
```

**Modify VPC attributes (Enable DNS support)**
```
aws ec2 modify-vpc-attribute --vpc-id vpc-xxxxxxxxxxxxxxxxx --enable-dns-support
```

---

## 2. Subnets

**Create a subnet**
```
aws ec2 create-subnet --vpc-id vpc-xxxxxxxxxxxxxxxxx --cidr-block 10.0.1.0/24 --availability-zone us-east-1a --tag-specifications 'ResourceType=subnet,Tags=[{Key=Name,Value=PublicSubnet1}]'
```

**List all subnets**
```
aws ec2 describe-subnets
```

**List subnets in a specific VPC**
```
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxxxxxxxxxxxxxxxx"
```

**Modify a subnet (Enable auto-assign public IP)**
```
aws ec2 modify-subnet-attribute --subnet-id subnet-xxxxxxxxxxxxxxxxx --map-public-ip-on-launch
```

**Delete a subnet**
```
aws ec2 delete-subnet --subnet-id subnet-xxxxxxxxxxxxxxxxx
```

---

## 3. Internet Gateways

**Create an internet gateway**
```
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=MyIGW}]'
```

**List all internet gateways**
```
aws ec2 describe-internet-gateways
```

**Attach an internet gateway to a VPC**
```
aws ec2 attach-internet-gateway --internet-gateway-id igw-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**Detach an internet gateway from a VPC**
```
aws ec2 detach-internet-gateway --internet-gateway-id igw-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**Delete an internet gateway**
```
aws ec2 delete-internet-gateway --internet-gateway-id igw-xxxxxxxxxxxxxxxxx
```

---

## 4. Route Tables

**Create a route table**
```
aws ec2 create-route-table --vpc-id vpc-xxxxxxxxxxxxxxxxx --tag-specifications 'ResourceType=route-table,Tags=[{Key=Name,Value=PublicRouteTable}]'
```

**List all route tables**
```
aws ec2 describe-route-tables
```

**List route tables for a specific VPC**
```
aws ec2 describe-route-tables --filters "Name=vpc-id,Values=vpc-xxxxxxxxxxxxxxxxx"
```

**Create a route (Add internet gateway route)**
```
aws ec2 create-route --route-table-id rtb-xxxxxxxxxxxxxxxxx --destination-cidr-block 0.0.0.0/0 --gateway-id igw-xxxxxxxxxxxxxxxxx
```

**Associate a subnet with a route table**
```
aws ec2 associate-route-table --route-table-id rtb-xxxxxxxxxxxxxxxxx --subnet-id subnet-xxxxxxxxxxxxxxxxx
```

**Disassociate a subnet from a route table**
```
aws ec2 disassociate-route-table --association-id rtbassoc-xxxxxxxxxxxxxxxxx
```

**Delete a route**
```
aws ec2 delete-route --route-table-id rtb-xxxxxxxxxxxxxxxxx --destination-cidr-block 0.0.0.0/0
```

**Delete a route table**
```
aws ec2 delete-route-table --route-table-id rtb-xxxxxxxxxxxxxxxxx
```

---

## 5. NAT Gateways

**Create a NAT gateway**
```
aws ec2 create-nat-gateway --subnet-id subnet-xxxxxxxxxxxxxxxxx --allocation-id eipalloc-xxxxxxxxxxxxxxxxx --tag-specifications 'ResourceType=natgateway,Tags=[{Key=Name,Value=MyNATGateway}]'
```

**List all NAT gateways**
```
aws ec2 describe-nat-gateways
```

**Delete a NAT gateway**
```
aws ec2 delete-nat-gateway --nat-gateway-id nat-xxxxxxxxxxxxxxxxx
```

**Add a route through NAT gateway**
```
aws ec2 create-route --route-table-id rtb-xxxxxxxxxxxxxxxxx --destination-cidr-block 0.0.0.0/0 --nat-gateway-id nat-xxxxxxxxxxxxxxxxx
```

---

## 6. Network ACLs

**Create a network ACL**
```
aws ec2 create-network-acl --vpc-id vpc-xxxxxxxxxxxxxxxxx --tag-specifications 'ResourceType=network-acl,Tags=[{Key=Name,Value=MyNACL}]'
```

**List all network ACLs**
```
aws ec2 describe-network-acls
```

**Create an inbound rule**
```
aws ec2 create-network-acl-entry --network-acl-id acl-xxxxxxxxxxxxxxxxx --rule-number 100 --protocol tcp --port-range From=22,To=22 --cidr-block 0.0.0.0/0 --rule-action allow --ingress
```

**Create an outbound rule**
```
aws ec2 create-network-acl-entry --network-acl-id acl-xxxxxxxxxxxxxxxxx --rule-number 100 --protocol -1 --cidr-block 0.0.0.0/0 --rule-action allow --egress
```

**Associate a network ACL with a subnet**
```
aws ec2 replace-network-acl-association --association-id aclassoc-xxxxxxxxxxxxxxxxx --network-acl-id acl-xxxxxxxxxxxxxxxxx
```

**Delete a network ACL entry**
```
aws ec2 delete-network-acl-entry --network-acl-id acl-xxxxxxxxxxxxxxxxx --rule-number 100 --egress
```

**Delete a network ACL**
```
aws ec2 delete-network-acl --network-acl-id acl-xxxxxxxxxxxxxxxxx
```

---

## 7. Security Groups

**Create a security group for a VPC**
```
aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id vpc-xxxxxxxxxxxxxxxxx --tag-specifications 'ResourceType=security-group,Tags=[{Key=Name,Value=MySecurityGroup}]'
```

**Add an inbound rule**
```
aws ec2 authorize-security-group-ingress --group-id sg-xxxxxxxxxxxxxxxxx --protocol tcp --port 22 --cidr 0.0.0.0/0
```

**Add an outbound rule**
```
aws ec2 authorize-security-group-egress --group-id sg-xxxxxxxxxxxxxxxxx --protocol tcp --port 443 --cidr 0.0.0.0/0
```

**List security groups in a VPC**
```
aws ec2 describe-security-groups --filters "Name=vpc-id,Values=vpc-xxxxxxxxxxxxxxxxx"
```

**Remove an inbound rule**
```
aws ec2 revoke-security-group-ingress --group-id sg-xxxxxxxxxxxxxxxxx --protocol tcp --port 22 --cidr 0.0.0.0/0
```

**Delete a security group**
```
aws ec2 delete-security-group --group-id sg-xxxxxxxxxxxxxxxxx
```

---

## 8. VPC Endpoints

**Create a gateway VPC endpoint (for S3)**
```
aws ec2 create-vpc-endpoint --vpc-id vpc-xxxxxxxxxxxxxxxxx --service-name com.amazonaws.us-east-1.s3 --route-table-ids rtb-xxxxxxxxxxxxxxxxx
```

**Create an interface VPC endpoint**
```
aws ec2 create-vpc-endpoint --vpc-id vpc-xxxxxxxxxxxxxxxxx --service-name com.amazonaws.us-east-1.sqs --vpc-endpoint-type Interface --subnet-ids subnet-xxxxxxxxxxxxxxxxx --security-group-ids sg-xxxxxxxxxxxxxxxxx
```

**List all VPC endpoints**
```
aws ec2 describe-vpc-endpoints
```

**Modify a VPC endpoint**
```
aws ec2 modify-vpc-endpoint --vpc-endpoint-id vpce-xxxxxxxxxxxxxxxxx --add-route-table-ids rtb-yyyyyyyyyyyyyyyyy
```

**Delete a VPC endpoint**
```
aws ec2 delete-vpc-endpoints --vpc-endpoint-ids vpce-xxxxxxxxxxxxxxxxx
```

---

## 9. Transit Gateways

**Create a transit gateway**
```
aws ec2 create-transit-gateway --description "My Transit Gateway" --options "AmazonSideAsn=64512,AutoAcceptSharedAttachments=disable,DefaultRouteTableAssociation=enable,DefaultRouteTablePropagation=enable,VpnEcmpSupport=enable,DnsSupport=enable"
```

**Create a transit gateway VPC attachment**
```
aws ec2 create-transit-gateway-vpc-attachment --transit-gateway-id tgw-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx --subnet-ids subnet-xxxxxxxxxxxxxxxxx
```

**List all transit gateways**
```
aws ec2 describe-transit-gateways
```

**List transit gateway attachments**
```
aws ec2 describe-transit-gateway-attachments
```

**Delete a transit gateway attachment**
```
aws ec2 delete-transit-gateway-vpc-attachment --transit-gateway-attachment-id tgw-attach-xxxxxxxxxxxxxxxxx
```

**Delete a transit gateway**
```
aws ec2 delete-transit-gateway --transit-gateway-id tgw-xxxxxxxxxxxxxxxxx
```

---

## 10. VPC Peering

**Create a VPC peering connection**
```
aws ec2 create-vpc-peering-connection --vpc-id vpc-xxxxxxxxxxxxxxxxx --peer-vpc-id vpc-yyyyyyyyyyyyyyyyy
```

**Accept a VPC peering connection**
```
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-xxxxxxxxxxxxxxxxx
```

**List all VPC peering connections**
```
aws ec2 describe-vpc-peering-connections
```

**Create a route for VPC peering**
```
aws ec2 create-route --route-table-id rtb-xxxxxxxxxxxxxxxxx --destination-cidr-block 10.1.0.0/16 --vpc-peering-connection-id pcx-xxxxxxxxxxxxxxxxx
```

**Delete a VPC peering connection**
```
aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id pcx-xxxxxxxxxxxxxxxxx
```

---

## 11. VPN Connections

**Create a customer gateway**
```
aws ec2 create-customer-gateway --type ipsec.1 --public-ip 203.0.113.1 --bgp-asn 65000
```

**Create a virtual private gateway**
```
aws ec2 create-vpn-gateway --type ipsec.1
```

**Attach a virtual private gateway to a VPC**
```
aws ec2 attach-vpn-gateway --vpn-gateway-id vgw-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**Create a VPN connection**
```
aws ec2 create-vpn-connection --type ipsec.1 --customer-gateway-id cgw-xxxxxxxxxxxxxxxxx --vpn-gateway-id vgw-xxxxxxxxxxxxxxxxx
```

**List all VPN connections**
```
aws ec2 describe-vpn-connections
```

**Delete a VPN connection**
```
aws ec2 delete-vpn-connection --vpn-connection-id vpn-xxxxxxxxxxxxxxxxx
```

**Detach a virtual private gateway**
```
aws ec2 detach-vpn-gateway --vpn-gateway-id vgw-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**Delete a virtual private gateway**
```
aws ec2 delete-vpn-gateway --vpn-gateway-id vgw-xxxxxxxxxxxxxxxxx
```

**Delete a customer gateway**
```
aws ec2 delete-customer-gateway --customer-gateway-id cgw-xxxxxxxxxxxxxxxxx
```

---

## 12. Advanced Queries and Operations

**Find public subnets in a VPC**
```
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxxxxxxxxxxxxxxxx" "Name=map-public-ip-on-launch,Values=true" --query "Subnets[*].{SubnetId:SubnetId,CIDR:CidrBlock,AZ:AvailabilityZone}"
```

**Find VPCs without internet gateways**
```
aws ec2 describe-vpcs --query "Vpcs[?not_null(Tags[?Key=='Name'].Value|[0])]" | jq -r '.[] | .VpcId + " " + (.Tags[] | select(.Key=="Name") | .Value)' | while read vpc name; do if [[ -z $(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$vpc" --query 'InternetGateways[*]' --output text) ]]; then echo "VPC $vpc ($name) has no IGW"; fi; done
```

**List all route tables with routes to internet gateway**
```
aws ec2 describe-route-tables --query "RouteTables[?Routes[?GatewayId && starts_with(GatewayId, 'igw-')]].{RouteTableId:RouteTableId,VpcId:VpcId}"
```

**List security groups with open SSH access (port 22)**
```
aws ec2 describe-security-groups --filters "Name=ip-permission.from-port,Values=22" "Name=ip-permission.to-port,Values=22" --query "SecurityGroups[*].{GroupId:GroupId,VpcId:VpcId,Name:GroupName,OpenPorts:IpPermissions[?ToPort==\`22\`]}"
```

**Find unused security groups**
```
aws ec2 describe-security-groups --query "SecurityGroups[?length(IpPermissions)==\`0\` && length(IpPermissionsEgress)==\`1\` && IpPermissionsEgress[0].IpProtocol=='-1' && IpPermissionsEgress[0].IpRanges[0].CidrIp=='0.0.0.0/0'].GroupId"
```

---

## 13. Tags for Network Resources

**Add tags to a VPC**
```
aws ec2 create-tags --resources vpc-xxxxxxxxxxxxxxxxx --tags Key=Environment,Value=Production
```

**Add tags to multiple resources at once**
```
aws ec2 create-tags --resources vpc-xxxxxxxxxxxxxxxxx subnet-xxxxxxxxxxxxxxxxx rtb-xxxxxxxxxxxxxxxxx --tags Key=Project,Value=NetworkRedesign
```

**List resources by tag**
```
aws ec2 describe-vpcs --filters "Name=tag:Environment,Values=Production"
```

**Delete tags**
```
aws ec2 delete-tags --resources vpc-xxxxxxxxxxxxxxxxx --tags Key=Temporary
```

---

## 14. DHCP Options Sets

**Create a DHCP options set**
```
aws ec2 create-dhcp-options --dhcp-configurations "Key=domain-name-servers,Values=8.8.8.8,8.8.4.4" "Key=domain-name,Values=example.com"
```

**Associate DHCP options with a VPC**
```
aws ec2 associate-dhcp-options --dhcp-options-id dopt-xxxxxxxxxxxxxxxxx --vpc-id vpc-xxxxxxxxxxxxxxxxx
```

**List DHCP options sets**
```
aws ec2 describe-dhcp-options
```

**Delete a DHCP options set**
```
aws ec2 delete-dhcp-options --dhcp-options-id dopt-xxxxxxxxxxxxxxxxx
```

---

## 15. Flow Logs

**Create a VPC flow log (to CloudWatch Logs)**
```
aws ec2 create-flow-logs --resource-type VPC --resource-ids vpc-xxxxxxxxxxxxxxxxx --traffic-type ALL --log-destination-type cloud-watch-logs --log-destination "arn:aws:logs:region:account-id:log-group:my-flow-logs" --deliver-logs-permission-arn "arn:aws:iam::account-id:role/FlowLogsRole"
```

**Create a VPC flow log (to S3)**
```
aws ec2 create-flow-logs --resource-type VPC --resource-ids vpc-xxxxxxxxxxxxxxxxx --traffic-type ALL --log-destination-type s3 --log-destination "arn:aws:s3:::my-bucket/flow-logs/"
```

**List flow logs**
```
aws ec2 describe-flow-logs
```

**Delete flow logs**
```
aws ec2 delete-flow-logs --flow-log-ids fl-xxxxxxxxxxxxxxxxx
```

---

## 16. Network Interface (ENI)

**Create a network interface**
```
aws ec2 create-network-interface --subnet-id subnet-xxxxxxxxxxxxxxxxx --description "My network interface" --groups sg-xxxxxxxxxxxxxxxxx --private-ip-address 10.0.1.17
```

**Attach a network interface to an instance**
```
aws ec2 attach-network-interface --network-interface-id eni-xxxxxxxxxxxxxxxxx --instance-id i-xxxxxxxxxxxxxxxxx --device-index 1
```

**List network interfaces**
```
aws ec2 describe-network-interfaces
```

**Modify a network interface attribute**
```
aws ec2 modify-network-interface-attribute --network-interface-id eni-xxxxxxxxxxxxxxxxx --description "Updated description"
```

**Detach a network interface**
```
aws ec2 detach-network-interface --attachment-id eni-attach-xxxxxxxxxxxxxxxxx --force
```

**Delete a network interface**
```
aws ec2 delete-network-interface --network-interface-id eni-xxxxxxxxxxxxxxxxx
```


# AWS CLI Commands for Container Services (EKS, ECS, and ECR)

This README provides commonly used AWS CLI commands to manage container services including Amazon Elastic Kubernetes Service (EKS), Elastic Container Service (ECS), and Elastic Container Registry (ECR).

---

## 1. Amazon Elastic Kubernetes Service (EKS)

### Clusters

**Create an EKS cluster**
```
aws eks create-cluster \
  --name my-cluster \
  --role-arn arn:aws:iam::123456789012:role/eks-cluster-role \
  --resources-vpc-config subnetIds=subnet-abcdef0123456789a,subnet-abcdef0123456789b,securityGroupIds=sg-abcdef01234567890 \
  --kubernetes-version 1.28
```

**List all EKS clusters**
```
aws eks list-clusters
```

**Describe an EKS cluster**
```
aws eks describe-cluster --name my-cluster
```

**Update a cluster version**
```
aws eks update-cluster-version --name my-cluster --kubernetes-version 1.29
```

**Update cluster configuration**
```
aws eks update-cluster-config \
  --name my-cluster \
  --resources-vpc-config endpointPublicAccess=true,endpointPrivateAccess=true
```

**Delete an EKS cluster**
```
aws eks delete-cluster --name my-cluster
```

### Node Groups

**Create a managed node group**
```
aws eks create-nodegroup \
  --cluster-name my-cluster \
  --nodegroup-name my-nodegroup \
  --subnets subnet-abcdef0123456789a subnet-abcdef0123456789b \
  --node-role arn:aws:iam::123456789012:role/eks-node-role \
  --scaling-config minSize=2,maxSize=5,desiredSize=3 \
  --instance-types t3.medium
```

**List node groups in a cluster**
```
aws eks list-nodegroups --cluster-name my-cluster
```

**Describe a node group**
```
aws eks describe-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup
```

**Update a node group**
```
aws eks update-nodegroup-config \
  --cluster-name my-cluster \
  --nodegroup-name my-nodegroup \
  --scaling-config minSize=3,maxSize=6,desiredSize=3
```

**Delete a node group**
```
aws eks delete-nodegroup --cluster-name my-cluster --nodegroup-name my-nodegroup
```

### Access Management

**Update cluster access entry (RBAC)**
```
aws eks create-access-entry \
  --cluster-name my-cluster \
  --principal-arn arn:aws:iam::123456789012:role/developer-role \
  --type STANDARD
```

**Associate access policy to principal**
```
aws eks associate-access-policy \
  --cluster-name my-cluster \
  --principal-arn arn:aws:iam::123456789012:role/developer-role \
  --policy-arn arn:aws:eks::aws:cluster-access-policy/AmazonEKSViewPolicy
```

**List access entries**
```
aws eks list-access-entries --cluster-name my-cluster
```

**Delete access entry**
```
aws eks delete-access-entry \
  --cluster-name my-cluster \
  --principal-arn arn:aws:iam::123456789012:role/developer-role
```

**Update kubeconfig for kubectl access**
```
aws eks update-kubeconfig --name my-cluster --region us-east-1
```

### Add-ons

**Create an add-on**
```
aws eks create-addon \
  --cluster-name my-cluster \
  --addon-name vpc-cni \
  --addon-version v1.12.0-eksbuild.1
```

**List available add-ons**
```
aws eks list-addons --cluster-name my-cluster
```

**Describe an add-on**
```
aws eks describe-addon --cluster-name my-cluster --addon-name vpc-cni
```

**Update an add-on**
```
aws eks update-addon \
  --cluster-name my-cluster \
  --addon-name vpc-cni \
  --addon-version v1.12.2-eksbuild.1
```

**Delete an add-on**
```
aws eks delete-addon --cluster-name my-cluster --addon-name vpc-cni
```

---

## 2. Amazon Elastic Container Service (ECS)

### Clusters

**Create an ECS cluster**
```
aws ecs create-cluster --cluster-name my-ecs-cluster
```

**Create a cluster with capacity providers**
```
aws ecs create-cluster \
  --cluster-name my-ecs-cluster \
  --capacity-providers FARGATE FARGATE_SPOT \
  --default-capacity-provider-strategy capacityProvider=FARGATE,weight=1
```

**List all ECS clusters**
```
aws ecs list-clusters
```

**Describe an ECS cluster**
```
aws ecs describe-clusters --clusters my-ecs-cluster
```

**Update a cluster**
```
aws ecs update-cluster-settings \
  --cluster my-ecs-cluster \
  --settings name=containerInsights,value=enabled
```

**Delete an ECS cluster**
```
aws ecs delete-cluster --cluster my-ecs-cluster
```

### Task Definitions

**Register a task definition**
```
aws ecs register-task-definition \
  --family web-app \
  --cpu 256 \
  --memory 512 \
  --network-mode awsvpc \
  --requires-compatibilities FARGATE \
  --execution-role-arn arn:aws:iam::123456789012:role/ecsTaskExecutionRole \
  --container-definitions "[{\"name\":\"web\",\"image\":\"123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest\",\"essential\":true,\"portMappings\":[{\"containerPort\":80,\"hostPort\":80,\"protocol\":\"tcp\"}]}]"
```

**List task definitions**
```
aws ecs list-task-definitions
```

**Describe a task definition**
```
aws ecs describe-task-definition --task-definition web-app:1
```

**Deregister a task definition**
```
aws ecs deregister-task-definition --task-definition web-app:1
```

### Services

**Create a service**
```
aws ecs create-service \
  --cluster my-ecs-cluster \
  --service-name web-service \
  --task-definition web-app:1 \
  --desired-count 2 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-abcdef0123456789a,subnet-abcdef0123456789b],securityGroups=[sg-abcdef01234567890],assignPublicIp=ENABLED}" \
  --load-balancers "targetGroupArn=arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/web-tg/1234567890abcdef,containerName=web,containerPort=80"
```

**List services**
```
aws ecs list-services --cluster my-ecs-cluster
```

**Describe services**
```
aws ecs describe-services --cluster my-ecs-cluster --services web-service
```

**Update a service**
```
aws ecs update-service \
  --cluster my-ecs-cluster \
  --service web-service \
  --task-definition web-app:2 \
  --desired-count 3
```

**Delete a service**
```
aws ecs delete-service --cluster my-ecs-cluster --service web-service --force
```

### Tasks

**Run a task**
```
aws ecs run-task \
  --cluster my-ecs-cluster \
  --task-definition web-app:1 \
  --count 1 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[subnet-abcdef0123456789a,subnet-abcdef0123456789b],securityGroups=[sg-abcdef01234567890],assignPublicIp=ENABLED}"
```

**List tasks**
```
aws ecs list-tasks --cluster my-ecs-cluster
```

**Describe tasks**
```
aws ecs describe-tasks --cluster my-ecs-cluster --tasks arn:aws:ecs:us-east-1:123456789012:task/my-ecs-cluster/1234567890abcdef
```

**Stop a task**
```
aws ecs stop-task --cluster my-ecs-cluster --task arn:aws:ecs:us-east-1:123456789012:task/my-ecs-cluster/1234567890abcdef
```

### Capacity Providers

**Create capacity provider (for EC2)**
```
aws ecs create-capacity-provider \
  --name my-capacity-provider \
  --auto-scaling-group-provider "autoScalingGroupArn=arn:aws:autoscaling:us-east-1:123456789012:autoScalingGroup:1234567890abcdef:autoScalingGroupName/my-asg,managedScaling={status=ENABLED,targetCapacity=80},managedTerminationProtection=ENABLED"
```

**Describe capacity providers**
```
aws ecs describe-capacity-providers --capacity-providers my-capacity-provider
```

**Put cluster capacity providers**
```
aws ecs put-cluster-capacity-providers \
  --cluster my-ecs-cluster \
  --capacity-providers FARGATE FARGATE_SPOT my-capacity-provider \
  --default-capacity-provider-strategy "capacityProvider=FARGATE,weight=1"
```

### Logging and Monitoring

**Enable CloudWatch Container Insights**
```
aws ecs update-cluster-settings \
  --cluster my-ecs-cluster \
  --settings name=containerInsights,value=enabled
```

**Describe task logs using AWS CloudWatch**
```
aws logs get-log-events \
  --log-group-name /ecs/web-app \
  --log-stream-name ecs/web/1234567890abcdef
```

---

## 3. Amazon Elastic Container Registry (ECR)

### Repositories

**Create a repository**
```
aws ecr create-repository --repository-name web-app
```

**Create a repository with tags**
```
aws ecr create-repository \
  --repository-name web-app \
  --tags Key=Project,Value=MyApp
```

**List repositories**
```
aws ecr describe-repositories
```

**Describe a specific repository**
```
aws ecr describe-repositories --repository-names web-app
```

**Delete a repository**
```
aws ecr delete-repository --repository-name web-app --force
```

### Images

**List images in a repository**
```
aws ecr list-images --repository-name web-app
```

**Describe images**
```
aws ecr describe-images --repository-name web-app
```

**Tag an image**
```
aws ecr put-image \
  --repository-name web-app \
  --image-manifest "{\"image-manifest\":\"content\"}" \
  --image-tag v1.0
```

**Delete an image**
```
aws ecr batch-delete-image \
  --repository-name web-app \
  --image-ids imageTag=v1.0
```

### Authentication

**Get login password for Docker (for use with docker login)**
```
aws ecr get-login-password --region us-east-1
```

**Full login command for Docker**
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

### Lifecycle Policies

**Apply a lifecycle policy to a repository**
```
aws ecr put-lifecycle-policy \
  --repository-name web-app \
  --lifecycle-policy-text file://lifecycle-policy.json
```

**Get the lifecycle policy for a repository**
```
aws ecr get-lifecycle-policy --repository-name web-app
```

**Delete the lifecycle policy for a repository**
```
aws ecr delete-lifecycle-policy --repository-name web-app
```

### Image Scanning

**Start image scan**
```
aws ecr start-image-scan \
  --repository-name web-app \
  --image-id imageTag=latest
```

**Get scan findings**
```
aws ecr describe-image-scan-findings \
  --repository-name web-app \
  --image-id imageTag=latest
```

**Configure scan on push**
```
aws ecr put-image-scanning-configuration \
  --repository-name web-app \
  --image-scanning-configuration scanOnPush=true
```

### Repository Policies

**Set a repository policy**
```
aws ecr set-repository-policy \
  --repository-name web-app \
  --policy-text file://repository-policy.json
```

**Get repository policy**
```
aws ecr get-repository-policy --repository-name web-app
```

**Delete repository policy**
```
aws ecr delete-repository-policy --repository-name web-app
```

### Cross-Region Replication

**Create replication configuration**
```
aws ecr put-replication-configuration \
  --replication-configuration "rules=[{destinations=[{region=us-west-2}]}]"
```

**Get replication configuration**
```
aws ecr describe-registry
```

### Pull Through Cache

**Create a pull through cache rule**
```
aws ecr create-pull-through-cache-rule \
  --ecr-repository-prefix k8s \
  --upstream-registry-url registry.k8s.io \
  --credential-arn arn:aws:secretsmanager:us-east-1:123456789012:secret:my-registry-credentials
```

**List pull through cache rules**
```
aws ecr describe-pull-through-cache-rules
```

**Delete a pull through cache rule**
```
aws ecr delete-pull-through-cache-rule --ecr-repository-prefix k8s
```

---

## 4. Common Operations and Workflows

### EKS and ECR Integration

**Build, tag and push an image to ECR for use with EKS**
```
# Build the Docker image
docker build -t web-app .

# Tag the Docker image
docker tag web-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest

# Login to ECR
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

# Push the image to ECR
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest

# Create Kubernetes deployment that uses the ECR image
kubectl apply -f deployment.yaml
```

### ECS and ECR Integration

**Create ECS task definition with ECR image**
```
aws ecs register-task-definition \
  --family web-app \
  --container-definitions "[{\"name\":\"web\",\"image\":\"123456789012.dkr.ecr.us-east-1.amazonaws.com/web-app:latest\",\"essential\":true}]"
```

### Advanced Queries and Operations

**Find ECS tasks by status**
```
aws ecs list-tasks \
  --cluster my-ecs-cluster \
  --desired-status RUNNING
```

**List EKS clusters with a specific Kubernetes version**
```
aws eks list-clusters | jq -r '.clusters[]' | while read cluster; do
  version=$(aws eks describe-cluster --name $cluster --query 'cluster.version' --output text)
  if [[ "$version" == "1.28" ]]; then
    echo "$cluster is running Kubernetes 1.28"
  fi
done
```

**Find ECR images older than 90 days**
```
aws ecr describe-images \
  --repository-name web-app \
  --query 'imageDetails[?imagePushedAt < `'"$(date -d '90 days ago' +'%Y-%m-%dT%H:%M:%S')"'`].imageDigest'
```

---

## 5. Tagging Resources

**Tag an EKS cluster**
```
aws eks tag-resource \
  --resource-arn arn:aws:eks:us-east-1:123456789012:cluster/my-cluster \
  --tags Environment=Production,Team=DevOps
```

**Tag an ECS cluster**
```
aws ecs tag-resource \
  --resource-arn arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster \
  --tags key=Environment,value=Production
```

**Tag an ECR repository**
```
aws ecr tag-resource \
  --resource-arn arn:aws:ecr:us-east-1:123456789012:repository/web-app \
  --tags Key=Environment,Value=Production
```

**List tags for an EKS cluster**
```
aws eks list-tags-for-resource \
  --resource-arn arn:aws:eks:us-east-1:123456789012:cluster/my-cluster
```

**List tags for an ECS resource**
```
aws ecs list-tags-for-resource \
  --resource-arn arn:aws:ecs:us-east-1:123456789012:cluster/my-ecs-cluster
```

**Untag a resource**
```
aws eks untag-resource \
  --resource-arn arn:aws:eks:us-east-1:123456789012:cluster/my-cluster \
  --tag-keys Environment
```

---

## 6. Resource Cleanup

**EKS Full Cleanup Script**
```
#!/bin/bash
CLUSTER_NAME="my-cluster"

# Delete all node groups
for ng in $(aws eks list-nodegroups --cluster-name $CLUSTER_NAME --query 'nodegroups[]' --output text); do
  echo "Deleting node group $ng..."
  aws eks delete-nodegroup --cluster-name $CLUSTER_NAME --nodegroup-name $ng
  aws eks wait nodegroup-deleted --cluster-name $CLUSTER_NAME --nodegroup-name $ng
done

# Delete all addons
for addon in $(aws eks list-addons --cluster-name $CLUSTER_NAME --query 'addons[]' --output text); do
  echo "Deleting addon $addon..."
  aws eks delete-addon --cluster-name $CLUSTER_NAME --addon-name $addon
done

# Delete the cluster
echo "Deleting cluster $CLUSTER_NAME..."
aws eks delete-cluster --name $CLUSTER_NAME
aws eks wait cluster-deleted --name $CLUSTER_NAME

echo "EKS cluster $CLUSTER_NAME and all resources have been deleted."
```

**ECS Full Cleanup Script**
```
#!/bin/bash
CLUSTER_NAME="my-ecs-cluster"

# Delete all services
for service in $(aws ecs list-services --cluster $CLUSTER_NAME --query 'serviceArns[]' --output text); do
  echo "Scaling down service $service..."
  aws ecs update-service --cluster $CLUSTER_NAME --service $service --desired-count 0
  echo "Deleting service $service..."
  aws ecs delete-service --cluster $CLUSTER_NAME --service $service --force
done

# Stop all tasks
for task in $(aws ecs list-tasks --cluster $CLUSTER_NAME --query 'taskArns[]' --output text); do
  echo "Stopping task $task..."
  aws ecs stop-task --cluster $CLUSTER_NAME --task $task
done

# Delete the cluster
echo "Deleting cluster $CLUSTER_NAME..."
aws ecs delete-cluster --cluster $CLUSTER_NAME

echo "ECS cluster $CLUSTER_NAME and all resources have been deleted."
```

**ECR Full Cleanup Script**
```
#!/bin/bash
REPOSITORY_NAME="web-app"

# Delete all images in the repository
echo "Deleting all images in repository $REPOSITORY_NAME..."
aws ecr batch-delete-image \
  --repository-name $REPOSITORY_NAME \
  --image-ids "$(aws ecr list-images --repository-name $REPOSITORY_NAME --query 'imageIds[*]' --output json)" \
  || echo "No images to delete or repository not found"

# Delete the repository
echo "Deleting repository $REPOSITORY_NAME..."
aws ecr delete-repository --repository-name $REPOSITORY_NAME --force || echo "Repository not found"

echo "ECR repository $REPOSITORY_NAME and all images have been deleted."
```

# AWS CLI Commands for IAM

This README provides commonly used AWS CLI commands to manage AWS Identity and Access Management (IAM) resources including users, groups, roles, policies, and more.

---

## 1. Users

**Create a user**
```
aws iam create-user --user-name john.doe
```

**List all users**
```
aws iam list-users
```

**Get user details**
```
aws iam get-user --user-name john.doe
```

**Update a user's name**
```
aws iam update-user --user-name john.doe --new-user-name john.smith
```

**Delete a user**
```
aws iam delete-user --user-name john.smith
```

**Create login profile (console access)**
```
aws iam create-login-profile --user-name john.doe --password P@ssw0rd --password-reset-required
```

**Update login profile**
```
aws iam update-login-profile --user-name john.doe --password NewP@ssw0rd --password-reset-required
```

**Delete login profile**
```
aws iam delete-login-profile --user-name john.doe
```

**List users with a specific path prefix**
```
aws iam list-users --path-prefix /division/
```

---

## 2. Groups

**Create a group**
```
aws iam create-group --group-name Developers
```

**List all groups**
```
aws iam list-groups
```

**Add a user to a group**
```
aws iam add-user-to-group --user-name john.doe --group-name Developers
```

**List users in a group**
```
aws iam get-group --group-name Developers
```

**List groups for a user**
```
aws iam list-groups-for-user --user-name john.doe
```

**Remove a user from a group**
```
aws iam remove-user-from-group --user-name john.doe --group-name Developers
```

**Delete a group**
```
aws iam delete-group --group-name Developers
```

---

## 3. Roles

**Create a role (for EC2 service)**
```
aws iam create-role \
  --role-name EC2-S3-ReadOnly \
  --assume-role-policy-document file://trust-policy.json
```

**List all roles**
```
aws iam list-roles
```

**Get role details**
```
aws iam get-role --role-name EC2-S3-ReadOnly
```

**Update a role's description**
```
aws iam update-role --role-name EC2-S3-ReadOnly --description "Allows EC2 instances to read from S3"
```

**Update assume role policy**
```
aws iam update-assume-role-policy --role-name EC2-S3-ReadOnly --policy-document file://new-trust-policy.json
```

**Delete a role**
```
aws iam delete-role --role-name EC2-S3-ReadOnly
```

**Create service-linked role**
```
aws iam create-service-linked-role --aws-service-name elasticbeanstalk.amazonaws.com
```

---

## 4. Policies

**Create a policy**
```
aws iam create-policy \
  --policy-name S3ReadOnly \
  --policy-document file://policy.json
```

**List all policies**
```
aws iam list-policies
```

**Get policy details**
```
aws iam get-policy --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Get policy version details**
```
aws iam get-policy-version \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess \
  --version-id v1
```

**List policy versions**
```
aws iam list-policy-versions --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Create a new policy version**
```
aws iam create-policy-version \
  --policy-arn arn:aws:iam::123456789012:policy/S3ReadOnly \
  --policy-document file://new-policy.json \
  --set-as-default
```

**Delete a policy version**
```
aws iam delete-policy-version \
  --policy-arn arn:aws:iam::123456789012:policy/S3ReadOnly \
  --version-id v2
```

**Delete a policy**
```
aws iam delete-policy --policy-arn arn:aws:iam::123456789012:policy/S3ReadOnly
```

---

## 5. Policy Attachments

**Attach policy to a user**
```
aws iam attach-user-policy \
  --user-name john.doe \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Attach policy to a group**
```
aws iam attach-group-policy \
  --group-name Developers \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Attach policy to a role**
```
aws iam attach-role-policy \
  --role-name EC2-S3-ReadOnly \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**List policies for a user**
```
aws iam list-attached-user-policies --user-name john.doe
```

**List policies for a group**
```
aws iam list-attached-group-policies --group-name Developers
```

**List policies for a role**
```
aws iam list-attached-role-policies --role-name EC2-S3-ReadOnly
```

**Detach policy from a user**
```
aws iam detach-user-policy \
  --user-name john.doe \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Detach policy from a group**
```
aws iam detach-group-policy \
  --group-name Developers \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**Detach policy from a role**
```
aws iam detach-role-policy \
  --role-name EC2-S3-ReadOnly \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

---

## 6. Inline Policies

**Put inline policy for a user**
```
aws iam put-user-policy \
  --user-name john.doe \
  --policy-name S3Access \
  --policy-document file://inline-policy.json
```

**Put inline policy for a group**
```
aws iam put-group-policy \
  --group-name Developers \
  --policy-name S3Access \
  --policy-document file://inline-policy.json
```

**Put inline policy for a role**
```
aws iam put-role-policy \
  --role-name EC2-S3-ReadOnly \
  --policy-name S3Access \
  --policy-document file://inline-policy.json
```

**Get inline policy for a user**
```
aws iam get-user-policy \
  --user-name john.doe \
  --policy-name S3Access
```

**Get inline policy for a group**
```
aws iam get-group-policy \
  --group-name Developers \
  --policy-name S3Access
```

**Get inline policy for a role**
```
aws iam get-role-policy \
  --role-name EC2-S3-ReadOnly \
  --policy-name S3Access
```

**List inline policies for a user**
```
aws iam list-user-policies --user-name john.doe
```

**List inline policies for a group**
```
aws iam list-group-policies --group-name Developers
```

**List inline policies for a role**
```
aws iam list-role-policies --role-name EC2-S3-ReadOnly
```

**Delete inline policy from a user**
```
aws iam delete-user-policy \
  --user-name john.doe \
  --policy-name S3Access
```

**Delete inline policy from a group**
```
aws iam delete-group-policy \
  --group-name Developers \
  --policy-name S3Access
```

**Delete inline policy from a role**
```
aws iam delete-role-policy \
  --role-name EC2-S3-ReadOnly \
  --policy-name S3Access
```

---

## 7. Access Keys

**Create access key for a user**
```
aws iam create-access-key --user-name john.doe
```

**List access keys for a user**
```
aws iam list-access-keys --user-name john.doe
```

**Get access key last used information**
```
aws iam get-access-key-last-used --access-key-id AKIAIOSFODNN7EXAMPLE
```

**Update access key status**
```
aws iam update-access-key \
  --user-name john.doe \
  --access-key-id AKIAIOSFODNN7EXAMPLE \
  --status Inactive
```

**Delete access key**
```
aws iam delete-access-key \
  --user-name john.doe \
  --access-key-id AKIAIOSFODNN7EXAMPLE
```

---

## 8. MFA Devices

**Enable virtual MFA device**
```
aws iam enable-mfa-device \
  --user-name john.doe \
  --serial-number arn:aws:iam::123456789012:mfa/john.doe \
  --authentication-code1 123456 \
  --authentication-code2 789012
```

**List MFA devices for a user**
```
aws iam list-mfa-devices --user-name john.doe
```

**Deactivate MFA device**
```
aws iam deactivate-mfa-device \
  --user-name john.doe \
  --serial-number arn:aws:iam::123456789012:mfa/john.doe
```

**Create virtual MFA device**
```
aws iam create-virtual-mfa-device \
  --virtual-mfa-device-name john.doe \
  --outfile QRCode.png \
  --bootstrap-method QRCodePNG
```

**Delete virtual MFA device**
```
aws iam delete-virtual-mfa-device \
  --serial-number arn:aws:iam::123456789012:mfa/john.doe
```

---

## 9. SSH Public Keys

**Upload SSH public key**
```
aws iam upload-ssh-public-key \
  --user-name john.doe \
  --ssh-public-key-body file://id_rsa.pub
```

**List SSH public keys**
```
aws iam list-ssh-public-keys --user-name john.doe
```

**Get SSH public key**
```
aws iam get-ssh-public-key \
  --user-name john.doe \
  --ssh-public-key-id APKAEIBAERJR2EXAMPLE \
  --encoding SSH
```

**Update SSH public key status**
```
aws iam update-ssh-public-key \
  --user-name john.doe \
  --ssh-public-key-id APKAEIBAERJR2EXAMPLE \
  --status Inactive
```

**Delete SSH public key**
```
aws iam delete-ssh-public-key \
  --user-name john.doe \
  --ssh-public-key-id APKAEIBAERJR2EXAMPLE
```

---

## 10. Security Credentials

**Change password for current IAM user**
```
aws iam change-password --old-password OldPassword --new-password NewPassword
```

**Create service specific credential**
```
aws iam create-service-specific-credential \
  --user-name john.doe \
  --service-name codecommit.amazonaws.com
```

**List service specific credentials**
```
aws iam list-service-specific-credentials \
  --user-name john.doe \
  --service-name codecommit.amazonaws.com
```

**Update service specific credential status**
```
aws iam update-service-specific-credential \
  --user-name john.doe \
  --service-specific-credential-id ACCA123EXAMPLE \
  --status Inactive
```

**Delete service specific credential**
```
aws iam delete-service-specific-credential \
  --user-name john.doe \
  --service-specific-credential-id ACCA123EXAMPLE
```

**Reset service specific credential**
```
aws iam reset-service-specific-credential \
  --user-name john.doe \
  --service-specific-credential-id ACCA123EXAMPLE
```

---

## 11. Account and Password Policies

**Get account summary**
```
aws iam get-account-summary
```

**Get account password policy**
```
aws iam get-account-password-policy
```

**Update account password policy**
```
aws iam update-account-password-policy \
  --minimum-password-length 12 \
  --require-symbols \
  --require-numbers \
  --require-uppercase-characters \
  --require-lowercase-characters \
  --allow-users-to-change-password \
  --max-password-age 90 \
  --password-reuse-prevention 24 \
  --hard-expiry
```

**Delete account password policy**
```
aws iam delete-account-password-policy
```

**Generate credential report**
```
aws iam generate-credential-report
```

**Get credential report**
```
aws iam get-credential-report
```

---

## 12. SAML & Identity Providers

**Create SAML provider**
```
aws iam create-saml-provider \
  --saml-metadata-document file://saml-metadata.xml \
  --name MySAMLProvider
```

**List SAML providers**
```
aws iam list-saml-providers
```

**Get SAML provider**
```
aws iam get-saml-provider --saml-provider-arn arn:aws:iam::123456789012:saml-provider/MySAMLProvider
```

**Update SAML provider**
```
aws iam update-saml-provider \
  --saml-metadata-document file://new-saml-metadata.xml \
  --saml-provider-arn arn:aws:iam::123456789012:saml-provider/MySAMLProvider
```

**Delete SAML provider**
```
aws iam delete-saml-provider --saml-provider-arn arn:aws:iam::123456789012:saml-provider/MySAMLProvider
```

**Create OIDC provider**
```
aws iam create-open-id-connect-provider \
  --url https://accounts.google.com \
  --client-id-list 123456789012.apps.googleusercontent.com \
  --thumbprint-list 1234567890123456789012345678901234567890
```

**List OIDC providers**
```
aws iam list-open-id-connect-providers
```

**Get OIDC provider**
```
aws iam get-open-id-connect-provider --open-id-connect-provider-arn arn:aws:iam::123456789012:oidc-provider/accounts.google.com
```

**Update OIDC provider thumbprint**
```
aws iam update-open-id-connect-provider-thumbprint \
  --open-id-connect-provider-arn arn:aws:iam::123456789012:oidc-provider/accounts.google.com \
  --thumbprint-list 1234567890123456789012345678901234567890
```

**Add client ID to OIDC provider**
```
aws iam add-client-id-to-open-id-connect-provider \
  --open-id-connect-provider-arn arn:aws:iam::123456789012:oidc-provider/accounts.google.com \
  --client-id 987654321098.apps.googleusercontent.com
```

**Remove client ID from OIDC provider**
```
aws iam remove-client-id-from-open-id-connect-provider \
  --open-id-connect-provider-arn arn:aws:iam::123456789012:oidc-provider/accounts.google.com \
  --client-id 987654321098.apps.googleusercontent.com
```

**Delete OIDC provider**
```
aws iam delete-open-id-connect-provider --open-id-connect-provider-arn arn:aws:iam::123456789012:oidc-provider/accounts.google.com
```

---

## 13. Server Certificates

**Upload server certificate**
```
aws iam upload-server-certificate \
  --server-certificate-name MyCertificate \
  --certificate-body file://public_key_cert_file.pem \
  --private-key file://my_private_key.pem \
  --certificate-chain file://my_certificate_chain_file.pem
```

**List server certificates**
```
aws iam list-server-certificates
```

**Get server certificate**
```
aws iam get-server-certificate --server-certificate-name MyCertificate
```

**Update server certificate name**
```
aws iam update-server-certificate \
  --server-certificate-name MyCertificate \
  --new-server-certificate-name MyNewCertificate
```

**Delete server certificate**
```
aws iam delete-server-certificate --server-certificate-name MyCertificate
```

---

## 14. Tags for IAM Resources

**Tag a user**
```
aws iam tag-user \
  --user-name john.doe \
  --tags '[{"Key":"Department","Value":"IT"},{"Key":"Project","Value":"Migration"}]'
```

**Tag a role**
```
aws iam tag-role \
  --role-name EC2-S3-ReadOnly \
  --tags '[{"Key":"Environment","Value":"Production"}]'
```

**List tags for a user**
```
aws iam list-user-tags --user-name john.doe
```

**List tags for a role**
```
aws iam list-role-tags --role-name EC2-S3-ReadOnly
```

**Remove tags from a user**
```
aws iam untag-user \
  --user-name john.doe \
  --tag-keys '["Department","Project"]'
```

**Remove tags from a role**
```
aws iam untag-role \
  --role-name EC2-S3-ReadOnly \
  --tag-keys '["Environment"]'
```

---

## 15. Service-Linked Roles

**Create service-linked role**
```
aws iam create-service-linked-role --aws-service-name autoscaling.amazonaws.com
```

**List service-linked roles**
```
aws iam list-roles --path-prefix /aws-service-role/
```

**Get service-linked role deletion status**
```
aws iam get-service-linked-role-deletion-status --deletion-task-id task-id
```

**Delete service-linked role**
```
aws iam delete-service-linked-role --role-name AWSServiceRoleForAutoScaling
```

---

## 16. Advanced Queries and Operations

**Find users with administrator access**
```
aws iam list-users --output json | jq -r '.Users[].UserName' | while read user; do 
  if aws iam list-attached-user-policies --user-name $user --output json | jq -r '.AttachedPolicies[].PolicyArn' | grep -q "AdministratorAccess"; then 
    echo "$user has AdministratorAccess policy"; 
  fi; 
done
```

**Find unused access keys (older than 90 days)**
```
aws iam generate-credential-report
aws iam get-credential-report --output text --query 'Content' | base64 -d | cut -d, -f1,4,9,10,11 | grep -v "^user" | grep "false" | while IFS=, read -r user mfa access_key_1_active access_key_1_last_used access_key_1_last_rotated; do
  last_used_date=$(date -d "$access_key_1_last_used" +%s 2>/dev/null)
  now=$(date +%s)
  if [ ! -z "$last_used_date" ]; then
    days_since_last_use=$(( (now - last_used_date) / 86400 ))
    if [ "$access_key_1_active" == "true" ] && [ $days_since_last_use -gt 90 ]; then
      echo "User $user has active access key 1 unused for $days_since_last_use days"
    fi
  fi
done
```

**Find users without MFA**
```
aws iam generate-credential-report
aws iam get-credential-report --output text --query 'Content' | base64 -d | grep -v "^user" | grep "false" | cut -d, -f1,4 | grep ",false" | cut -d, -f1
```

**Audit root account usage**
```
aws iam generate-credential-report
aws iam get-credential-report --output text --query 'Content' | base64 -d | grep "^<root>" | cut -d, -f1,5,11,15,16
```

**Check password policy strength**
```
aws iam get-account-password-policy --output json | jq -r 'if .PasswordPolicy.MinimumPasswordLength < 14 then "Password policy should require at least 14 characters" else "Password length requirement is good" end'
```

---

## 17. Best Practices

**Rotate access keys**
```bash
# Create new access key
NEW_KEY=$(aws iam create-access-key --user-name john.doe --output json)
NEW_ACCESS_KEY_ID=$(echo $NEW_KEY | jq -r '.AccessKey.AccessKeyId')
NEW_SECRET_ACCESS_KEY=$(echo $NEW_KEY | jq -r '.AccessKey.SecretAccessKey')

# Store the new key securely
echo "New Access Key ID: $NEW_ACCESS_KEY_ID"
echo "New Secret Access Key: $NEW_SECRET_ACCESS_KEY"

# List current keys to find old one
OLD_ACCESS_KEY_ID=$(aws iam list-access-keys --user-name john.doe --output json | jq -r '.AccessKeyMetadata[0].AccessKeyId')

# Mark old key as inactive
aws iam update-access-key --user-name john.doe --access-key-id $OLD_ACCESS_KEY_ID --status Inactive

# After confirming new key works, delete old key
# aws iam delete-access-key --user-name john.doe --access-key-id $OLD_ACCESS_KEY_ID
```

**Enable MFA for all users**
```bash
#!/bin/bash
aws iam list-users --output json | jq -r '.Users[].UserName' | while read user; do
  mfa_devices=$(aws iam list-mfa-devices --user-name $user --output json | jq '.MFADevices | length')
  if [ "$mfa_devices" == "0" ]; then
    echo "User $user does not have MFA enabled"
  fi
done
```

**Create user with least privilege**
```bash
# Create user
aws iam create-user --user-name restricted-user

# Create custom policy with minimal permissions
aws iam create-policy \
  --policy-name MinimalS3ReadAccess \
  --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource": [
          "arn:aws:s3:::specific-bucket",
          "arn:aws:s3:::specific-bucket/*"
        ]
      }
    ]
  }'

# Attach the policy to the user
aws iam attach-user-policy \
  --user-name restricted-user \
  --policy-arn arn:aws:iam::123456789012:policy/MinimalS3ReadAccess

# Create access key for programmatic access
aws iam create-access-key --user-name restricted-user
```

**Full user cleanup script**
```bash
#!/bin/bash
USER="john.doe"

# Remove all policies
echo "Removing policies..."
for policy in $(aws iam list-attached-user-policies --user-name $USER --query 'AttachedPolicies[*].PolicyArn' --output text); do
  aws iam detach-user-policy --user-name $USER --policy-arn $policy
done

# Remove from all groups
echo "Removing from groups..."
for group in $(aws iam list-groups-for-user --user-name $USER --query 'Groups[*].GroupName' --output text); do
  aws iam remove-user-from-group --user-name $USER --group-name $group
done

# Delete inline policies
echo "Removing inline policies..."
for policy in $(aws iam list-user-policies --user-name $USER --query 'PolicyNames[*]' --output text); do
  aws iam delete-user-policy --user-name $USER --policy-name $policy
done

# Deactivate and delete MFA devices
echo "Removing MFA devices..."
for mfa in $(aws iam list-mfa-devices --user-name $USER --query 'MFADevices[*].SerialNumber' --output text); do
  aws iam deactivate-mfa-device --user-name $USER --serial-number $mfa
  if [[ $mfa == arn:aws:iam::*:mfa/* ]]; then
    aws iam delete-virtual-mfa-device --serial-number $mfa
  fi
done

# Delete access keys
echo "Removing access keys..."
for key in $(aws iam list-access-keys --user-name $USER --query 'AccessKeyMetadata[*].AccessKeyId' --output text); do
  aws iam delete-access-key --user-name $USER --access-key-id $key
done

# Delete login profile (console access)
echo "Removing login profile..."
aws iam delete-login-profile --user-name $USER || echo "No login profile exists"

# Delete SSH keys
echo "Removing SSH keys..."
for key in $(aws iam list-ssh-public-keys --user-name $USER --query 'SSHPublicKeys[*].SSHPublicKeyId' --output text); do
  aws iam delete-ssh-public-key --user-name $USER --ssh-public-key-id $key
done

# Delete service-specific credentials
echo "Removing service-specific credentials..."
for service in codecommit.amazonaws.com; do
  for cred in $(aws iam list-service-specific-credentials --user-name $USER --service-name $service --query 'ServiceSpecificCredentials[*].ServiceSpecificCredentialId' --output text); do
    aws iam delete-service-specific-credential --user-name $USER --service-specific-credential-id $cred
  done
done

# Finally delete the user
echo "Deleting user..."
aws iam delete-user --user-name $USER

echo "User $USER has been fully removed from the AWS account."
``` 


# AWS CLI Commands for RDS (Relational Database Service)

## Instance Management

### Create DB Instance
```
aws rds create-db-instance \
  --db-instance-identifier my-db-instance \
  --db-instance-class db.t3.micro \
  --engine mysql \
  --engine-version 8.0.28 \
  --master-username admin \
  --master-user-password mypassword \
  --allocated-storage 20 \
  --storage-type gp2 \
  --vpc-security-group-ids sg-0123456789abcdef \
  --availability-zone us-east-1a \
  --db-subnet-group-name my-db-subnet-group \
  --port 3306 \
  --publicly-accessible \
  --backup-retention-period 7
```

### Describe DB Instances
```
# List all instances
aws rds describe-db-instances

# Get details for a specific instance
aws rds describe-db-instances --db-instance-identifier my-db-instance

# Filter output with query parameter
aws rds describe-db-instances --query "DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceStatus]"

# Find instances in a specific state
aws rds describe-db-instances --filters "Name=db-instance-status,Values=available"
```

### Modify DB Instance
```
# Resize instance
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --db-instance-class db.t3.small \
  --apply-immediately

# Increase storage
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --allocated-storage 50 \
  --apply-immediately

# Enable auto minor version upgrade
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --auto-minor-version-upgrade \
  --apply-immediately

# Change backup window
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --preferred-backup-window "01:00-02:00" \
  --apply-immediately

# Enable Performance Insights
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --enable-performance-insights \
  --performance-insights-retention-period 7 \
  --apply-immediately
```

### Delete DB Instance
```
# Delete with final snapshot
aws rds delete-db-instance \
  --db-instance-identifier my-db-instance \
  --final-db-snapshot-identifier my-final-snapshot

# Delete without final snapshot
aws rds delete-db-instance \
  --db-instance-identifier my-db-instance \
  --skip-final-snapshot
```

### Reboot DB Instance
```
# Normal reboot
aws rds reboot-db-instance --db-instance-identifier my-db-instance

# Force failover for Multi-AZ
aws rds reboot-db-instance \
  --db-instance-identifier my-db-instance \
  --force-failover
```

### Start/Stop DB Instance
```
# Start a stopped instance
aws rds start-db-instance --db-instance-identifier my-db-instance

# Stop an instance (non-production)
aws rds stop-db-instance --db-instance-identifier my-db-instance
```

## Snapshot Operations

### Create DB Snapshot
```
# Create manual snapshot
aws rds create-db-snapshot \
  --db-instance-identifier my-db-instance \
  --db-snapshot-identifier my-db-snapshot

# Create snapshot with tags
aws rds create-db-snapshot \
  --db-instance-identifier my-db-instance \
  --db-snapshot-identifier my-db-snapshot \
  --tags "Key=Environment,Value=Production" "Key=Project,Value=Backup"
```

### Describe DB Snapshots
```
# List all snapshots
aws rds describe-db-snapshots

# Get details for a specific snapshot
aws rds describe-db-snapshots --db-snapshot-identifier my-db-snapshot

# List snapshots for a specific instance
aws rds describe-db-snapshots --db-instance-identifier my-db-instance

# Filter by type (manual or automated)
aws rds describe-db-snapshots --snapshot-type manual

# List snapshot details with creation time
aws rds describe-db-snapshots --query "DBSnapshots[*].[DBSnapshotIdentifier,SnapshotCreateTime,Status]"
```

### Copy DB Snapshot
```
# Copy snapshot within region
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier my-db-snapshot \
  --target-db-snapshot-identifier my-db-snapshot-copy

# Copy snapshot to another region
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier my-db-snapshot \
  --target-db-snapshot-identifier my-db-snapshot-copy \
  --source-region us-east-1 \
  --region us-west-2

# Copy encrypted snapshot
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier my-db-snapshot \
  --target-db-snapshot-identifier my-db-snapshot-copy \
  --kms-key-id arn:aws:kms:us-east-1:123456789012:key/abcd1234-ab12-cd34-ef56-abcdef123456
```

### Delete DB Snapshot
```
aws rds delete-db-snapshot --db-snapshot-identifier my-db-snapshot
```

### Restore From DB Snapshot
```
# Basic restore
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db-instance \
  --db-snapshot-identifier my-db-snapshot

# Restore with different instance class
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db-instance \
  --db-snapshot-identifier my-db-snapshot \
  --db-instance-class db.t3.large

# Restore to different subnet group and availability zone
aws rds restore-db-instance-from-db-snapshot \
  --db-instance-identifier restored-db-instance \
  --db-snapshot-identifier my-db-snapshot \
  --db-subnet-group-name new-subnet-group \
  --availability-zone us-east-1b
```

## Parameter Groups

### Create DB Parameter Group
```
aws rds create-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --db-parameter-group-family mysql8.0 \
  --description "My custom MySQL parameter group"
```

### Modify DB Parameter Group
```
# Change single parameter
aws rds modify-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --parameters "ParameterName=max_connections,ParameterValue=500,ApplyMethod=immediate"

# Change multiple parameters
aws rds modify-db-parameter-group \
  --db-parameter-group-name my-param-group \
  --parameters "[
    {\"ParameterName\":\"max_connections\",\"ParameterValue\":\"500\",\"ApplyMethod\":\"immediate\"},
    {\"ParameterName\":\"innodb_buffer_pool_size\",\"ParameterValue\":\"1073741824\",\"ApplyMethod\":\"pending-reboot\"}
  ]"

# Reset parameter to default value
aws rds reset-db-parameter-group-parameter \
  --db-parameter-group-name my-param-group \
  --parameters "ParameterName=max_connections,ApplyMethod=immediate"
```

### Describe DB Parameter Groups
```
# List all parameter groups
aws rds describe-db-parameter-groups

# Get details for a specific parameter group
aws rds describe-db-parameter-groups --db-parameter-group-name my-param-group
```

### Describe DB Parameters
```
# List all parameters in a group
aws rds describe-db-parameters --db-parameter-group-name my-param-group

# Filter to show only modified parameters
aws rds describe-db-parameters \
  --db-parameter-group-name my-param-group \
  --source user

# Filter to show parameters containing a specific string
aws rds describe-db-parameters \
  --db-parameter-group-name my-param-group \
  --query "Parameters[?contains(ParameterName, 'innodb')]"
```

### Delete DB Parameter Group
```
aws rds delete-db-parameter-group --db-parameter-group-name my-param-group
```

## Option Groups

### Create Option Group
```
aws rds create-option-group \
  --option-group-name my-option-group \
  --engine-name mysql \
  --major-engine-version 8.0 \
  --option-group-description "My MySQL options"
```

### Add Option to Option Group
```
# Add simple option
aws rds add-option-to-option-group \
  --option-group-name my-option-group \
  --options "OptionName=MARIADB_AUDIT_PLUGIN"

# Add option with settings
aws rds add-option-to-option-group \
  --option-group-name my-option-group \
  --options "[
    {
      \"OptionName\": \"MEMCACHED\",
      \"Port\": 11211,
      \"OptionSettings\": [
        {\"Name\": \"CHUNK_SIZE\", \"Value\": \"32\"},
        {\"Name\": \"MAX_SIMULTANEOUS_CONNECTIONS\", \"Value\": \"100\"}
      ]
    }
  ]"
```

### Describe Option Groups and Options
```
# List all option groups
aws rds describe-option-groups

# Get details for a specific option group
aws rds describe-option-groups --option-group-name my-option-group

# Describe options in an option group
aws rds describe-option-group-options --engine-name mysql --major-engine-version 8.0
```

### Remove Option from Option Group
```
aws rds remove-option-from-option-group \
  --option-group-name my-option-group \
  --options MARIADB_AUDIT_PLUGIN \
  --apply-immediately
```

### Delete Option Group
```
aws rds delete-option-group --option-group-name my-option-group
```

## DB Subnet Groups

### Create DB Subnet Group
```
aws rds create-db-subnet-group \
  --db-subnet-group-name my-subnet-group \
  --db-subnet-group-description "My DB subnet group" \
  --subnet-ids subnet-12345678 subnet-87654321 subnet-56781234
```

### Describe DB Subnet Groups
```
# List all subnet groups
aws rds describe-db-subnet-groups

# Get details for a specific subnet group
aws rds describe-db-subnet-groups --db-subnet-group-name my-subnet-group
```

### Modify DB Subnet Group
```
aws rds modify-db-subnet-group \
  --db-subnet-group-name my-subnet-group \
  --subnet-ids subnet-12345678 subnet-87654321 subnet-56781234 subnet-43218765
```

### Delete DB Subnet Group
```
aws rds delete-db-subnet-group --db-subnet-group-name my-subnet-group
```

## Security Groups

### Create DB Security Group (EC2-Classic only)
```
aws rds create-db-security-group \
  --db-security-group-name my-security-group \
  --db-security-group-description "My DB security group"
```

### Authorize DB Security Group Ingress
```
# Allow access from specific IP
aws rds authorize-db-security-group-ingress \
  --db-security-group-name my-security-group \
  --cidrip 203.0.113.5/32

# Allow access from EC2 security group
aws rds authorize-db-security-group-ingress \
  --db-security-group-name my-security-group \
  --ec2-security-group-name my-ec2-security-group \
  --ec2-security-group-owner-id 123456789012
```

### Describe DB Security Groups
```
aws rds describe-db-security-groups
aws rds describe-db-security-groups --db-security-group-name my-security-group
```

### Revoke DB Security Group Ingress
```
aws rds revoke-db-security-group-ingress \
  --db-security-group-name my-security-group \
  --cidrip 203.0.113.5/32
```

## Reserved Instances

### Describe Reserved DB Instance Offerings
```
# List all reserved instance offerings
aws rds describe-reserved-db-instances-offerings

# Filter by DB engine
aws rds describe-reserved-db-instances-offerings --product-description "mysql"

# Filter by instance class
aws rds describe-reserved-db-instances-offerings \
  --query "ReservedDBInstancesOfferings[?DBInstanceClass=='db.t3.small']"

# Filter by offering type
aws rds describe-reserved-db-instances-offerings \
  --query "ReservedDBInstancesOfferings[?OfferingType=='Partial Upfront']"
```

### Purchase Reserved DB Instance
```
aws rds purchase-reserved-db-instances-offering \
  --reserved-db-instances-offering-id 12345abc-12ab-34cd-56ef-12345EXAMPLE \
  --reserved-db-instance-id my-reserved-instance \
  --tags "Key=Environment,Value=Production"
```

### Describe Reserved DB Instances
```
# List all reserved instances
aws rds describe-reserved-db-instances

# Get details for a specific reserved instance
aws rds describe-reserved-db-instances --reserved-db-instance-id my-reserved-instance

# Filter by state or offering type
aws rds describe-reserved-db-instances \
  --query "ReservedDBInstances[?State=='active']" \
  --query "ReservedDBInstances[?OfferingType=='Partial Upfront']"
```

## Event Subscription

### Create Event Subscription
```
# Create basic subscription
aws rds create-event-subscription \
  --subscription-name my-event-subscription \
  --sns-topic-arn arn:aws:sns:us-east-1:123456789012:my-topic \
  --enabled

# Subscribe to specific source types and categories
aws rds create-event-subscription \
  --subscription-name my-db-instance-events \
  --sns-topic-arn arn:aws:sns:us-east-1:123456789012:my-topic \
  --source-type db-instance \
  --event-categories availability backup configuration deletion failover failure maintenance notification recovery security

# Subscribe to a specific instance
aws rds create-event-subscription \
  --subscription-name my-specific-db-events \
  --sns-topic-arn arn:aws:sns:us-east-1:123456789012:my-topic \
  --source-type db-instance \
  --source-ids my-db-instance
```

### Describe Event Subscriptions
```
# List all event subscriptions
aws rds describe-event-subscriptions

# Get details for a specific subscription
aws rds describe-event-subscriptions --subscription-name my-event-subscription
```

### Modify Event Subscription
```
# Update SNS topic
aws rds modify-event-subscription \
  --subscription-name my-event-subscription \
  --sns-topic-arn arn:aws:sns:us-east-1:123456789012:new-topic

# Change event categories
aws rds modify-event-subscription \
  --subscription-name my-event-subscription \
  --event-categories maintenance backup

# Disable subscription temporarily
aws rds modify-event-subscription \
  --subscription-name my-event-subscription \
  --no-enabled
```

### Delete Event Subscription
```
aws rds delete-event-subscription --subscription-name my-event-subscription
```

## Read Replicas

### Create Read Replica
```
# Create basic read replica
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-read-replica \
  --source-db-instance-identifier my-source-db

# Create cross-region read replica
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-read-replica \
  --source-db-instance-identifier my-source-db \
  --source-region us-east-1 \
  --region us-west-2

# Create read replica with different instance class
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-read-replica \
  --source-db-instance-identifier my-source-db \
  --db-instance-class db.r5.large
```

### Promote Read Replica
```
# Promote to standalone instance
aws rds promote-read-replica \
  --db-instance-identifier my-read-replica

# Promote with backup retention
aws rds promote-read-replica \
  --db-instance-identifier my-read-replica \
  --backup-retention-period 7
```

## Multi-AZ and Failover

### Convert to Multi-AZ
```
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --multi-az \
  --apply-immediately
```

### Failover DB Instance
```
aws rds failover-db-instance --db-instance-identifier my-db-instance
```

## Monitoring and Logs

### Describe DB Log Files
```
aws rds describe-db-log-files --db-instance-identifier my-db-instance
```

### Download DB Log File Portion
```
# Get last 1000 lines
aws rds download-db-log-file-portion \
  --db-instance-identifier my-db-instance \
  --log-file-name error/mysql-error.log \
  --output text

# Get specific portion with markers
aws rds download-db-log-file-portion \
  --db-instance-identifier my-db-instance \
  --log-file-name error/mysql-error.log \
  --marker 0 \
  --number-of-lines 100 \
  --output text > mysql-error-portion.log
```

### Describe Events
```
# Get all events from last 24 hours
aws rds describe-events --duration 1440

# Get events for specific source
aws rds describe-events \
  --source-identifier my-db-instance \
  --source-type db-instance

# Get events with specific categories
aws rds describe-events \
  --source-type db-instance \
  --event-categories failover,maintenance

# Get events for a specific time window
aws rds describe-events \
  --start-time 2023-01-01T00:00:00Z \
  --end-time 2023-01-07T23:59:59Z
```

### Enable Enhanced Monitoring
```
aws rds modify-db-instance \
  --db-instance-identifier my-db-instance \
  --monitoring-interval 30 \
  --monitoring-role-arn arn:aws:iam::123456789012:role/rds-monitoring-role \
  --apply-immediately
```

## Database Maintenance

### Apply Pending Maintenance Actions
```
# Apply specific action
aws rds apply-pending-maintenance-action \
  --resource-identifier arn:aws:rds:us-east-1:123456789012:db:my-db-instance \
  --apply-action system-update \
  --opt-in-type immediate

# Apply all actions for next maintenance window
aws rds apply-pending-maintenance-action \
  --resource-identifier arn:aws:rds:us-east-1:123456789012:db:my-db-instance \
  --apply-action all \
  --opt-in-type next-maintenance
```

### Describe Pending Maintenance Actions
```
# List all pending actions
aws rds describe-pending-maintenance-actions

# Check specific resource
aws rds describe-pending-maintenance-actions \
  --resource-identifier arn:aws:rds:us-east-1:123456789012:db:my-db-instance

# Filter by action type
aws rds describe-pending-maintenance-actions \
  --filters "Name=engine-version-upgrade,Values=true"
```

## DB Cluster Operations (Aurora)

### Create DB Cluster
```
# Create basic Aurora cluster
aws rds create-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --engine aurora-mysql \
  --engine-version 5.7.mysql_aurora.2.10.2 \
  --master-username admin \
  --master-user-password mypassword \
  --db-subnet-group-name my-db-subnet-group \
  --vpc-security-group-ids sg-0123456789abcdef

# Create serverless Aurora cluster
aws rds create-db-cluster \
  --db-cluster-identifier my-serverless-cluster \
  --engine aurora-postgresql \
  --engine-version 13.6 \
  --master-username admin \
  --master-user-password mypassword \
  --db-subnet-group-name my-db-subnet-group \
  --vpc-security-group-ids sg-0123456789abcdef \
  --engine-mode serverless \
  --scaling-configuration "MinCapacity=2,MaxCapacity=16,AutoPause=true,SecondsUntilAutoPause=900,TimeoutAction=RollbackCapacityChange"
```

### Create DB Instance in Cluster
```
aws rds create-db-instance \
  --db-instance-identifier my-aurora-instance-1 \
  --db-instance-class db.r5.large \
  --engine aurora-mysql \
  --db-cluster-identifier my-aurora-cluster
```

### Describe DB Clusters
```
# List all clusters
aws rds describe-db-clusters

# Get details for a specific cluster
aws rds describe-db-clusters --db-cluster-identifier my-aurora-cluster

# Get specific cluster information
aws rds describe-db-clusters \
  --db-cluster-identifier my-aurora-cluster \
  --query "DBClusters[*].[DBClusterIdentifier,Status,Engine,EngineVersion]"
```

### Modify DB Cluster
```
# Change backup retention
aws rds modify-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --backup-retention-period 14 \
  --apply-immediately

# Change master password
aws rds modify-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --master-user-password newpassword \
  --apply-immediately

# Enable IAM authentication
aws rds modify-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --enable-iam-database-authentication \
  --apply-immediately
```

### Create DB Cluster Snapshot
```
aws rds create-db-cluster-snapshot \
  --db-cluster-identifier my-aurora-cluster \
  --db-cluster-snapshot-identifier my-cluster-snapshot
```

### Describe DB Cluster Snapshots
```
# List all cluster snapshots
aws rds describe-db-cluster-snapshots

# Get details for a specific snapshot
aws rds describe-db-cluster-snapshots --db-cluster-snapshot-identifier my-cluster-snapshot

# List snapshots for a specific cluster
aws rds describe-db-cluster-snapshots --db-cluster-identifier my-aurora-cluster
```

### Delete DB Cluster
```
# Delete cluster retaining snapshots
aws rds delete-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --final-db-snapshot-identifier final-snapshot

# Delete cluster without snapshot
aws rds delete-db-cluster \
  --db-cluster-identifier my-aurora-cluster \
  --skip-final-snapshot
```

## Tagging Resources

### Add Tags to Resource
```
# Tag a DB instance
aws rds add-tags-to-resource \
  --resource-name arn:aws:rds:us-east-1:123456789012:db:my-db-instance \
  --tags "Key=Environment,Value=Production" "Key=Owner,Value=DBTeam" "Key=CostCenter,Value=123456"

# Tag a snapshot
aws rds add-tags-to-resource \
  --resource-name arn:aws:rds:us-east-1:123456789012:snapshot:my-db-snapshot \
  --tags "Key=BackupType,Value=Monthly" "Key=RetentionPeriod,Value=1Year"
```

### List Tags for Resource
```
aws rds list-tags-for-resource \
  --resource-name arn:aws:rds:us-east-1:123456789012:db:my-db-instance
```

### Remove Tags from Resource
```
aws rds remove-tags-from-resource \
  --resource-name arn:aws:rds:us-east-1:123456789012:db:my-db-instance \
  --tag-keys "Environment" "Owner"
```

## Performance Insights

### Describe Performance Insights
```
# Get performance insights capabilities
aws rds describe-db-instance-performance \
  --db-instance-identifier my-db-instance
```

### Get Performance Metrics
```
# Get CPU utilization metrics
aws pi get-resource-metrics \
  --service-type RDS \
  --identifier db-ABCDEFGHIJKLMNOPQRSTU1234 \
  --metric-queries '[{"Metric": "os.cpuUtilization.total.pct"}]' \
  --start-time 2023-03-01T00:00:00Z \
  --end-time 2023-03-07T23:59:59Z \
  --period-in-seconds 3600

# Get top SQL queries by load
aws pi get-resource-metrics \
  --service-type RDS \
  --identifier db-ABCDEFGHIJKLMNOPQRSTU1234 \
  --metric-queries '[{"Metric": "db.load.avg", "GroupBy": {"Group": "db.sql", "Limit": 10}}]' \
  --start-time 2023-03-01T00:00:00Z \
  --end-time 2023-03-07T23:59:59Z \
  --period-in-seconds 3600
```

## Proxy Management

### Create DB Proxy
```
aws rds create-db-proxy \
  --db-proxy-name my-db-proxy \
  --engine-family MYSQL \
  --auth '{"AuthScheme":"SECRETS","IAMAuth":"DISABLED","SecretArn":"arn:aws:secretsmanager:us-east-1:123456789012:secret:mySecret"}' \
  --role-arn arn:aws:iam::123456789012:role/RDSProxyRole \
  --vpc-subnet-ids subnet-12345678 subnet-87654321 \
  --vpc-security-group-ids sg-0123456789abcdef
```

### Register DB Proxy Targets
```
aws rds register-db-proxy-targets \
  --db-proxy-name my-db-proxy \
  --db-instance-identifiers my-db-instance
```

### Describe DB Proxy Targets
```
aws rds describe-db-proxy-targets --db-proxy-name my-db-proxy
```

### Describe DB Proxies
```
aws rds describe-db-proxies
aws rds describe-db-proxies --db-proxy-name my-db-proxy
```

### Modify DB Proxy
```
aws rds modify-db-proxy \
  --db-proxy-name my-db-proxy \
  --new-idle-client-timeout 1800 \
  --debug-logging true
```

### Delete DB Proxy
```
aws rds delete-db-proxy --db-proxy-name my-db-proxy
```

## Cross-Region Operations

### Create Cross-Region Read Replica
```
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-cross-region-replica \
  --source-db-instance-identifier arn:aws:rds:us-east-1:123456789012:db:my-source-db \
  --source-region us-east-1 \
  --region us-west-2 \
  --db-instance-class db.t3.medium
```

### Copy DB Snapshot to Another Region
```
aws rds copy-db-snapshot \
  --source-db-snapshot-identifier arn:aws:rds:us-east-1:123456789012:snapshot:my-db-snapshot \
  --target-db-snapshot-identifier my-copied-snapshot \
  --source-region us-east-1 \
  --region us-west-2 \
  --kms-key-id arn:aws:kms:us-west-2:123456789012:key/abcd1234-ab12-cd34-ef56-abcdef123456
```

## CLI Output Formatting

### Format as Table
```
aws rds describe-db-instances --output table
```

### Format as JSON
```
aws rds describe-db-instances --output json
```

### Use Query for Specific Fields
```
# Get instance identifiers and status
aws rds describe-db-instances \
  --query "DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus]" \
  --output table

# Filter by engine type and get specific attributes
aws rds describe-db-instances \
  --query "DBInstances[?Engine=='mysql'].[DBInstanceIdentifier,DBInstanceClass,AllocatedStorage]" \
  --output json

# Get complex nested attributes
aws rds describe-db-instances \
  --query "DBInstances[*].[DBInstanceIdentifier,VpcSecurityGroups[*].VpcSecurityGroupId]" \
  --output text
```

### Filtering with --filter
```
# Filter instances by status
aws rds describe-db-instances \
  --filters Name=db-instance-status,Values=available

# Filter events by source type
aws rds describe-events \
  --filters Name=source-type,Values=db-instance,db-parameter-group
``` 

# AWS CLI Commands for DynamoDB Tables

## Table Management

### Create Table
```
# Create basic table with hash key
aws dynamodb create-table \
  --table-name Users \
  --attribute-definitions \
    AttributeName=UserId,AttributeType=S \
  --key-schema \
    AttributeName=UserId,KeyType=HASH \
  --provisioned-throughput \
    ReadCapacityUnits=5,WriteCapacityUnits=5

# Create table with hash and range key
aws dynamodb create-table \
  --table-name Orders \
  --attribute-definitions \
    AttributeName=CustomerId,AttributeType=S \
    AttributeName=OrderId,AttributeType=S \
  --key-schema \
    AttributeName=CustomerId,KeyType=HASH \
    AttributeName=OrderId,KeyType=RANGE \
  --provisioned-throughput \
    ReadCapacityUnits=10,WriteCapacityUnits=5

# Create table with Global Secondary Index (GSI)
aws dynamodb create-table \
  --table-name Products \
  --attribute-definitions \
    AttributeName=ProductId,AttributeType=S \
    AttributeName=ProductCategory,AttributeType=S \
    AttributeName=ProductName,AttributeType=S \
  --key-schema \
    AttributeName=ProductId,KeyType=HASH \
  --provisioned-throughput \
    ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --global-secondary-indexes \
    "[
      {
        \"IndexName\": \"CategoryIndex\",
        \"KeySchema\": [
          {\"AttributeName\":\"ProductCategory\",\"KeyType\":\"HASH\"},
          {\"AttributeName\":\"ProductName\",\"KeyType\":\"RANGE\"}
        ],
        \"Projection\": {
          \"ProjectionType\":\"ALL\"
        },
        \"ProvisionedThroughput\": {
          \"ReadCapacityUnits\":3,
          \"WriteCapacityUnits\":2
        }
      }
    ]"

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
  --provisioned-throughput \
    ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --local-secondary-indexes \
    "[
      {
        \"IndexName\": \"ScoreIndex\",
        \"KeySchema\": [
          {\"AttributeName\":\"UserId\",\"KeyType\":\"HASH\"},
          {\"AttributeName\":\"Score\",\"KeyType\":\"RANGE\"}
        ],
        \"Projection\": {
          \"ProjectionType\":\"ALL\"
        }
      }
    ]"

# Create table with on-demand capacity mode
aws dynamodb create-table \
  --table-name Events \
  --attribute-definitions \
    AttributeName=EventId,AttributeType=S \
    AttributeName=EventDate,AttributeType=S \
  --key-schema \
    AttributeName=EventId,KeyType=HASH \
    AttributeName=EventDate,KeyType=RANGE \
  --billing-mode PAY_PER_REQUEST

# Create table with streams enabled
aws dynamodb create-table \
  --table-name Notifications \
  --attribute-definitions \
    AttributeName=NotificationId,AttributeType=S \
  --key-schema \
    AttributeName=NotificationId,KeyType=HASH \
  --provisioned-throughput \
    ReadCapacityUnits=5,WriteCapacityUnits=5 \
  --stream-specification \
    StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES
```

### List Tables
```
# List all tables
aws dynamodb list-tables

# List tables with pagination
aws dynamodb list-tables --limit 10
aws dynamodb list-tables --limit 10 --exclusive-start-table-name LastTableName
```

### Describe Table
```
# Get table information
aws dynamodb describe-table --table-name Users

# Get specific information with query
aws dynamodb describe-table \
  --table-name Users \
  --query "Table.{Name:TableName,Status:TableStatus,Keys:KeySchema,ProvisionedThroughput:ProvisionedThroughput}"
```

### Update Table
```
# Update provisioned throughput
aws dynamodb update-table \
  --table-name Users \
  --provisioned-throughput \
    ReadCapacityUnits=10,WriteCapacityUnits=10

# Add new Global Secondary Index
aws dynamodb update-table \
  --table-name Products \
  --attribute-definitions \
    AttributeName=Price,AttributeType=N \
  --global-secondary-index-updates \
    "[
      {
        \"Create\": {
          \"IndexName\": \"PriceIndex\",
          \"KeySchema\": [
            {\"AttributeName\":\"Price\",\"KeyType\":\"HASH\"}
          ],
          \"Projection\": {
            \"ProjectionType\":\"ALL\"
          },
          \"ProvisionedThroughput\": {
            \"ReadCapacityUnits\":3,
            \"WriteCapacityUnits\":2
          }
        }
      }
    ]"

# Delete Global Secondary Index
aws dynamodb update-table \
  --table-name Products \
  --global-secondary-index-updates \
    "[
      {
        \"Delete\": {
          \"IndexName\": \"PriceIndex\"
        }
      }
    ]"

# Update Global Secondary Index provisioning
aws dynamodb update-table \
  --table-name Products \
  --global-secondary-index-updates \
    "[
      {
        \"Update\": {
          \"IndexName\": \"CategoryIndex\",
          \"ProvisionedThroughput\": {
            \"ReadCapacityUnits\":5,
            \"WriteCapacityUnits\":5
          }
        }
      }
    ]"

# Change table to on-demand capacity
aws dynamodb update-table \
  --table-name Users \
  --billing-mode PAY_PER_REQUEST

# Change table to provisioned capacity
aws dynamodb update-table \
  --table-name Events \
  --billing-mode PROVISIONED \
  --provisioned-throughput \
    ReadCapacityUnits=5,WriteCapacityUnits=5

# Enable DynamoDB Streams
aws dynamodb update-table \
  --table-name Users \
  --stream-specification \
    StreamEnabled=true,StreamViewType=NEW_AND_OLD_IMAGES

# Disable DynamoDB Streams
aws dynamodb update-table \
  --table-name Users \
  --stream-specification StreamEnabled=false
```

### Delete Table
```
aws dynamodb delete-table --table-name Users
```

## Item Operations

### Put Item (Create/Replace)
```
# Add simple item
aws dynamodb put-item \
  --table-name Users \
  --item '{"UserId": {"S": "user123"}, "Name": {"S": "John Doe"}, "Email": {"S": "john@example.com"}, "Age": {"N": "30"}}'

# Add item with lists and maps
aws dynamodb put-item \
  --table-name Users \
  --item '{
    "UserId": {"S": "user456"},
    "Name": {"S": "Jane Smith"},
    "Email": {"S": "jane@example.com"},
    "Age": {"N": "28"},
    "Addresses": {"L": [
      {"M": {
        "Type": {"S": "Home"},
        "Line1": {"S": "123 Main St"},
        "City": {"S": "Seattle"},
        "State": {"S": "WA"},
        "ZipCode": {"S": "98101"}
      }},
      {"M": {
        "Type": {"S": "Work"},
        "Line1": {"S": "456 Market St"},
        "City": {"S": "Seattle"},
        "State": {"S": "WA"},
        "ZipCode": {"S": "98101"}
      }}
    ]},
    "PhoneNumbers": {"M": {
      "Home": {"S": "555-1234"},
      "Mobile": {"S": "555-5678"}
    }}
  }'

# Add item with conditional expression
aws dynamodb put-item \
  --table-name Users \
  --item '{"UserId": {"S": "user789"}, "Name": {"S": "Bob Johnson"}, "Email": {"S": "bob@example.com"}}' \
  --condition-expression "attribute_not_exists(UserId)"

# Add item with expression attribute values
aws dynamodb put-item \
  --table-name Products \
  --item '{"ProductId": {"S": "prod123"}, "ProductName": {"S": "Smartphone"}, "Price": {"N": "699.99"}, "ProductCategory": {"S": "Electronics"}}' \
  --condition-expression "attribute_not_exists(ProductId) OR Price <> :price" \
  --expression-attribute-values '{":price": {"N": "699.99"}}'

# Add item with return values
aws dynamodb put-item \
  --table-name Users \
  --item '{"UserId": {"S": "user101"}, "Name": {"S": "Sarah Williams"}, "Email": {"S": "sarah@example.com"}}' \
  --return-values ALL_OLD
```

### Get Item (Read)
```
# Get item by primary key
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}'

# Get item with projection expression
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --projection-expression "Name, Email, Age"

# Get item with consistent read
aws dynamodb get-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --consistent-read

# Get item with expression attribute names (for reserved keywords)
aws dynamodb get-item \
  --table-name Products \
  --key '{"ProductId": {"S": "prod123"}}' \
  --projection-expression "#name, #cat, Price" \
  --expression-attribute-names '{"#name": "ProductName", "#cat": "ProductCategory"}'
```

### Update Item
```
# Update single attribute
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --update-expression "SET Age = :newage" \
  --expression-attribute-values '{":newage": {"N": "31"}}' \
  --return-values ALL_NEW

# Update multiple attributes
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --update-expression "SET Email = :email, UpdatedAt = :date" \
  --expression-attribute-values '{":email": {"S": "john.doe@example.com"}, ":date": {"S": "2023-04-15T00:00:00Z"}}'

# Add to a list
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user456"}}' \
  --update-expression "SET Interests = list_append(if_not_exists(Interests, :empty_list), :new_interest)" \
  --expression-attribute-values '{":empty_list": {"L": []}, ":new_interest": {"L": [{"S": "Reading"}, {"S": "Traveling"}]}}'

# Add to a map
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user456"}}' \
  --update-expression "SET PhoneNumbers.Work = :phone" \
  --expression-attribute-values '{":phone": {"S": "555-9876"}}'

# Remove attributes
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --update-expression "REMOVE TemporaryFlag, OldAddress"

# Use arithmetic operations
aws dynamodb update-item \
  --table-name Products \
  --key '{"ProductId": {"S": "prod123"}}' \
  --update-expression "SET Price = Price + :increase, Stock = Stock - :sold" \
  --expression-attribute-values '{":increase": {"N": "50"}, ":sold": {"N": "1"}}'

# Update with condition
aws dynamodb update-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --update-expression "SET Premium = :premium" \
  --condition-expression "Age >= :min_age" \
  --expression-attribute-values '{":premium": {"BOOL": true}, ":min_age": {"N": "30"}}'
```

### Delete Item
```
# Delete item by primary key
aws dynamodb delete-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}'

# Delete with condition
aws dynamodb delete-item \
  --table-name Products \
  --key '{"ProductId": {"S": "prod123"}}' \
  --condition-expression "ProductCategory = :category" \
  --expression-attribute-values '{":category": {"S": "Discontinued"}}'

# Delete and return deleted item
aws dynamodb delete-item \
  --table-name Users \
  --key '{"UserId": {"S": "user123"}}' \
  --return-values ALL_OLD
```

## Query and Scan

### Query Table
```
# Basic query on primary key
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}'

# Query with range key condition
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId AND OrderId > :orderId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}, ":orderId": {"S": "2023-01-01"}}'

# Query with filter expression
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --filter-expression "OrderStatus = :status" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}, ":status": {"S": "Shipped"}}'

# Query with projection expression
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --projection-expression "OrderId, OrderDate, OrderStatus" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}'

# Query Global Secondary Index
aws dynamodb query \
  --table-name Products \
  --index-name CategoryIndex \
  --key-condition-expression "ProductCategory = :category" \
  --expression-attribute-values '{":category": {"S": "Electronics"}}'

# Query Local Secondary Index
aws dynamodb query \
  --table-name GameScores \
  --index-name ScoreIndex \
  --key-condition-expression "UserId = :userId AND Score > :score" \
  --expression-attribute-values '{":userId": {"S": "user123"}, ":score": {"N": "1000"}}'

# Query with limit and pagination
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}' \
  --limit 10

# Continue query with last evaluated key
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}' \
  --limit 10 \
  --exclusive-start-key '{"CustomerId": {"S": "customer123"}, "OrderId": {"S": "2023-03-15-1234"}}'

# Query with sort order
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}' \
  --scan-index-forward false  # descending order

# Query with consistent read
aws dynamodb query \
  --table-name Orders \
  --key-condition-expression "CustomerId = :customerId" \
  --expression-attribute-values '{":customerId": {"S": "customer123"}}' \
  --consistent-read
```

### Scan Table
```
# Basic scan
aws dynamodb scan --table-name Users

# Scan with filter
aws dynamodb scan \
  --table-name Users \
  --filter-expression "Age > :min_age" \
  --expression-attribute-values '{":min_age": {"N": "30"}}'

# Scan with projection expression
aws dynamodb scan \
  --table-name Users \
  --projection-expression "UserId, Name, Email"

# Scan with limit
aws dynamodb scan \
  --table-name Users \
  --limit 10

# Continue scan with last evaluated key
aws dynamodb scan \
  --table-name Users \
  --limit 10 \
  --exclusive-start-key '{"UserId": {"S": "user456"}}'

# Parallel scan (segment 0 of 4 total segments)
aws dynamodb scan \
  --table-name Users \
  --segment 0 \
  --total-segments 4

# Scan with consistent read
aws dynamodb scan \
  --table-name Users \
  --consistent-read
```

## Batch Operations

### Batch Get Item
```
# Get multiple items from different tables
aws dynamodb batch-get-item \
  --request-items '{
    "Users": {
      "Keys": [
        {"UserId": {"S": "user123"}},
        {"UserId": {"S": "user456"}}
      ],
      "ProjectionExpression": "UserId, Name, Email"
    },
    "Products": {
      "Keys": [
        {"ProductId": {"S": "prod123"}},
        {"ProductId": {"S": "prod456"}}
      ],
      "ConsistentRead": true
    }
  }'

# Get multiple items with expression attribute names
aws dynamodb batch-get-item \
  --request-items '{
    "Products": {
      "Keys": [
        {"ProductId": {"S": "prod123"}},
        {"ProductId": {"S": "prod456"}}
      ],
      "ProjectionExpression": "#name, Price",
      "ExpressionAttributeNames": {"#name": "ProductName"}
    }
  }'
```

### Batch Write Item
```
# Put and delete multiple items across tables
aws dynamodb batch-write-item \
  --request-items '{
    "Users": [
      {
        "PutRequest": {
          "Item": {
            "UserId": {"S": "user789"},
            "Name": {"S": "Alex Brown"},
            "Email": {"S": "alex@example.com"}
          }
        }
      },
      {
        "DeleteRequest": {
          "Key": {
            "UserId": {"S": "user101"}
          }
        }
      }
    ],
    "Products": [
      {
        "PutRequest": {
          "Item": {
            "ProductId": {"S": "prod789"},
            "ProductName": {"S": "Wireless Headphones"},
            "Price": {"N": "149.99"},
            "ProductCategory": {"S": "Electronics"}
          }
        }
      }
    ]
  }'
```

## Transactions

### TransactWrite Items
```
# Perform multiple operations as a transaction
aws dynamodb transact-write-items \
  --transact-items '[
    {
      "Put": {
        "TableName": "Orders",
        "Item": {
          "CustomerId": {"S": "customer123"},
          "OrderId": {"S": "order789"},
          "OrderDate": {"S": "2023-04-15"},
          "OrderStatus": {"S": "Pending"}
        },
        "ConditionExpression": "attribute_not_exists(OrderId)"
      }
    },
    {
      "Update": {
        "TableName": "Customers",
        "Key": {
          "CustomerId": {"S": "customer123"}
        },
        "UpdateExpression": "SET OrderCount = OrderCount + :inc",
        "ExpressionAttributeValues": {
          ":inc": {"N": "1"}
        }
      }
    },
    {
      "Update": {
        "TableName": "Inventory",
        "Key": {
          "ProductId": {"S": "prod123"}
        },
        "UpdateExpression": "SET Stock = Stock - :dec",
        "ConditionExpression": "Stock >= :dec",
        "ExpressionAttributeValues": {
          ":dec": {"N": "1"}
        }
      }
    }
  ]'
```

### TransactGet Items
```
# Get multiple items atomically
aws dynamodb transact-get-items \
  --transact-items '[
    {
      "Get": {
        "TableName": "Orders",
        "Key": {
          "CustomerId": {"S": "customer123"},
          "OrderId": {"S": "order789"}
        },
        "ProjectionExpression": "OrderId, OrderStatus, OrderDate"
      }
    },
    {
      "Get": {
        "TableName": "Customers",
        "Key": {
          "CustomerId": {"S": "customer123"}
        },
        "ProjectionExpression": "CustomerId, Name, Email, OrderCount"
      }
    }
  ]'
```

## Table Backups

### Create Backup
```
aws dynamodb create-backup \
  --table-name Users \
  --backup-name Users-Backup-2023-04-15
```

### List Backups
```
# List all backups
aws dynamodb list-backups

# List backups for a specific table
aws dynamodb list-backups --table-name Users

# List backups by time range
aws dynamodb list-backups \
  --time-range-lower-bound 2023-01-01T00:00:00Z \
  --time-range-upper-bound 2023-04-01T00:00:00Z
```

### Describe Backup
```
aws dynamodb describe-backup --backup-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users/backup/01234567890123456789012345
```

### Delete Backup
```
aws dynamodb delete-backup --backup-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users/backup/01234567890123456789012345
```

### Restore Table From Backup
```
aws dynamodb restore-table-from-backup \
  --target-table-name Users-Restored \
  --backup-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users/backup/01234567890123456789012345
```

## Point-in-Time Recovery

### Enable Point-in-Time Recovery
```
aws dynamodb update-continuous-backups \
  --table-name Users \
  --point-in-time-recovery-specification PointInTimeRecoveryEnabled=true
```

### Describe Continuous Backups Status
```
aws dynamodb describe-continuous-backups --table-name Users
```

### Restore Table to Point in Time
```
aws dynamodb restore-table-to-point-in-time \
  --source-table-name Users \
  --target-table-name Users-Restored \
  --restore-date-time 2023-04-10T12:00:00Z
```

## Table TTL (Time to Live)

### Enable TTL
```
aws dynamodb update-time-to-live \
  --table-name Sessions \
  --time-to-live-specification "Enabled=true,AttributeName=ExpirationTime"
```

### Describe TTL
```
aws dynamodb describe-time-to-live --table-name Sessions
```

## Export to S3

### Export Table to S3
```
aws dynamodb export-table-to-point-in-time \
  --table-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users \
  --s3-bucket my-dynamodb-exports \
  --s3-prefix exports/users \
  --export-format DYNAMODB_JSON
```

### List Exports
```
aws dynamodb list-exports
```

### Describe Export
```
aws dynamodb describe-export \
  --export-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users/export/01234567890123456789012345
```

## Resource Tagging

### Tag Resource
```
aws dynamodb tag-resource \
  --resource-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users \
  --tags Key=Environment,Value=Production Key=Owner,Value=DataTeam
```

### List Tags
```
aws dynamodb list-tags-of-resource \
  --resource-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users
```

### Untag Resource
```
aws dynamodb untag-resource \
  --resource-arn arn:aws:dynamodb:us-east-1:123456789012:table/Users \
  --tag-keys Environment Owner
```

## Output Formatting

### Format as Table
```
aws dynamodb scan --table-name Users --output table
```

### Format as JSON
```
aws dynamodb scan --table-name Users --output json
```

### Use Query for Specific Fields
```
# Get table metadata
aws dynamodb describe-table \
  --table-name Users \
  --query "Table.{Name:TableName,Status:TableStatus,ItemCount:ItemCount,Size:TableSizeBytes}"

# Format scan results
aws dynamodb scan \
  --table-name Users \
  --query "Items[*].{ID:UserId.S,Name:Name.S,Email:Email.S}"

# Get specific indexes
aws dynamodb describe-table \
  --table-name Products \
  --query "Table.GlobalSecondaryIndexes[*].{Name:IndexName,Status:IndexStatus}"
```
