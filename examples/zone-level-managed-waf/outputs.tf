output "rules" {
  description = "Cloudflare Zone DNS Records"
  value       = module.zone_level_managed_waf.rules
}
