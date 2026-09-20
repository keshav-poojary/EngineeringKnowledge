resource "aws_instance" "nginx-server"{
  ami="ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [ aws_security_group.my-sg.id ]
  associate_public_ip_address = true


  user_data = <<-EOF
  
  #!/bin/bash
  sudo yum install nginx -y
  sudo systemctl start nginx

  EOF

  tags = {
    Name="nginx-Server"
  }
}