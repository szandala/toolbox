variable "hostname" {
  description = "Desired hostname: HOSTNAME.cf_tunnel_primary_domain"
}

# template vars for provisioning CF Tunnel
# Setting defaults so that this can be built before a tunnel is created; re-run TF after supplying
#   real tunnel configs to rebuild runner
variable "cf_account_id" {
  description = "Account Tag"
  type = string
}
variable "cf_tunnel_primary_domain" {
  description = "Tunnel domain added here"
  type = string
}
