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

variable "pub_key" {
    type = string
}