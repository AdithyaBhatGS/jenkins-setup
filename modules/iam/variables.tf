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
