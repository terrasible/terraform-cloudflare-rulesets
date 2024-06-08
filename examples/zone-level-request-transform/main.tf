module "zone_level_request_transform" {
  source = "../.." # Update the path to your module

  zone_name    = "terrasible.com"
  ruleset_name = "transform rule for URI query parameter"
  description  = "change the URI query to a new static query"
  kind         = "zone"
  phase        = "http_request_transform"

  rules = [
    {
      action      = "rewrite"
      expression  = "(http.host eq \"example.host.com\")"
      description = "overrides to only enable wordpress rules to block"
      enabled     = false
      action_parameters = {
        uri = {
          path = {
            value = "/my-new-route"
          }

        }
      }
    },
    {
      action      = "rewrite"
      expression  = "(http.host eq \"example.host.com\")"
      description = "overrides to only enable wordpress rules to block"
      enabled     = false
      action_parameters = {
        uri = {
          query = {
            value = "old=new_again"
          }
        }
      }
    },
  ]
}
