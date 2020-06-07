resource "datadog_synthetics_test" "main" {
  message = "Notify @all"
  name    = "www.${var.site_domain}"
  status  = "live"
  tags    = ["terraform"]
  type    = "api"

  assertions = [
    {
      operator = "is"
      target   = "200"
      type     = "statusCode"
    },
    {
      operator = "is"
      property = "content-type"
      type     = "header"
      target   = "text/html; charset=utf-8"
    },
    {
      operator = "lessThan"
      type     = "responseTime"
      target   = 6000
    }
  ]

  options = {
    min_failure_duration = 180,
    min_location_failed  = 2,
    tick_every           = 60,
  }

  request = {
    method  = "GET"
    timeout = 30
    url     = "https://www.${var.site_domain}/"
  }

  locations = [
    "aws:ca-central-1",
    "aws:eu-central-1",
    "aws:eu-west-1",
    "aws:eu-west-2",
    "aws:us-east-2",
    "aws:us-west-1",
    "aws:us-west-2"
  ]
}
