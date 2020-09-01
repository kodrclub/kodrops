# resource "dnsimple_record" "ns" {
#   count = 4 #length(var.name_servers)

#   domain = var.domain_name
#   name   = ""
#   value  = var.name_servers[count.index]
#   type   = "NS"
#   ttl    = 3600
# }

resource "dnsimple_record" "main" {
  domain = var.domain_name
  name   = "@"
  value  = var.ip
  type   = "A"
  ttl    = 3600
}

resource "dnsimple_record" "sub" {
  count = length(var.subdomains)

  domain = var.domain_name
  name   = var.subdomains[count.index]
  value  = var.ip
  type   = "A"
  ttl    = 3600
}
