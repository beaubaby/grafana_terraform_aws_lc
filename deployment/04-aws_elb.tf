## Create the load balancer ##
resource "aws_elb" "grafana_elb" {
  name               = "grafana-elb"
  security_groups    = ["${aws_security_group.grafana_allow_http_incoming.id}"]
  subnets            = var.public_subnets

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 443
    lb_protocol       = "https"
    ssl_certificate_id = aws_acm_certificate.certificate.id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:3000/login"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}