output "rules" {
  description = "Cloudflare rulset engine rules"
  value       = module.http_request_firewall_custom.rules
}
