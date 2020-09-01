resource "google_dns_managed_zone" "primary" {
  name        = var.dns_zone_name
  dns_name    = "${var.domain_name}."
  description = "DNS zone for K8s cluster ingress"
}

resource "google_dns_record_set" "public" {
  name = google_dns_managed_zone.primary.dns_name
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.primary.name

  rrdatas = [var.ip]
}

resource "google_dns_record_set" "subdomains" {
  count = length(var.subdomains)

  name = "${var.subdomains[count.index]}.${google_dns_managed_zone.primary.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = google_dns_managed_zone.primary.name

  rrdatas = [var.ip]
}

# resource "aws_subnet" "example" {
#   for_each = var.subnet_numbers

#   vpc_id            = aws_vpc.example.id
#   availability_zone = each.key
#   cidr_block        = cidrsubnet(aws_vpc.example.cidr_block, 8, each.value)
# }