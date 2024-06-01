module "zone_level_complete_ruleset_engine" {
  source   = "../.." # Update the path to your module
  for_each =  var.rules_config

  zone_name    = var.zone_name
  ruleset_name = var.ruleset_name
  description  = var.description
  kind         = var.kind
  phase        = each.value.phase
  rules        = each.value.rules
}
