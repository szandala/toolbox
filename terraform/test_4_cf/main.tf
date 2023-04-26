module "tunnel" {
  source = "../cloudflare_tunnel"

  hostname = var.hostname
  cf_account_id = var.cf_account_id
  cf_tunnel_primary_domain = var.cf_tunnel_primary_domain
}

module "vm" {
  source = "../vm"

  cf_tunnel_token = module.tunnel.cf_tunnel_token
  hostname = var.hostname
}
