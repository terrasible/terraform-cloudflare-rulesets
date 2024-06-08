output "rules" {
  description = "cloudflare ruleset engine rules"
  value       = cloudflare_ruleset.this.rules
}
