## Create the domain name of Grafana ##
resource "aws_acm_certificate" "certificate" {
  // wildcard cert so we can host subdomains later.
  domain_name       = var.grafana_domain_name
  validation_method = "DNS"
}

resource "aws_route53_record" "validation" {
  name    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id = "${var.domain_zone_id}"
  records = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}


resource "aws_route53_record" "static" {
  zone_id = "${var.domain_zone_id}"
  name    = "${var.grafana_domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_elb.grafana_elb.dns_name}"
    zone_id                = "${aws_elb.grafana_elb.zone_id}"
    evaluate_target_health = false
  }
}