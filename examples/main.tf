module "managed_waf" {
  source = "../" # Update the path to your module

  # Pass required variables to the module
  zone_name    = "honestbank.com"
  ruleset_name = "your_ruleset_name"
  description  = "Your ruleset description"
  kind         = "zone"
  phase        = "http_request_firewall_custom"

  # Define the rules to be created
  rules = [
    {
      action      = "serve_error"
      expression  = "(http.request.uri.path matches \"^/api/\")"
      description = "Serve some error response"
      enabled     = true
      action_parameters = {
        content      = "some error html"
        content_type = "text/html"
        status_code  = "530"
      }
      exposed_credential_check = {
        password_expression = "http.request.uri.path"
        username_expression = "http.request.uri.query"
      }
    },
    {
      action      = "redirect"
      expression  = "(http.request.uri.path matches \"^/api/\")"
      description = "Apply redirect from value"
      enabled     = true
      action_parameters = {
        from_value = {
          status_code = 301
          target_url = {
            value = "some_host.com"
          }
          preserve_query_string = true
        }
      }
    }
  ]
}
