module "builder" {
    source = "./provider"
    name = "builder"
    pub_key = var.PUB_KEY
}

module "runner" {
    source = "./provider"
    name = "runner"
    pub_key = var.PUB_KEY
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}