resource "cloudflare_page_rule" "root_redirect" {
  target  = "${var.site_domain}/*"
  zone_id = cloudflare_zone.main.id

  actions {
    forwarding_url {
      status_code = "301"
      url         = "https://www.${var.site_domain}/$1"
    }
  }
}

resource "cloudflare_record" "dmarc" {
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=reject"
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_record" "google_verification" {
  name    = var.site_domain
  type    = "TXT"
  value   = var.google_verification
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_record" "site_root" {
  name    = var.site_domain
  proxied = true
  type    = "CNAME"
  value   = var.target_domain
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_record" "site_www" {
  name    = "www"
  proxied = true
  type    = "CNAME"
  value   = var.target_domain
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_record" "spf" {
  name    = var.site_domain
  type    = "TXT"
  value   = "v=spf1 -all"
  zone_id = cloudflare_zone.main.id
}

resource "cloudflare_zone" "main" {
  zone = var.site_domain
}

resource "cloudflare_zone_settings_override" "main" {
  zone_id = cloudflare_zone.main.id

  settings {
    cache_level         = "simplified"
    server_side_exclude = "off"
  }
}
