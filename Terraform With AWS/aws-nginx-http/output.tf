output "public-ip-address" {
  description = "public ip of nginx server"
  value = aws_instance.nginx-server.public_ip
}