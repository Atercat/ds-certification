variable "provider" {
    type = string
}

variable "key_name" {
    type = string
}

variable "pub_key" {
    type = string
}

module "builder" {
    source = "./modules/${var.provider}"
    name = "builder"
    key_pair = var.key_name
}

module "runner" {
    source = "./modules/${var.provider}"
    name = "runner"
    key_pair = var.key_name
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}