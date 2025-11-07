terraform {
  backend "s3" {
    bucket         = "terraform-state-12913"
    key            = "jenkins-setup/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-12913"
    encrypt        = true
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["C:/Users/adith/.aws/credentials"]
  default_tags {
    tags = {
      Project     = "Jenkins-Setup"
      Environment = "Dev"
      Terraform   = "true"
    }
  }
}

resource "aws_vpc" "jenkins_vpc" {
  for_each         = var.vpc_config
  cidr_block       = each.value.cidr_block
  instance_tenancy = each.value.instance_tenancy

  tags = each.value.tags
}

resource "aws_subnet" "jenkins_subnet" {
  for_each   = var.jenkins_subnet
  vpc_id     = aws_vpc.jenkins_vpc.id
  cidr_block = each.value.cidr_block

  tags = each.value.tags
}

resource "aws_internet_gateway" "jenkins_igw" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = var.jenkins_igw_tag
}

resource "aws_route_table" "jenkins_rt" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = var.jenkins_rt_tag
}

resource "aws_route" "jenkins_route" {
  route_table_id         = aws_route_table.jenkins_rt.id
  for_each               = var.jenkins_route_data
  destination_cidr_block = each.value.destination_cidr_block
  gateway_id             = aws_route_table.jenkins_rt.id
}

resource "aws_route_table_association" "jenkins_rt_assoc" {
  subnet_id      = aws_subnet.jenkins_subnet["jenkins_public_subnet"].id
  route_table_id = aws_route_table.jenkins_rt.id
}

resource "aws_security_group" "jenkins_sg" {
  for_each    = var.jenkins_sg
  name        = each.value.name
  description = each.value.description
  vpc_id      = aws_vpc.jenkins_vpc.id
  tags        = each.value.tags
}

resource "aws_vpc_security_group_ingress_rule" "jenkins_inbound" {
  security_group_id = aws_security_group.jenkins_sg.id
  for_each          = var.jenkins_inbound
  cidr_ipv4         = each.value.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.protocol
  to_port           = each.value.to_port
}


module "iam" {
  source                   = "../modules/iam"
  ec2_role_name            = var.ec2_role_name
  ec2_role_description     = var.ec2_role_description
  ec2_role_tags            = var.ec2_role_tags
  ssm_policy_arn           = var.ssm_policy_arn
  aws_iam_instance_profile = var.aws_iam_instance_profile
}


resource "aws_instance" "jenkins_server" {
  ami                    = var.jenkins_server_ami
  instance_type          = var.jenkins_server_instance_type
  subnet_id              = aws_subnet.jenkins_subnet["jenkins_public_subnet"].id
  vpc_security_group_ids = [aws_security_group.jenkins_sg["jenkins_server_sg"].id]

  user_data                   = file("${path.module}/scripts/jenkins_setup.sh")
  associate_public_ip_address = true
  iam_instance_profile        = module.iam.aws_ec2_instance_profile_name
  tags                        = var.jenkins_server_tags
}


