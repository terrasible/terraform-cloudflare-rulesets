module "http_request_firewall_custom" {
  source = "../.." # Update the path to your module

  # Pass required variables to the module
  account_name = "terrasible.com"
  ruleset_name = "my custom waf ruleset"
  description  = "Block request from source IP and execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
  kind         = "zone"
  phase        = "http_request_firewall_custom"

  rules = [
    {
      action      = "block"
      expression  = "(http.host eq \"prod.example.com\" and ip.src in {34.56.xx.xx/32 34.67.xx.xx/32})"
      description = "Block request from source IP"
      enabled     = true
      action_parameters = {
        response = [
          {
            content      = <<-EOT
                                    <!DOCTYPE html>
                <html lang="en">
                <head>
                <meta charset="UTF-8">


                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Access Denied</title>
                </head>
                <body style="background-color: OrangeRed;">
                <h1>Ooops! You are not allowed to access this page.</h1>
                </body>
                </html>
              EOT
            content_type = "text/html"
            status_code  = 403
          }
        ]
      }
    },
    {
      action      = "execute"
      expression  = "(http.host eq \"example.host.com\")"
      description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
      enabled     = true
      action_parameters = {
        id = "efb7b8c949ac4650a09736fc376e9aee"
        overrides = {
          categories = [
            {
              category = "wordpress"
              action   = "block"
              enabled  = true
            },
            {
              category = "joomla"
              action   = "block"
              enabled  = true
            }
          ]
        }

      }
    }
  ]
}
