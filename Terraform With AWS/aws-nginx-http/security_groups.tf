resource "aws_security_group" "my-sg" {
  vpc_id = aws_vpc.my-vpc.id
 
  //in bound traffic for http
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  //outbound traffic 
  egress  {
    from_port=0
    to_port=0
    protocol="-1"
    cidr_blocks=["0.0.0.0/0"]
  }
}