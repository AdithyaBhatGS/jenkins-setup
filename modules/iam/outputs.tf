# Represents the ARN of Instance profile
output "aws_ec2_instance_profile_name" {
  value       = aws_iam_instance_profile.ec2_instance_profile.name
  description = "The ARN of the Instance Profile containing the IAM role for the EC2 instance"
}
