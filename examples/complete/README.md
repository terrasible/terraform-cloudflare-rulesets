# examples

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_zone_level_complete_ruleset_engine"></a> [zone\_level\_complete\_ruleset\_engine](#module\_zone\_level\_complete\_ruleset\_engine) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | The description of the managed WAF ruleset. | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | The kind of the ruleset. | `string` | n/a | yes |
| <a name="input_rules_config"></a> [rules\_config](#input\_rules\_config) | A list of rules for the WAF. | `map(any)` | n/a | yes |
| <a name="input_ruleset_name"></a> [ruleset\_name](#input\_ruleset\_name) | The name of the managed WAF ruleset. | `string` | n/a | yes |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The zone name. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
