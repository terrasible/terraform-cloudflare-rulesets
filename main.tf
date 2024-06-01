# To get the zone id from the zone name
data "cloudflare_zone" "zone_data" {
  count = var.zone_name != null ? 1 : 0

  name = var.zone_name
}

# To get the account id from the account name. Account-level WAF configuration requires an Enterprise plan with a paid add-on.
data "cloudflare_accounts" "account_data" {
  count = var.account_name != null ? 1 : 0

  name = var.account_name
}

# Import the existing ruleset deployed at the zone or account level.
# New Creation of ruleset will fail if any other ruleset is deployed to the same phase.

resource "cloudflare_ruleset" "this" {
  name        = var.ruleset_name
  description = var.description
  zone_id     = var.zone_name != null ? data.cloudflare_zone.zone_data[0].id : null
  account_id  = var.account_name != null ? data.cloudflare_accounts.account_data[0].id : null
  kind        = var.kind
  phase       = var.phase

  dynamic "rules" {
    for_each = length(var.rules) > 0 ? var.rules : []

    content {
      expression = lookup(rules.value, "expression")

      action      = lookup(rules.value, "action", null)
      description = lookup(rules.value, "description", null)
      enabled     = lookup(rules.value, "enabled", null)
      ref         = lookup(rules.value, "ref", null)

      # List of parameters that configure the behavior of the ruleset rule action.
      dynamic "action_parameters" {
        for_each = rules.value.action_parameters != null ? [rules.value.action_parameters] : []

        content {
          additional_cacheable_ports = lookup(action_parameters.value, "additional_cacheable_ports", null)
          automatic_https_rewrites   = lookup(action_parameters.value, "automatic_https_rewrites", null)
          bic                        = lookup(action_parameters.value, "bic", null)
          cache                      = lookup(action_parameters.value, "cache", null)
          content                    = lookup(action_parameters.value, "content", null)
          content_type               = lookup(action_parameters.value, "content_type", null)
          cookie_fields               = lookup(action_parameters.value, "cookie_fields", null)
          disable_apps               = lookup(action_parameters.value, "disable_apps", null)
          disable_railgun            = lookup(action_parameters.value, "disable_railgun", null)
          disable_zaraz              = lookup(action_parameters.value, "disable_zaraz", null)
          email_obfuscation          = lookup(action_parameters.value, "email_obfuscation", null)
          hotlink_protection         = lookup(action_parameters.value, "hotlink_protection", null)
          id                         = lookup(action_parameters.value, "id", null)
          increment                  = lookup(action_parameters.value, "increment", null)
          mirage                     = lookup(action_parameters.value, "mirage", null)
          opportunistic_encryption   = lookup(action_parameters.value, "opportunistic_encryption", null)
          origin_cache_control       = lookup(action_parameters.value, "origin_cache_control", null)
          origin_error_page_passthru = lookup(action_parameters.value, "origin_error_page_passthru", null)
          phases                     = lookup(action_parameters.value, "phases", null)
          polish                     = lookup(action_parameters.value, "polish", null)
          products                   = lookup(action_parameters.value, "products", null)
          read_timeout               = lookup(action_parameters.value, "read_timeout", null)
          request_fields             = lookup(action_parameters.value, "request_fields", null)
          respect_strong_etags       = lookup(action_parameters.value, "respect_strong_etags", null)
          rocket_loader              = lookup(action_parameters.value, "rocket_loader", null)
          rules                      = lookup(action_parameters.value, "rules", null)
          ruleset                    = lookup(action_parameters.value, "ruleset", null)
          rulesets                   = lookup(action_parameters.value, "rulesets", null)
          security_level             = lookup(action_parameters.value, "security_level", null)
          server_side_excludes       = lookup(action_parameters.value, "server_side_excludes", null)
          ssl                        = lookup(action_parameters.value, "ssl", null)
          status_code                = lookup(action_parameters.value, "status_code", null)
          sxg                        = lookup(action_parameters.value, "sxg", null)
          version                    = lookup(action_parameters.value, "version", null)

          # Compression algorithms to use in order of preference.
          dynamic "algorithms" {
            for_each = action_parameters.value.algorithms != null ? [action_parameters.value.algorithms] : []

            content {
              name = algorithms.value.name
            }
          }

          # Indicate which file extensions to minify automatically.
          dynamic "autominify" {
            for_each = action_parameters.value.autominify != null ? [action_parameters.value.autominify] : []

            content {
              css  = lookup(autominify.value, "css", null)
              html = lookup(autominify.value, "html", null)
              js   = lookup(autominify.value, "js", null)
            }
          }

          # List of browser TTL parameters to apply to the request.
          dynamic "browser_ttl" {
            for_each = action_parameters.value.browser_ttl != null ? [action_parameters.value.browser_ttl] : []

            content {
              mode    = lookup(browser_ttl.value, "mode")
              default = lookup(browser_ttl.value, "default", null)
            }
          }

          # List of cache key parameters to apply to the request.
          dynamic "cache_key" {
            for_each = action_parameters.value.cache_key != null ? [action_parameters.value.cache_key] : []

            content {
              cache_by_device_type  = lookup(cache_key.value, "cache_by_device_type", null)
              cache_deception_armor = lookup(cache_key.value, "cache_deception_armor", null)

              dynamic "custom_key" {
                for_each = cache_key.value.custom_key != null ? [cache_key.value.custom_key] : []

                content {
                  dynamic "cookie" {
                    for_each = custom_key.value.cookie != null ? [custom_key.value.cookie] : []

                    content {
                      check_presence = lookup(cookie.value, "check_presence", null)
                      include        = lookup(cookie.value, "include", null)
                    }
                  }

                  dynamic "header" {
                    for_each = custom_key.value.header != null ? [custom_key.value.header] : []

                    content {
                      check_presence = lookup(header.value, "check_presence", null)
                      exclude_origin = lookup(header.value, "exclude_origin", null)
                      include        = lookup(header.value, "include", null)
                    }
                  }

                  dynamic "host" {
                    for_each = custom_key.value.header != null ? [custom_key.value.header] : []

                    content {
                      resolved = lookup(host.value, "resolved", null)
                    }
                  }

                  dynamic "query_string" {
                    for_each = custom_key.value.query_string != null ? [custom_key.value.query_string] : []

                    content {
                      exclude = lookup(query_string.value, "exclude", null)
                      include = lookup(query_string.value, "include", null)
                    }
                  }

                  dynamic "user" {
                    for_each = custom_key.value.user != null ? [custom_key.value.user] : []

                    content {
                      device_type = lookup(user.value, "device_type", null)
                      geo         = lookup(user.value, "geo", null)
                      lang        = lookup(user.value, "lang", null)
                    }
                  }
                }
              }

              ignore_query_strings_order = lookup(cache_key.value, "ignore_query_strings_order", null)
            }
          }

          # List of edge TTL parameters to apply to the request.
          dynamic "edge_ttl" {
            for_each = action_parameters.value.edge_ttl != null ? [action_parameters.value.edge_ttl] : []

            content {
              mode    = lookup(edge_ttl.value, "mode")
              default = lookup(edge_ttl.value, "default", null)

              dynamic "status_code_ttl" {
                for_each = edge_ttl.value.status_code_ttl != null ? [edge_ttl.value.status_code_ttl] : []

                content {
                  status_code = lookup(status_code_ttl.value, "status_code", null)
                  value       = lookup(status_code_ttl.value, "value", null)

                  dynamic "status_code_range" {
                    for_each = edge_ttl.value.status_code_range != null ? [edge_ttl.value.status_code_range] : []

                    content {
                      from = lookup(status_code_range.value, "from", null)
                      to   = lookup(status_code_range.value, "to", null)
                    }
                  }
                }
              }
            }
          }

          # Use a list to lookup information for the action.
          dynamic "from_list" {
            for_each = action_parameters.value.from_list != null ? [action_parameters.value.from_list] : []

            content {
              key  = lookup(from_list.value, "key", null)
              name = lookup(from_list.value, "name", null)
            }

          }

          # Use a value to lookup information for the action
          dynamic "from_value" {
            for_each = action_parameters.value.from_value != null ? [action_parameters.value.from_value] : []

            content {
              status_code           = lookup(from_value.value, "status_code", null)
              preserve_query_string = lookup(from_value.value, "preserve_query_string", null)

              dynamic "target_url" {
                for_each = from_value.value.target_url != null ? [from_value.value.target_url] : []

                content {
                  expression = lookup(target_url.value, "expression", null)
                  value      = lookup(target_url.value, "value", null)
                }
              }
            }
          }

          # List of HTTP header modifications to perform in the ruleset rule. Headers are order dependent and must be provided sorted alphabetically ascending based on the name value
          dynamic "headers" {
            for_each = action_parameters.value.headers != null ? [action_parameters.value.headers] : []

            content {
              expression = lookup(headers.value, "expression", null)
              name       = lookup(headers.value, "name", null)
              operation  = lookup(headers.value, "operation", null)
              value      = lookup(headers.value, "value", null)
            }
          }

          # List of properties to configure WAF payload logging.
          dynamic "matched_data" {
            for_each = action_parameters.value.matched_data != null ? [action_parameters.value.matched_data] : []

            content {
              public_key = lookup(matched_data.value, "public_key", null)
            }
          }

          # List of properties to change request origin.
          dynamic "origin" {
            for_each = action_parameters.value.origin != null ? [action_parameters.value.origin] : []

            content {
              host = lookup(origin.value, "host", null)
              port = lookup(origin.value, "port", null)
            }
          }

          # List of override configurations to apply to the ruleset.
          dynamic "overrides" {
            for_each = action_parameters.value.overrides != null ? [action_parameters.value.overrides] : []

            content {
              action = lookup(overrides.value, "action", null)

              dynamic "categories" {
                for_each = overrides.value.categories != null ? [overrides.value.categories] : []

                content {
                  action   = lookup(categories.value, "action", null)
                  category = lookup(categories.value, "category", null)
                  enabled  = lookup(categories.value, "enabled", null)
                }
              }

              dynamic "rules" {
                for_each = overrides.value.rules != null ? [overrides.value.rules] : []

                content {
                  action            = lookup(rules.value, "action", null)
                  enabled           = lookup(rules.value, "enabled", null)
                  id                = lookup(rules.value, "id", null)
                  score_threshold   = lookup(rules.value, "score_threshold", null)
                  sensitivity_level = lookup(rules.value, "sensitivity_level", null)
                }
              }
            }
          }

          # List of parameters that configure the response given to end users.
          dynamic "response" {
            for_each = action_parameters.value.response != null ? [action_parameters.value.response] : []

            content {
              content      = lookup(response.value, "content", null)
              content_type = lookup(response.value, "content_type", null)
              status_code  = lookup(response.value, "status_code", null)
            }
          }

          # List of serve stale parameters to apply to the request.
          dynamic "serve_stale" {
            for_each = action_parameters.value.serve_stale != null ? [action_parameters.value.serve_stale] : []

            content {
              disable_stale_while_updating = lookup(serve_stale.value, "disable_stale_while_updating", null)
            }
          }

          # List of properties to manange Server Name Indication.
          dynamic "sni" {
            for_each = action_parameters.value.sni != null ? [action_parameters.value.sni] : []

            content {
              value = lookup(sni.value, "value", null)
            }
          }

          # List of URI properties to configure for the ruleset rule when performing URL rewrite transformations.
          dynamic "uri" {
            for_each = action_parameters.value.uri != null ? [action_parameters.value.uri] : []

            content {
              origin = lookup(uri.value, "origin", null)

              dynamic "path" {
                for_each = uri.value.path != null ? [uri.value.path] : []

                content {
                  expression = lookup(path.value, "expression", null)
                  value      = lookup(path.value, "value", null)
                }
              }
              dynamic "query" {
                for_each = uri.value.query != null ? [uri.value.query] : []

                content {
                  expression = lookup(path.value, "expression", null)
                  value      = lookup(path.value, "value", null)
                }

              }
            }
          }
        }
      }

      # The ability to write custom rules for a zone that check for exposed credentials according to your criteria for specific applications.
      dynamic "exposed_credential_check" {
        for_each = rules.value.logging != null ? [rules.value.logging] : []

        content {
          password_expression = lookup(exposed_credential_check.value, "password_expression", null)
          username_expression = lookup(exposed_credential_check.value, "username_expression", null)
        }
      }

      # List parameters to configure how the rule generates logs. Not applied to all the actions.
      dynamic "logging" {
        for_each = rules.value.logging != null ? [rules.value.logging] : []

        content {
          enabled = lookup(logging.value, "enabled", null)
        }
      }

      # Rate limiting rules allow you to define rate limits for requests matching an expression, and the action to perform when those rate limits are reached.
      dynamic "ratelimit" {
        for_each = rules.value.ratelimit != null ? [rules.value.ratelimit] : []

        content {
          characteristics            = lookup(ratelimit.value, "characteristics", null)
          counting_expression        = lookup(ratelimit.value, "counting_expression", null)
          mitigation_timeout         = lookup(ratelimit.value, "mitigation_timeout", null)
          period                     = lookup(ratelimit.value, "period", null)
          requests_per_period        = lookup(ratelimit.value, "requests_per_period", null)
          requests_to_origin         = lookup(ratelimit.value, "requests_to_origin", null)
          score_per_period           = lookup(ratelimit.value, "score_per_period", null)
          score_response_header_name = lookup(ratelimit.value, "score_response_header_name", null)
        }
      }
    }
  }
}
