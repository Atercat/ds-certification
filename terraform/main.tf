module "builder" {
    source = "./modules/vk"
    name = "builder"
    key_pair = "wsl"
}

module "runner" {
    source = "./modules/vk"
    name = "runner"
    key_pair = "wsl"
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}