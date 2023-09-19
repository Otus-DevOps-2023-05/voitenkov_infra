locals {
  cidr_internet = "0.0.0.0/0" # All IPv4 addresses.
}

resource "yandex_vpc_network" "network-otus-devops-infra" {
  name                        = "network-${var.project}-${var.environment}"
}


resource "yandex_vpc_subnet" "subnet-otus-devops-infra-a1" {
  folder_id      =  var.folder_id
  name           = "subnet-${var.project}-${var.environment}-a1"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-otus-devops-infra.id

  depends_on = [
    yandex_vpc_network.network-otus-devops-infra,
  ]

}

resource "yandex_vpc_security_group" "sg-otus-devops-infra-instance-linux" {
  description = "Default security group for linux instances"
  name        = "sg-${var.project}-${var.environment}-instance-linux"
  network_id  = yandex_vpc_network.network-otus-devops-infra.id


  egress {
    description    = "Allow any outgoing traffic to the Internet"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = [local.cidr_internet]
  }
  ingress {
    description    = "Allow SSH connections to the instance"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [local.cidr_internet]
  }

  depends_on = [yandex_vpc_network.network-otus-devops-infra]
}

resource "yandex_vpc_security_group" "sg-otus-devops-infra-instance-openvpn" {
  description = "Security group for OpenVPN instances"
  name        = "sg-${var.project}-${var.environment}-instance-openvpn"
  network_id  = yandex_vpc_network.network-otus-devops-infra.id

  ingress {
    description    = "Allow HTTPS connections to the instance"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = [local.cidr_internet]
  }

  ingress {
    description    = "Allow VPN connections to the instance"
    protocol       = "UDP"
    port           = 18294
    v4_cidr_blocks = [local.cidr_internet]
  }

  depends_on = [yandex_vpc_network.network-otus-devops-infra]
}

resource "yandex_vpc_security_group" "sg-otus-devops-infra-instance-web" {
  description = "Default security group for web instances"
  name        = "sg-${var.project}-${var.environment}-instance-web"
  network_id  = yandex_vpc_network.network-otus-devops-infra.id

  ingress {
    description    = "Allow HTTPS connections to the instance"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = [local.cidr_internet]
  }

  depends_on = [yandex_vpc_network.network-otus-devops-infra]
}

module "instance-sa" {
  source                      = "../modules/sa"
  sa_name                     = "sa-${var.project}-${var.environment}-instance"
  sa_description              = "Service account for compute instances in ${var.project} ${var.environment} environment"
  sa_folder_id                = var.folder_id
  sa_role                     = "viewer"
}

module "bastion-instance" {
  source                      = "../modules/instance"
  count                       = 1
  instance_no                 = count.index + 1
  instance_name               = "bastion"
  instance_project            = var.project
  instance_environment        = var.environment
  instance_service_account_name = module.instance-sa.name
  instance_preemptible        = true
  instance_core_fraction      = 20
  instance_memory             = 1
  instance_subnet_id          = yandex_vpc_subnet.subnet-otus-devops-infra-a1.id
  instance_nat                = true
  instance_security_group_ids = [
    yandex_vpc_security_group.sg-otus-devops-infra-instance-linux.id,
    yandex_vpc_security_group.sg-otus-devops-infra-instance-openvpn.id,
  ]
  instance_user_data_file     = "ubuntu-default"
  instance_serial_port_enable = 1
  instance_image_id           = "fd81n0sfjm6d5nq6l05g" # ubuntu-20-04-lts-v20230904

  depends_on = [
    yandex_vpc_subnet.subnet-otus-devops-infra-a1,
    module.instance-sa,
    yandex_vpc_security_group.sg-otus-devops-infra-instance-linux,
    yandex_vpc_security_group.sg-otus-devops-infra-instance-openvpn,
  ]
}

module "someinternalhost-instance" {
  source                      = "../modules/instance"
  count                       = 1
  instance_no                 = count.index + 1
  instance_name               = "someinternalhost"
  instance_project            = var.project
  instance_environment        = var.environment
  instance_service_account_name = module.instance-sa.name
  instance_preemptible        = true
  instance_core_fraction      = 20
  instance_memory             = 1
  instance_subnet_id          = yandex_vpc_subnet.subnet-otus-devops-infra-a1.id
  instance_security_group_ids = [
    yandex_vpc_security_group.sg-otus-devops-infra-instance-linux.id
  ]
  instance_user_data_file     = "ubuntu-default"
  instance_serial_port_enable = 1
  instance_image_id           = "fd81n0sfjm6d5nq6l05g" # ubuntu-20-04-lts-v20230904

  depends_on = [
    yandex_vpc_subnet.subnet-otus-devops-infra-a1,
    module.instance-sa,
    yandex_vpc_security_group.sg-otus-devops-infra-instance-linux,
  ]
}

resource "yandex_cm_certificate" "cert-otus-devops-infra-bastion_voytenkov_ru" {
  name    = "cert-${var.project}-${var.environment}-bastion-voytenkov-ru"
  domains = ["bastion.voytenkov.ru"]

  managed {
    challenge_type  = "DNS_CNAME"
    challenge_count = 1
  }
}
