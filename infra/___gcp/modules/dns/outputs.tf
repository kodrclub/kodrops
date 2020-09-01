output dns_zone {value = google_dns_managed_zone.primary}
output name_servers {value = google_dns_managed_zone.primary.name_servers}