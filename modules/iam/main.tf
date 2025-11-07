# Generating a Trust policy "AssumeRole" for EC2
data "aws_iam_policy_document" "trust_policy_for_ec2" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attaching the Trust policy for the IAM Role
resource "aws_iam_role" "ec2_ssm_role" {
  name               = var.ec2_role_name
  assume_role_policy = data.aws_iam_policy_document.trust_policy_for_ec2.json
  description        = var.ec2_role_description
  tags               = var.ec2_role_tags
}

# Attaching the managed policy for the IAM Role
resource "aws_iam_role_policy_attachment" "ssm_managed_policy" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = var.ssm_policy_arn
}

# Creating an Instance profile for the EC2 resource
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = var.aws_iam_instance_profile
  role = aws_iam_role.ec2_ssm_role.name
}

