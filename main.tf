provider "docker" {
  version = "~> 2.7"
  host    = "npipe:////.//pipe//docker_engine"
}

provider "random" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "hello-terraform"
  ports {
    internal = 80
    external = 8000
  }
}

resource "random_pet" "dog" {
  length = 2
}

module "nginx-pet" {
  source = "./nginx"

  container_name = "hello-${random_pet.dog.id}"
  nginx_port     = 8001
}

module "hello" {
  source  = "joatmon08/hello/random"
  version = "3.1.0"

  hello        = random_pet.dog.id
  second_hello = random_pet.dog.id

  secret_key = "secret"
}

variable "mymap" {
  description = "Henrys weird TF"
  default = {
    Monday = {
      HENRY_FAVORITE_PASTA = "macaroni"
      HENRY_FAVORITE_CURRY = "vindaloo"
    }
    Tuesday = {
      HENRY_FAVORITE_CURRY = "masala"
    }
    Wednesday = {
      HENRY_FAVORITE_SOUP = "tomato"
    }
  }
}

#variable "myfinalmap" {
#  description = "Henrys weird TF fixec"
#  default = local.mynewmap
#}


locals {
  days = flatten([
    for name, values in var.mymap : concat([
      name
    ], [])
  ])

  pasta = flatten([
    for name, values in var.mymap : [
      values
    ]
  ])

  pasta_days_map = {
    for name, values in var.mymap :
      name => values
  }

  distinct_henrys_faves = distinct(flatten([
    for name in local.pasta : [
      #    name[keys(name)[0]]
      keys(name)
    ]
  ]))

  distinct_henrys_faves_2 = {
    for name in local.distinct_henrys_faves :
      name => local.days
  }

  mynewmap = {
    for fave, days in local.distinct_henrys_faves_2 :
      fave => {
        for d in days :
         d => contains(keys(lookup(local.pasta_days_map, d, {})), fave) ? lookup(lookup(local.pasta_days_map, d, {}), fave, null) : null
      }
  }
}

#output "pasta" {
#  value = local.pasta
#}

#output "days" {
#  value = local.days
#}
#
#output "distinct_henrys_faves" {
#  value = local.distinct_henrys_faves
#}

#output "distinct_henrys_faves_2" {
#  value = local.distinct_henrys_faves_2
#}

output "mynewmap" {
  value = local.mynewmap
}

#output "pasta_days_map" {
#  value = local.pasta_days_map
#}

output "test_keys" {
  value = contains(keys(values(local.pasta_days_map)[0]), "HENRY_FAVORITE_CURRY")
}

output "test_key_map" {
#  value = values(local.pasta_days_map)["HENRY_FAVORITE_CURRY"]
  value = lookup(lookup(local.pasta_days_map, "Monday", {}), "HENRY_FAVORITE_CURRY", null)
}

output "test_key_map_2" {
#  value = values(local.pasta_days_map)["HENRY_FAVORITE_CURRY"]
  value = lookup(local.pasta_days_map, "Monday", {})
}

output "test_key_output" {
  value = keys(values(local.pasta_days_map)[0])[0]
}

output "test_value_output" {
  value = values(values(local.pasta_days_map)[0])[1]
}


#   value = contains(tolist(local.pasta_days_map[keys(local.pasta_days_map)[0]]), "HENRY_FAVORITE_CURRY")
