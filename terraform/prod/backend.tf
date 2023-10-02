  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "s3-otus-devops-infra-tfstate"
    region                      = "ru-central1-a"
    key                         = "terraform/otus-devops-infra.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
