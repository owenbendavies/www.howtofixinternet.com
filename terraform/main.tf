module "cloudflare" {
  source = "./modules/cloudflare"

  google_verification = var.google_verification
  site_domain         = var.site_domain
  target_domain       = var.target_domain
}

module "datadog" {
  source = "./modules/datadog"

  site_domain = var.site_domain
}
