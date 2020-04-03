## Create the security group ##
resource "aws_security_group" "grafana_allow_http_incoming" {
  name        = "jq-grafana-allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.aws_vpc_id
  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 65000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "grafana_allow_http_incoming"
  }
}