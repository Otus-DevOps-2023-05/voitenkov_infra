module "db" {
  source           = "../modules/db"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  image_id         = var.db_disk_image
  subnet_id        = yandex_vpc_subnet.app-subnet.id
}

module "app" {
  source           = "../modules/app"
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  image_id         = var.app_disk_image
  subnet_id        = yandex_vpc_subnet.app-subnet.id
  mongo_ip         = module.db.internal_ip_address_db
  depends_on       = [module.db]
}
