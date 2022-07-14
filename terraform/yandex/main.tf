variable "KEY_PUB" {
    type = string
}

module "builder" {
    source = "../modules/yandex"
    name = "builder"
    pub_key = var.KEY_PUB
}

module "runner" {
    source = "../modules/yandex"
    name = "runner"
    pub_key = var.KEY_PUB
}

output "builder_ip" {
    value = module.builder.ip
}

output "runner_ip" {
    value = module.runner.ip
}