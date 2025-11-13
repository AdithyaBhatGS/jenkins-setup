output "jenkins_config" {
  value = {
    vpc_id             = aws_vpc.jenkins_vpc["jenkins_vpc_1"].id
    subnet_id          = aws_subnet.jenkins_subnet["jenkins_public_subnet"].id
    security_group_id  = aws_security_group.jenkins_sg["jenkins_server_sg"].id
    jenkins_server_ip  = aws_instance.jenkins_server.public_ip
    jenkins_server_dns = aws_instance.jenkins_server.public_dns
  }
}
