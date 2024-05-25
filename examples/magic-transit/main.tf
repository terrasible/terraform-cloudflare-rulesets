module "magic_transit" {
  source = "../.." # Update the path to your module

  # Pass required variables to the module
  account_name = "example"
  ruleset_name = "account magic transit"
  description  = "example magic transit ruleset description"
  kind         = "root"
  phase        = "magic_transit"

  rules = [
    {
      action      = "allow"
      expression  = "tcp.dstport in { 32768..65535 }"
      description = "Allow TCP Ephemeral Ports"
    }
  ]
}
