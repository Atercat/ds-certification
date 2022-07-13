module "builder" {
    source = "./modules/vk"
    name = "builder"
    key_pair = "wsl-work"
}

module "runner" {
    source = "./modules/vk"
    name = "runner"
    key_pair = "wsl-work"
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}