module "builder" {
    source = "../modules/vk"
    name = "builder"
    key_name = var.KEY_NAME
}

module "runner" {
    source = "../modules/vk"
    name = "runner"
    key_name = var.KEY_NAME
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}