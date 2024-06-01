module "zone_level_managed_waf" {
  source = "../.." # Update the path to your module

  # Pass required variables to the module
  zone_name    = "terrasible.com"
  ruleset_name = "managed WAF ruleset name"
  description  = "managed WAF ruleset description"
  kind         = "zone"
  phase        = "http_request_firewall_managed"

  rules = [
    {
      action = "execute"
      action_parameters = {
        id = "efb7b8c949ac4650a09736fc376e9aee"
      }
      expression  = "(http.host eq \"example.host.com\")"
      description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
      enabled     = true
    },
    {
      action = "execute"
      action_parameters = {
        id = "efb7b8c949ac4650a09736fc376e9aee"
        overrides = {
          categories = {
              category = "wordpress"
              action   = "block"
              enabled  = true
            }
        }
      }
      expression  = "(http.host eq \"example.host.com\")"
      description = "overrides to only enable wordpress rules to block"
      enabled     = false
    }
    ]
}

