variable "name" {
    type = string
    default = "instance"
}
variable "storage_size" {
    type = number
    default = 10
}
variable "image_id" {
    type = string
    default = "fd8qs44945ddtla09hnr" #Ubuntu-20.04
}
variable "key_pair" {
    type = string
}