terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.16.0"
    }

    random = {
      source = "hashicorp/random"
      version = "3.0.1"
    }
  }
}

#mymap = {
#  description = "Henrys weird TF"
#  default = {
#    Monday = {
#      HENRY_FAVORITE_PASTA = "macaroni"
#      HENRY_FAVORITE_CURRY = "vindaloo"
#    }
#    Tuesday = {
#      HENRY_FAVORITE_CURRY = "masala"
#    }
#    Wednesday = {
#      HENRY_FAVORITE_SOUP = "tomato"
#    }
#  }
#}
#
#
#mynewmap = {
#  HENRY_FAVORITE_PASTA = {
#    Monday    = "macaroni"
#    Tuesday   = null
#    Wednesday = null
#  }
#  HENRY_FAVORITE_CURRY = {
#    Monday    = "vindaloo"
#    Tuesday   = "masala"
#    Wednesday = null
#  }
#  HENRY_FAVORITE_SOUP = {
#    Monday    = null
#    Tuesday   = null
#    Wednesday = "tomato"
#  }
#}
