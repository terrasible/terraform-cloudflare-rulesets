variable "zone_name" {
  description = "The zone name."
  type        = string
}

variable "ruleset_name" {
  description = "The name of the managed WAF ruleset."
  type        = string
}

variable "description" {
  description = "The description of the managed WAF ruleset."
  type        = string
}

variable "kind" {
  description = "The kind of the ruleset."
  type        = string
}

#variable "phase" {
#  description = "The phase of the ruleset."
#  type        = string
#}

variable "rules_config" {
  description = "A list of rules for the WAF."
  type = map(object({
    phase = string
    rules = list(map(any))
  }))
}
