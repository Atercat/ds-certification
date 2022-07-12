variable "name" {
    type = string
    default = "instance"
}
variable "flavor_name" {
    type = string
    default = "Standard-2-2"
    description = "openstack flavor list"
}
variable "storage_size" {
    type = number
    default = 10
}
variable "image_id" {
    type = string
    default = "d853edd0-27b3-4385-a380-248ac8e40956" #Ubuntu-20.04.1-202008
    description = "openstack image list"
}
variable "key_pair" {
    type = string
    default = "wsl"
}