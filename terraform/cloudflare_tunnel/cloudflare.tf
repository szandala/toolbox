resource "random_id" "tunnel_secret" {
    byte_length = 32
    keepers = {
        # Generate a new id each time we change any entries here
        tunnel_name = var.hostname
        salt = "init"
    }
}

resource "cloudflare_tunnel" "server" {
    account_id = var.cf_account_id
    name       = var.hostname
    secret     = random_id.tunnel_secret.b64_std
    config_src = "cloudflare"
}

resource "cloudflare_tunnel_config" "server" {
  account_id = var.cf_account_id
  tunnel_id  = cloudflare_tunnel.server.id

  config {
    # warp_routing {
    #   enabled = false
    # }
    # origin_request {
    #   connect_timeout = "1m0s"
    #   tcp_keep_alive  = "1m0s"
    # }
    ingress_rule {
      hostname = "${var.hostname}.${var.cf_tunnel_primary_domain}"
      path     = ""
      service  = "ssh://localhost:22"
    }
      ingress_rule {
      service = "http_status:404"
    }
  }
  depends_on = [ cloudflare_record.tunnel_dns, cloudflare_tunnel.server ]
}

data "cloudflare_zone" "tunnel" {
  account_id = var.cf_account_id
  name = var.cf_tunnel_primary_domain
}

resource "cloudflare_record" "tunnel_dns" {
  zone_id = data.cloudflare_zone.tunnel.id
  name    = var.hostname
  value   = "${cloudflare_tunnel.server.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
