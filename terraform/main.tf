module "vm" {
    source = "./modules/vk"
    name = "builder"
    key_pair = "wsl-work"
}
output "ip" {
    value = module.vm.ip
}