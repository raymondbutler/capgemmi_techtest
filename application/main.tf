terraform {
  required_version = ">= 1.3.0, <= 1.3.5"
    required_providers {
      docker = {
        source = "kreuzwerker/docker"
#        source = "terraform-providers/docker"
        version = "2.23.1"
      }
    }
}

provider "docker" {}

resource "docker_image" "custom_nodejs_image" {
  name         = "notejam_nodejs:latest"
  keep_locally = true
  build {
    dockerfile = "Dockerfile"
    path       = "."
    remove     = true
    tag        = []
  }
}

resource "docker_container" "nodejs_notejam" {
  image                 = docker_image.custom_nodejs_image.name
  name                  = "notejam"
#  hostname              = "notejam"
  domainname            = "server.local"
  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true
  memory                = 256
  env                   = ["NAME=NOTEJAM", "PORT=80", "NODE_ENV=development"]
  command = ["node", "/app/webserver.js"]
#  command = ["node", "www"]
#  command               = ["/app/bin/www"]

  ports {
    internal = 80
    external = 8082
    ip       = "0.0.0.0"
  }
}
