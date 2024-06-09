terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.8"
}

module "rulesets_example_zone-level-custom-waf" {
  source       = "terrasible/rulesets/cloudflare"
  version      = "0.3.0"
  zone_name    = "terrasible.com"
  ruleset_name = "my custom waf ruleset"
  #description  = "Block request from source IP and execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
  kind  = "zone"
  phase = "http_request_firewall_custom"

  #   rules = [
  #     {
  #       action      = "block"
  #       expression  = "(http.host eq \"prod.example.com\" and ip.src in {34.56.xx.xx/32 34.67.xx.xx/32})"
  #       description = "Block request from source IP"
  #       enabled     = true
  #       action_parameters = {
  #         response = [
  #           {
  #             content      = <<-EOT
  #                 <!DOCTYPE html>
  #                 <html lang="en">
  #                 <head>
  #                 <meta charset="UTF-8">
  #                 <meta name="viewport" content="width=device-width, initial-scale=1.0">
  #                 <title>Access Denied</title>
  #                 </head>
  #                 <body style="background-color: Brown;">
  #                 <h1>Ooops! You are not allowed to access this page.</h1>
  #                 </body>
  #                 </html>
  #               EOT
  #             content_type = "text/html"
  #             status_code  = 403
  #           }
  #         ]
  #       }
  #     },
  #   ]
}
