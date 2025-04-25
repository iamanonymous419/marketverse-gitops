# AWS CLI Commands for Networking - Cheatsheet

This cheatsheet provides commonly used AWS CLI commands to manage AWS networking resources including VPCs, subnets, route tables, internet gateways, NAT gateways, and more.

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