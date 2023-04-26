resource "google_compute_instance" "default" {
  name         = var.hostname
  machine_type = "e2-medium"
  zone         = "us-central1-a"


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata_startup_script = templatefile(
    "${path.module}/startup.tftpl",
    {
      cf_tunnel_token = var.cf_tunnel_token
    }
  )
}
