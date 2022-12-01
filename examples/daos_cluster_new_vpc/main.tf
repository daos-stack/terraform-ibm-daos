/**
 * Copyright 2022 Intel Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

module "vpc" {
  source                     = "../../modules/vpc"
  region                     = var.region
  resource_prefix            = var.resource_prefix
  bastion_sg_ssh_allowed_ips = var.vpc_bastion_sg_ssh_allowed_ips
}

module "daos_server" {
  depends_on           = [module.vpc]
  source               = "../../modules/daos_server"
  region               = var.region
  zone                 = var.zone
  resource_group_name  = var.resource_group_name
  instance_base_name   = var.server_instance_base_name
  instance_count       = var.server_instance_count
  ssh_key_names        = var.ssh_key_names
  vpc_name             = module.vpc.name
  subnet_name          = element(module.vpc.subnet_names, length(module.vpc.subnet_names) - 1)
  security_group_names = [module.vpc.instance_sg_name]
}

module "daos_client" {
  depends_on           = [module.vpc]
  source               = "../../modules/daos_client"
  region               = var.region
  zone                 = var.zone
  resource_group_name  = var.resource_group_name
  instance_base_name   = var.client_instance_base_name
  instance_count       = var.client_instance_count
  ssh_key_names        = var.ssh_key_names
  vpc_name             = module.vpc.name
  subnet_name          = element(module.vpc.subnet_names, length(module.vpc.subnet_names) - 1)
  security_group_names = [module.vpc.instance_sg_name]
}

module "daos_admin" {
  depends_on           = [module.vpc]
  source               = "../../modules/daos_admin"
  region               = var.region
  zone                 = var.zone
  resource_group_name  = var.resource_group_name
  instance_base_name   = var.admin_instance_base_name
  instance_count       = var.admin_instance_count
  ssh_key_names        = var.ssh_key_names
  vpc_name             = module.vpc.name
  subnet_name          = element(module.vpc.subnet_names, length(module.vpc.subnet_names) - 1)
  security_group_names = [module.vpc.bastion_sg_name]
  daos_server_names    = module.daos_server.daos_server_names
  daos_access_points   = module.daos_server.daos_access_points_ips_bm
  daos_client_names    = module.daos_client.daos_client_names
}
