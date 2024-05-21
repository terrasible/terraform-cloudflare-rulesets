variable "account_name" {
  description = "Creating custom rulesets at the account level is a paid feature. Please ensure the feature is enabled. The 'kind' parameter must be set to 'custom', and for a phase entry point ruleset at the account level, set the value to 'root'."
  type        = string
  default     = null
}

variable "description" {
  description = "Brief summary of the ruleset and its intended use"
  type        = string
  default     = null
}

variable "kind" {
  description = "Cloudflare ruleset kinds include: custom (user-defined), entry point (serves as the entrypoint for phases - can be set to 'root' at the account level and 'zone' at the zone level), and managed (preconfigured by Cloudflare)."
  type        = string

  validation {
    condition     = can(regex("^(custom|managed|root|zone)$", var.kind))
    error_message = "Invalid kind value. Kind must be one of: custom, managed, root, zone."
  }
}

variable "phase" {
  description = "Phase refers to a stage in the process of handling a request/response lifecycle. Refer doc https://developers.cloudflare.com/ruleset-engine/reference/phases-list/"
  type        = string

  validation {
    condition     = can(regex("^(ddos_l4|ddos_l7|http_config_settings|http_custom_errors|http_log_custom_fields|http_ratelimit|http_request_cache_settings|http_request_dynamic_redirect|http_request_firewall_custom|http_request_firewall_managed|http_request_late_transform|http_request_origin|http_request_redirect|http_request_sanitize|http_request_sbfm|http_request_transform|http_response_compression|http_response_firewall_managed|http_response_headers_transform|magic_transit)$", var.phase))
    error_message = "Invalid phase value. Phase must be one of: ddos_l4, ddos_l7, http_config_settings, http_custom_errors, http_log_custom_fields, http_ratelimit, http_request_cache_settings, http_request_dynamic_redirect, http_request_firewall_custom, http_request_firewall_managed, http_request_late_transform, http_request_origin, http_request_redirect, http_request_sanitize, http_request_sbfm, http_request_transform, http_response_compression, http_response_firewall_managed, http_response_headers_transform, magic_transit."
  }
}

variable "rules" {
  description = "List of rules to apply to the ruleset"
  type = list(object({
    action      = optional(string)
    expression  = string
    description = optional(string)
    enabled     = optional(bool)
    ref         = optional(string)
    exposed_credential_check = optional(object({
      password_expression = optional(string)
      username_expression = optional(string)
    }))
    logging = optional(object({
      enabled = bool
    }))
    ratelimit = optional(object({
      characteristics            = string
      counting_expression        = string
      mitigation_timeout         = string
      period                     = string
      requests_per_period        = string
      requests_to_origin         = string
      score_per_period           = string
      score_response_header_name = string
    }))
    action_parameters = optional(object({
      additional_cacheable_ports = optional(list(number))
      automatic_https_rewrites   = optional(bool)
      bic                        = optional(bool)
      cache                      = optional(bool)
      content                    = optional(string)
      content_type               = optional(string)
      cookie_fields              = optional(list(string))
      disable_apps               = optional(bool)
      disable_railgun            = optional(bool)
      disable_zaraz              = optional(bool)
      host_header                = optional(string)
      hotlink_protection         = optional(bool)
      id                         = optional(string)
      increment                  = optional(number)
      mirage                     = optional(bool)
      opportunistic_encryption   = optional(bool)
      origin_cache_control       = optional(bool)
      origin_error_page_passthru = optional(bool)
      phases                     = optional(list(string))
      polish                     = optional(string)
      products                   = optional(list(string))
      read_timeout               = optional(number)
      request_fields             = optional(list(string))
      respect_strong_etags       = optional(bool)
      rocket_loader              = optional(bool)
      rules                      = optional(map(string))
      ruleset                    = optional(string)
      rulesets                   = optional(list(string))
      security_level             = optional(string)
      server_side_excludes       = optional(bool)
      ssl                        = optional(string)
      status_code                = optional(number)
      sxg                        = optional(bool)
      version                    = optional(string)
      algorithms = optional(object({
        name = optional(string)
      }))
      autominify = optional(object({
        css  = optional(bool)
        html = optional(bool)
        js   = optional(bool)
      }))
      browser_ttl = optional(object({
        mode    = string
        default = optional(string)
      }))
      cache_key = optional(object({
        cache_by_device_type  = optional(string)
        cache_deception_armor = optional(string)
        custom_key = optional(list(object({
          cookie = optional(list(object({
            check_presence = optional(list(string))
            include        = optional(list(string))
          })))
          header = optional(list(object({
            check_presence = optional(list(string))
            exclude_origin = optional(bool)
            include        = optional(list(string))
          })))
          host = optional(list(object({
            resolved = optional(bool)
          })))
          query_string = optional(list(object({
            exclude = optional(list(string))
            include = optional(list(string))
          })))
          user = optional(list(object({
            device_type = optional(bool)
            geo         = optional(bool)
            lang        = optional(bool)
          })))
        })))
        ignore_query_strings_order = optional(string)
      }))
      edge_ttl = optional(object({
        mode    = string
        default = optional(number)
        status_code_ttl = optional(object({
          status_code = optional(number)
          value       = optional(number)
          status_code_range = optional(object({
            from = optional(number)
            to   = optional(number)
          }))
        }))
      }))
      from_list = optional(object({
        key  = optional(string)
        name = optional(string)
      }))
      from_value = optional(object({
        status_code = optional(number)
        target_url = optional(object({
          value = optional(string)
        }))
        preserve_query_string = optional(bool)
      }))
      headers = optional(list(object({
        expression = optional(string)
        name       = optional(string)
        operation  = optional(string)
        value      = optional(string)
      })))
      matched_data = optional(object({
        public_key = optional(string)
      }))
      origin = optional(object({
        host = optional(string)
        port = optional(number)
      }))
      overrides = optional(object({
        action            = optional(string)
        sensitivity_level = optional(string)
        enabled           = optional(bool)
        categories = optional(object({
          action   = optional(string)
          category = optional(string)
          enabled  = optional(bool)
        }))
        rules = optional(object({
          action            = optional(string)
          enabled           = optional(bool)
          id                = optional(string)
          score_threshold   = optional(number)
          sensitivity_level = optional(string)
        }))
      }))
      response = optional(object({
        content      = optional(string)
        content_type = optional(string)
        status_code  = optional(number)
      }))
      serve_stale = optional(object({
        disable_stale_while_updating = optional(bool)
      }))
      sni = optional(object({
        value = optional(string)
      }))
      uri = optional(object({
        origin = optional(bool)
        path = optional(object({
          expression = optional(string)
          value      = optional(string)
        }))
        query = optional(object({
          expression = optional(string)
          value      = optional(string)
        }))
      }))
    }))
  }))
  default = []
}

variable "ruleset_name" {
  description = "The name of the Cloudflare ruleset"
  type        = string
}

variable "zone_name" {
  description = "The name of the Cloudflare zone. This is required if kind is set to zone. Only one of zone_name or account_name can be set."
  type        = string
}
