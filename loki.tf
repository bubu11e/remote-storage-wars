module "loki" {
  source = "./modules/terraform-ovh-linux_host"

  count           = 1
  instance_name   = "loki"
  instance_image  = var.instance_image
  instance_flavor = "b2-7"
  ssh             = var.ssh
  userdata_path   = "userdata.yml"
  security_groups = ["ssh_security_group"]

  instance_metadata = {
    role = "loki"
  }

  private_network = openstack_networking_network_v2.private_network.name
  domain_name     = var.domain_name
}

output "loki" {
  value = var.domain_name != "" ? module.loki[*].domain_zone_record : module.loki[*].linuxhost
}
