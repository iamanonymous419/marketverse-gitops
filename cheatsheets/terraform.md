# Terraform Cheatsheet

## Terraform Basics

### Installation & Setup
```bash
# Install Terraform (macOS with Homebrew)
brew install terraform

# Install Terraform (Linux with wget)
wget https://releases.hashicorp.com/terraform/1.7.4/terraform_1.7.4_linux_amd64.zip
unzip terraform_1.7.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Check version
terraform version

# Initialize working directory
terraform init

# Initialize with plugin caching
terraform init -plugin-dir=~/.terraform.d/plugins
```

### Core Commands
```bash
# Format code per HCL canonical standard
terraform fmt

# Validate configuration syntax
terraform validate

# Generate execution plan
terraform plan

# Apply changes
terraform apply

# Apply with auto-approval
terraform apply -auto-approve

# Destroy resources
terraform destroy

# Destroy specific resource
terraform destroy -target=aws_instance.example

# Show state
terraform show

# Output specific values
terraform output
terraform output instance_ip
```

## State Management

```bash
# List resources in state
terraform state list

# Show details of resource in state
terraform state show aws_instance.example

# Move item in state
terraform state mv aws_instance.old aws_instance.new

# Remove item from state
terraform state rm aws_instance.example

# Pull current state
terraform state pull > terraform.tfstate

# Push state from local file
terraform state push terraform.tfstate

# Force unlock state
terraform force-unlock LOCK_ID
```

## Workspace Management

```bash
# List workspaces
terraform workspace list

# Create workspace
terraform workspace new dev

# Select workspace
terraform workspace select prod

# Show current workspace
terraform workspace show

# Delete workspace
terraform workspace delete staging
```

## Variables & Outputs

```hcl
# Define variables (variables.tf)
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "AWS region to deploy resources"
}

variable "instance_count" {
  type        = number
  default     = 1
}

variable "allowed_ips" {
  type        = list(string)
  default     = ["10.0.0.0/24", "192.168.1.0/24"]
}

variable "tags" {
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "terraform"
  }
}

# Define outputs (outputs.tf)
output "instance_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the web instance"
}

output "load_balancer_dns" {
  value       = aws_lb.example.dns_name
  sensitive   = false
}
```

### Using Variables
```bash
# Pass variables on command line
terraform apply -var="region=us-east-1" -var="instance_count=3"

# Using variable files
terraform apply -var-file="prod.tfvars"

# Using environment variables
export TF_VAR_region=us-east-1
terraform apply
```

## Provider Configuration

```hcl
# AWS Provider
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  profile    = "default"
}

# Azure Provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Google Cloud Provider
provider "google" {
  credentials = file("account.json")
  project     = var.project_id
  region      = var.region
}

# Multiple Provider Configurations
provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

provider "aws" {
  alias  = "east"
  region = "us-east-1"
}
```

## Resource Configuration

```hcl
# Basic resource
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags          = var.tags
}

# Resource with count
resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags          = {
    Name = "Server-${count.index + 1}"
  }
}

# Resource with for_each (map)
resource "aws_instance" "web" {
  for_each      = var.server_settings
  ami           = each.value.ami
  instance_type = each.value.type
  tags          = {
    Name = each.key
  }
}

# Resource with for_each (set)
resource "aws_subnet" "example" {
  for_each          = toset(var.subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = "${var.region}${count.index % 2 == 0 ? "a" : "b"}"
}

# Resource with lifecycle rules
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  lifecycle {
    create_before_destroy = true
    prevent_destroy       = true
    ignore_changes        = [tags]
  }
}
```

## Data Sources

```hcl
# Get the latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Use in a resource
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
}

# Data source for availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
```

## Modules

```hcl
# Use a module (main.tf)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"
  
  name            = "my-vpc"
  cidr            = "10.0.0.0/16"
  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  
  enable_nat_gateway = true
  single_nat_gateway = true
}

# Create a module (modules/webserver/main.tf)
variable "instance_type" {
  default = "t2.micro"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
}

output "instance_ip" {
  value = aws_instance.web.public_ip
}

# Use local module
module "webserver" {
  source        = "./modules/webserver"
  instance_type = "t2.small"
}
```

## Terraform Cloud/Enterprise

```bash
# Login to Terraform Cloud
terraform login

# Initialize with backend config
terraform init -backend-config="token=<TOKEN>"

# Backend configuration (main.tf)
terraform {
  backend "remote" {
    organization = "my-org"
    
    workspaces {
      name = "my-app-prod"
    }
  }
}

# Specify backend during init
terraform init \
  -backend-config="organization=my-org" \
  -backend-config="workspaces.name=my-app-prod"
```

## Advanced Features

### Templating
```hcl
# Using templatefile
locals {
  user_data = templatefile("${path.module}/user-data.sh.tpl", {
    server_port = var.server_port
    db_address  = aws_db_instance.example.address
    db_port     = aws_db_instance.example.port
  })
}

resource "aws_instance" "example" {
  user_data = local.user_data
  # ...
}
```

### Provisioners
```hcl
resource "aws_instance" "web" {
  # ...
  
  provisioner "file" {
    source      = "app.conf"
    destination = "/etc/app.conf"
    
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${path.module}/key.pem")
      host        = self.public_ip
    }
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y update",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }
  
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
}
```

### Dynamic Blocks
```hcl
resource "aws_security_group" "example" {
  name = "example"
  
  dynamic "ingress" {
    for_each = var.service_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
```

### Conditional Expression
```hcl
resource "aws_instance" "example" {
  instance_type = var.environment == "prod" ? "m5.large" : "t2.micro"
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0
  # ...
}
```

### Import Existing Resources
```bash
# Import existing resources
terraform import aws_instance.web i-abcd1234

# Import with state specification
terraform import 'aws_instance.web[0]' i-abcd1234
terraform import 'aws_security_group.allow[\"http\"]' sg-123456
```

## Project Structure Best Practices

```
project/
├── main.tf           # Main resources
├── variables.tf      # Input variable declarations
├── outputs.tf        # Output declarations
├── providers.tf      # Provider configurations
├── versions.tf       # Required versions
├── terraform.tfvars  # Variable values (gitignored for sensitive values)
├── dev.tfvars        # Dev environment variables
├── prod.tfvars       # Production environment variables
└── modules/          # Local modules
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```