module "zone_level_request_transform_ruleset_engine" {
  source = "../.." # Update the path to your module

  zone_name    = "terrasible.com"
  ruleset_name = "transform rule for HTTP headers"
  description  = "modify HTTP headers before reaching origin"
  kind         = "zone"
  phase        = "http_request_late_transform"
  rules = [
    {
      action      = "rewrite"
      expression  = "(http.host eq \"example.host.com\")"
      description = "example request header transform rule"
      enabled     = false
      action_parameters = {
        headers = [
          {
            name      = "example-http-header-1"
            operation = "set"
            value     = "my-http-header-value-1"
          },
          {
            name       = "example-http-header-2"
            operation  = "set"
            expression = "cf.zone.name"
          },
          {
            name      = "example-http-header-3-to-remove"
            operation = "remove"
          }
        ]
      }
    }
  ]
}
