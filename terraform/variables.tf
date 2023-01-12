variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type    = string
  default = "trazler"
}

variable "release_name" {
    type = string
}

variable "docker_tag" {
    type = string
}