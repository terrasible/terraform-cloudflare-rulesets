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
      expression = rules.value.expression

      action      = rules.value.action
      description = rules.value.description
      enabled     = rules.value.enabled
      ref         = rules.value.ref

      # List of parameters that configure the behavior of the ruleset rule action.
      dynamic "action_parameters" {
        for_each = rules.value.action_parameters[*]

        content {
          additional_cacheable_ports = action_parameters.value.additional_cacheable_ports
          automatic_https_rewrites   = action_parameters.value.automatic_https_rewrites
          bic                        = action_parameters.value.bic
          cache                      = action_parameters.value.cache
          content                    = action_parameters.value.content
          content_type               = action_parameters.value.content_type
          cookie_fields              = action_parameters.value.cookie_fields
          disable_apps               = action_parameters.value.disable_apps
          disable_railgun            = action_parameters.value.disable_railgun
          disable_zaraz              = action_parameters.value.disable_zaraz
          email_obfuscation          = action_parameters.value.email_obfuscation
          hotlink_protection         = action_parameters.value.hotlink_protection
          id                         = action_parameters.value.id
          increment                  = action_parameters.value.increment
          mirage                     = action_parameters.value.mirage
          opportunistic_encryption   = action_parameters.value.opportunistic_encryption
          origin_cache_control       = action_parameters.value.origin_cache_control
          origin_error_page_passthru = action_parameters.value.origin_error_page_passthru
          phases                     = action_parameters.value.phases
          polish                     = action_parameters.value.polish
          products                   = action_parameters.value.products
          read_timeout               = action_parameters.value.read_timeout
          request_fields             = action_parameters.value.request_fields
          respect_strong_etags       = action_parameters.value.respect_strong_etags
          rocket_loader              = action_parameters.value.rocket_loader
          rules                      = action_parameters.value.rules
          ruleset                    = action_parameters.value.ruleset
          rulesets                   = action_parameters.value.rulesets
          security_level             = action_parameters.value.security_level
          server_side_excludes       = action_parameters.value.server_side_excludes
          ssl                        = action_parameters.value.ssl
          status_code                = action_parameters.value.status_code
          sxg                        = action_parameters.value.sxg
          version                    = action_parameters.value.version

          # Compression algorithms to use in order of preference.
          dynamic "algorithms" {
            for_each = rules.value.action_parameters.algorithms[*]

            content {
              name = algorithms.value.name
            }
          }

          # Indicate which file extensions to minify automatically.
          dynamic "autominify" {
            for_each = rules.value.action_parameters.autominify[*]

            content {
              css  = autominify.value.css
              html = autominify.value.html
              js   = autominify.value.js
            }
          }

          # List of browser TTL parameters to apply to the request.
          dynamic "browser_ttl" {
            for_each = rules.value.action_parameters.browser_ttl[*]

            content {
              mode    = browser_ttl.value.mode
              default = browser_ttl.value.default
            }
          }

          # List of cache key parameters to apply to the request.
          dynamic "cache_key" {
            for_each = rules.value.action_parameters.cache_key[*]

            content {
              cache_by_device_type  = cache_key.value.cache_by_device_type
              cache_deception_armor = cache_key.value.cache_deception_armor

              dynamic "custom_key" {
                for_each = rules.value.action_parameters.custom_key[*]

                content {
                  dynamic "cookie" {
                    for_each = rules.value.action_parameters.cookie[*]

                    content {
                      check_presence = cookie.value.check_presence
                      include        = cookie.value.include
                    }
                  }

                  dynamic "header" {
                    for_each = rules.value.action_parameters.header[*]

                    content {
                      check_presence = header.value.check_presence
                      exclude_origin = header.value.exclude_origin
                      include        = header.value.include
                    }
                  }

                  dynamic "host" {
                    for_each = rules.value.action_parameters.host[*]

                    content {
                      resolved = host.value.resolved
                    }
                  }

                  dynamic "query_string" {
                    for_each = custom_key.value.query_string[*]

                    content {
                      exclude = query_string.value.exclude
                      include = query_string.value.include
                    }
                  }

                  dynamic "user" {
                    for_each = custom_key.value.user[*]

                    content {
                      device_type = user.value.device_type
                      geo         = user.value.geo
                      lang        = user.value.lang
                    }
                  }
                }
              }

              ignore_query_strings_order = cache_key.value.ignore_query_strings_order
            }
          }

          # List of edge TTL parameters to apply to the request.
          dynamic "edge_ttl" {
            for_each = rules.value.action_parameters.edge_ttl[*]

            content {
              mode    = edge_ttl.value.mode
              default = edge_ttl.value.default

              dynamic "status_code_ttl" {
                for_each = edge_ttl.value.status_code_ttl[*]

                content {
                  status_code = status_code_ttl.value.status_code
                  value       = status_code_ttl.value.value

                  dynamic "status_code_range" {
                    for_each = status_code_ttl.value.status_code_range[*]

                    content {
                      from = status_code_range.value.from
                      to   = status_code_range.value.to
                    }
                  }
                }
              }
            }
          }

          # Use a list to lookup information for the action.
          dynamic "from_list" {
            for_each = rules.value.action_parameters.from_list[*]

            content {
              key  = from_list.value.value
              name = from_list.value.name
            }
          }

          # Use a value to lookup information for the action
          dynamic "from_value" {
            for_each = rules.value.action_parameters.from_value[*]

            content {
              status_code           = from_value.value.status_code
              preserve_query_string = from_value.value.preserve_query_string

              dynamic "target_url" {
                for_each = from_value.value.target_url.value

                content {
                  expression = target_url.value.expression
                  value      = target_url.value.value
                }
              }
            }
          }

          # List of HTTP header modifications to perform in the ruleset rule. Headers are order dependent and must be provided sorted alphabetically ascending based on the name value
          dynamic "headers" {
            for_each = rules.value.action_parameters.headers

            content {
              expression = headers.value.expression
              name       = headers.value.name
              operation  = headers.value.operation
              value      = headers.value.value
            }
          }

          # List of properties to configure WAF payload logging.
          dynamic "matched_data" {
            for_each = rules.value.action_parameters.matched_data

            content {
              public_key = matched_data.value.public_key
            }
          }

          # List of properties to change request origin.
          dynamic "origin" {
            for_each = rules.value.action_parameters.origin[*]

            content {
              host = origin.value.host
              port = origin.value.port
            }
          }

          # List of override configurations to apply to the ruleset.
          dynamic "overrides" {
            for_each = rules.value.action_parameters.overrides[*]

            content {
              action = overrides.value.action

              dynamic "categories" {
                for_each = overrides.value.categories

                content {
                  action   = categories.value.action
                  category = categories.value.category
                  enabled  = categories.value.enabled
                }
              }

              dynamic "rules" {
                for_each = overrides.value.rules
                iterator = overrides_rule

                content {
                  action            = overrides_rule.value.action
                  enabled           = overrides_rule.value.enabled
                  id                = overrides_rule.value.id
                  score_threshold   = overrides_rule.value.score_threshold
                  sensitivity_level = overrides_rule.value.sensitivity_level
                }
              }
            }
          }

          # List of parameters that configure the response given to end users.
          dynamic "response" {
            for_each = rules.value.action_parameters.response[*]
            iterator = response

            content {
              content      = response.value.content
              content_type = response.value.content_type
              status_code  = response.value.status_code
            }
          }

          # List of serve stale parameters to apply to the request.
          dynamic "serve_stale" {
            for_each = rules.value.action_parameters.serve_stale[*]

            content {
              disable_stale_while_updating = serve_stale.value.disable_stale_while_updating
            }
          }

          # List of properties to manange Server Name Indication.
          dynamic "sni" {
            for_each = rules.value.action_parameters.sni[*]

            content {
              value = sni.value.value
            }
          }

          # List of URI properties to configure for the ruleset rule when performing URL rewrite transformations.
          dynamic "uri" {
            for_each = rules.value.action_parameters.uri[*]

            content {
              origin = uri.value.origin

              dynamic "path" {
                for_each = uri.value.path[*]

                content {
                  expression = path.value.expression
                  value      = path.value.value
                }
              }

              dynamic "query" {
                for_each = uri.value.query[*]

                content {
                  expression = query.value.expression
                  value      = query.value.value
                }
              }
            }
          }
        }
      }

      # The ability to write custom rules for a zone that check for exposed credentials according to your criteria for specific applications.
      dynamic "exposed_credential_check" {
        for_each = rules.value.exposed_credential_check[*]

        content {
          password_expression = exposed_credential_check.value.password_expression
          username_expression = exposed_credential_check.value.username_expression
        }
      }

      # List parameters to configure how the rule generates logs. Not applied to all the actions.
      dynamic "logging" {
        for_each = rules.value.logging[*]

        content {
          enabled = logging.value.enabled
        }
      }

      # Rate limiting rules allow you to define rate limits for requests matching an expression, and the action to perform when those rate limits are reached.
      dynamic "ratelimit" {
        for_each = rules.value.ratelimit[*]

        content {
          characteristics            = ratelimit.value.characteristics
          counting_expression        = ratelimit.value.counting_expression
          mitigation_timeout         = ratelimit.value.mitigation_timeout
          period                     = ratelimit.value.period
          requests_per_period        = ratelimit.value.requests_per_period
          requests_to_origin         = ratelimit.value.requests_to_origin
          score_per_period           = ratelimit.value.score_per_period
          score_response_header_name = ratelimit.value.score_response_header_name
        }
      }
    }
  }
}
