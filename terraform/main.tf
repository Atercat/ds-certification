variable "key_name" {
    type = string
}

module "builder" {
    source = "./modules/vk"
    name = "builder"
    key_pair = var.key_name
}

module "runner" {
    source = "./modules/vk"
    name = "runner"
    key_pair = var.key_name
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}