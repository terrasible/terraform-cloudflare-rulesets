# Cloudflare Ruleset Engine Terraform Module
Terraform Modules for provisioning Cloudflare ruleset engine resources.

## Usage

See [examples](./examples) directory for working examples to reference:

```hcl
module "custom_waf_ruleset" {
  source = "../.." # Update the path to your module

  # Pass required variables to the module
  zone_name    = "example.com"
  ruleset_name = "example ruleset name"
  description  = "Block request traffic from specific source ip and path"
  kind         = "zone"
  phase        = "http_request_firewall_custom"

  # Define the rules to be created
  rules = [
    {
      action     = "block"
      expression = "http.request.uri.path matches \"^/wp-admin\""
      description = "Block requests to wp-admin"
      enabled     = true
    },
    {
      action     = "block"
      expression = "(http.host eq \"prod.example.com\" and ip.src in {34.56.xx.xx/32 34.67.xx.xx/32})"
      description = "Block request from source ip"
      enabled     = true
      action_parameters = {
        response = {
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
      }
    }
  ]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
README.md updated successfully
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.8 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_ruleset.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/ruleset) | resource |
| [cloudflare_accounts.account_data](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/accounts) | data source |
| [cloudflare_zone.zone_data](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Creating custom rulesets at the account level is a paid feature. Please ensure the feature is enabled. The 'kind' parameter must be set to 'custom', and for a phase entry point ruleset at the account level, set the value to 'root'. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Brief summary of the ruleset and its intended use | `string` | `null` | no |
| <a name="input_kind"></a> [kind](#input\_kind) | Cloudflare ruleset kinds include: custom (user-defined), entry point (serves as the entrypoint for phases - can be set to 'root' at the account level and 'zone' at the zone level), and managed (preconfigured by Cloudflare). | `string` | n/a | yes |
| <a name="input_phase"></a> [phase](#input\_phase) | Phase refers to a stage in the process of handling a request/response lifecycle. Refer doc https://developers.cloudflare.com/ruleset-engine/reference/phases-list/ | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | List of rules to apply to the ruleset | <pre>list(object({<br>    action      = optional(string)<br>    expression  = string<br>    description = optional(string)<br>    enabled     = optional(bool)<br>    ref         = optional(string)<br>    exposed_credential_check = optional(object({<br>      password_expression = optional(string)<br>      username_expression = optional(string)<br>    }))<br>    logging = optional(object({<br>      enabled = bool<br>    }))<br>    ratelimit = optional(object({<br>      characteristics            = optional(string)<br>      counting_expression        = optional(string)<br>      mitigation_timeout         = optional(string)<br>      period                     = optional(string)<br>      requests_per_period        = optional(string)<br>      requests_to_origin         = optional(string)<br>      score_per_period           = optional(string)<br>      score_response_header_name = optional(string)<br>    }))<br>    action_parameters = optional(object({<br>      additional_cacheable_ports = optional(set(number))<br>      automatic_https_rewrites   = optional(bool)<br>      bic                        = optional(bool)<br>      cache                      = optional(bool)<br>      content                    = optional(string)<br>      content_type               = optional(string)<br>      cookie_fields              = optional(list(string))<br>      disable_apps               = optional(bool)<br>      disable_railgun            = optional(bool)<br>      disable_zaraz              = optional(bool)<br>      email_obfuscation          = optional(bool)<br>      host_header                = optional(string)<br>      hotlink_protection         = optional(bool)<br>      id                         = optional(string)<br>      increment                  = optional(number)<br>      mirage                     = optional(bool)<br>      opportunistic_encryption   = optional(bool)<br>      origin_cache_control       = optional(bool)<br>      origin_error_page_passthru = optional(bool)<br>      phases                     = optional(set(string))<br>      polish                     = optional(string)<br>      products                   = optional(list(string))<br>      read_timeout               = optional(number)<br>      request_fields             = optional(list(string))<br>      respect_strong_etags       = optional(bool)<br>      rocket_loader              = optional(bool)<br>      rules                      = optional(map(string))<br>      ruleset                    = optional(string)<br>      rulesets                   = optional(list(string))<br>      security_level             = optional(string)<br>      server_side_excludes       = optional(bool)<br>      ssl                        = optional(string)<br>      status_code                = optional(number)<br>      sxg                        = optional(bool)<br>      version                    = optional(string)<br>      algorithms = optional(object({<br>        name = optional(string)<br>      }))<br>      autominify = optional(object({<br>        css  = optional(bool)<br>        html = optional(bool)<br>        js   = optional(bool)<br>      }))<br>      browser_ttl = optional(object({<br>        mode    = string<br>        default = optional(string)<br>      }))<br>      cache_key = optional(object({<br>        cache_by_device_type  = optional(string)<br>        cache_deception_armor = optional(string)<br>        custom_key = optional(object({<br>          cookie = optional(object({<br>            check_presence = optional(list(string))<br>            include        = optional(list(string))<br>          }), null)<br>          header = optional(object({<br>            check_presence = optional(list(string))<br>            exclude_origin = optional(bool)<br>            include        = optional(list(string))<br>          }))<br>          host = optional(list(object({<br>            resolved = optional(bool)<br>          })))<br>          query_string = optional(list(object({<br>            exclude = optional(list(string))<br>            include = optional(list(string))<br>          })))<br>          user = optional(list(object({<br>            device_type = optional(bool)<br>            geo         = optional(bool)<br>            lang        = optional(bool)<br>          })))<br>        }))<br>        ignore_query_strings_order = optional(string)<br>      }), null)<br>      edge_ttl = optional(object({<br>        mode    = string<br>        default = optional(number)<br>        status_code_ttl = optional(list(object({<br>          status_code = optional(number)<br>          value       = optional(number)<br>          status_code_range = optional(object({<br>            from = optional(number)<br>            to   = optional(number)<br>          }))<br>        })))<br>      }))<br>      from_list = optional(object({<br>        key  = optional(string)<br>        name = optional(string)<br>      }))<br>      from_value = optional(object({<br>        status_code = optional(number)<br>        target_url = optional(object({<br>          value = optional(string)<br>        }))<br>        preserve_query_string = optional(bool)<br>      }))<br>      headers = optional(list(object({<br>        expression = optional(string)<br>        name       = optional(string)<br>        operation  = optional(string)<br>        value      = optional(string)<br>      })), [])<br>      matched_data = optional(list(object({<br>        public_key = optional(string)<br>      })), [])<br>      origin = optional(list(object({<br>        host = optional(string)<br>        port = optional(number)<br>      })), [])<br>      overrides = optional(object({<br>        action            = optional(string)<br>        sensitivity_level = optional(string)<br>        enabled           = optional(bool)<br>        categories = optional(list(object({<br>          action   = optional(string)<br>          category = optional(string)<br>          enabled  = optional(bool)<br>        })), [])<br>        rules = optional(list(object({<br>          action            = optional(string)<br>          enabled           = optional(bool)<br>          id                = optional(string)<br>          score_threshold   = optional(number)<br>          sensitivity_level = optional(string)<br>        })), [])<br>      }), null)<br>      response = optional(list(object({<br>        content      = optional(string)<br>        content_type = optional(string)<br>        status_code  = optional(number)<br>      })), [])<br>      serve_stale = optional(object({<br>        disable_stale_while_updating = optional(bool)<br>      }))<br>      sni = optional(object({<br>        value = optional(string)<br>      }))<br>      uri = optional(object({<br>        origin = optional(bool)<br>        path = optional(object({<br>          expression = optional(string)<br>          value      = optional(string)<br>        }))<br>        query = optional(object({<br>          expression = optional(string)<br>          value      = optional(string)<br>        }))<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_ruleset_name"></a> [ruleset\_name](#input\_ruleset\_name) | The name of the Cloudflare ruleset | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The name of the Cloudflare zone. This is required if kind is set to zone. Only one of zone\_name or account\_name can be set. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rules"></a> [rules](#output\_rules) | cloudflare ruleset engine rules |
<!-- END_TF_DOCS -->
