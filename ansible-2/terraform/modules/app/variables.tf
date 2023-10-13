variable "public_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}

variable "private_key_path" {
  type        = string
  description = "Path to the public key used for ssh access"
}

variable "image_id" {
  type        = string
  description = "Disk image"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "mongo_ip" {
  type        = string
  description = "Mongo DB internal IP"
}
