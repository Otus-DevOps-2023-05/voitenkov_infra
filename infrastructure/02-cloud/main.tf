module "infra-folder" {
    source             = "../modules/folder"
    folder_project     = "otus-devops"
    folder_environment = "infra"
}

module "microservices-folder" {
    source             = "../modules/folder"
    folder_project     = "otus-devops"
    folder_environment = "microservices"
}
