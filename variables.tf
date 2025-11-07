variable "region" {
  type = string
}

variable "vpc_config" {
  type = map(object({
    cidr_block       = string
    instance_tenancy = string
    tags             = map(string)
  }))
}

variable "jenkins_subnet" {
  type = map(object({
    cidr_block = string
    tags       = map(string)
  }))
}

variable "jenkins_igw_tag" {
  type = map(string)
}

variable "jenkins_rt_tag" {
  type = map(string)
}

variable "jenkins_route_data" {
  type = map(object({
    destination_cidr_block = string
  }))
}

variable "jenkins_sg" {
  type = map(object({
    name        = string
    description = string
    tags        = map(string)
  }))
}

variable "jenkins_inbound" {
  type = map(object({
    cidr_ipv4 = string
    from_port = number
    to_port   = number
    protocol  = string
  }))
}

variable "ec2_role_name" {
  type        = string
  description = "Represents the name of the EC2 Role"
}

variable "ec2_role_description" {
  type        = string
  description = "Represents the description of the Role attached to the instance"
}

variable "ec2_role_tags" {
  type        = map(string)
  description = "Represents the tags attached to the Role attached to the instance"
}

variable "ssm_policy_arn" {
  type        = string
  description = "Represents the ARN for the SSM policy"
}

variable "aws_iam_instance_profile" {
  type        = string
  description = "Represents the Instance Profile attached to the EC2 resource"
}

variable "jenkins_server_ami" {
  type = string
}

variable "jenkins_server_instance_type" {
  type = string
}

variable "jenkins_server_tags" {
  type = map(string)
}
