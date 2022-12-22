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
  source                  = "../../modules/vpc"
  region                  = var.region
  name                    = try("${var.resource_prefix}-${var.vpc_name}", "${var.vpc_name}")
  resource_group_name     = var.resource_group_name
  bastion_ssh_allowed_ips = var.bastion_ssh_allowed_ips
}

module "daos_common" {
  source              = "../../modules/daos_common"
  resource_group_name = var.resource_group_name
  resource_prefix     = var.resource_prefix
}

module "daos_server" {
  depends_on            = [module.daos_common]
  source                = "../../modules/daos_server"
  region                = var.region
  zone                  = var.zone
  resource_group_name   = var.resource_group_name
  resource_prefix       = var.resource_prefix
  instance_count        = var.server_instance_count
  use_bare_metal        = var.server_use_bare_metal
  ssh_key_names         = var.ssh_key_names
  vpc_name              = module.vpc.name
  subnet_name           = one([for item in module.vpc.subnet_names : item if can(regex(var.zone, item))])
  security_group_names  = [module.vpc.instance_security_group_name]
  ansible_public_key    = module.daos_common.ansible_public_key
  daos_admin_public_key = module.daos_common.daos_admin_public_key
}

module "daos_client" {
  depends_on            = [module.daos_common]
  source                = "../../modules/daos_client"
  region                = var.region
  zone                  = var.zone
  resource_group_name   = var.resource_group_name
  resource_prefix       = var.resource_prefix
  instance_count        = var.client_instance_count
  ssh_key_names         = var.ssh_key_names
  vpc_name              = module.vpc.name
  subnet_name           = one([for item in module.vpc.subnet_names : item if can(regex(var.zone, item))])
  security_group_names  = [module.vpc.instance_security_group_name]
  ansible_public_key    = module.daos_common.ansible_public_key
  daos_admin_public_key = module.daos_common.daos_admin_public_key
}

module "daos_admin" {
  depends_on = [
    module.daos_common,
    module.daos_server,
    module.daos_client
  ]
  source              = "../../modules/daos_admin"
  region              = var.region
  zone                = var.zone
  resource_group_name = var.resource_group_name
  resource_prefix     = var.resource_prefix

  vpc_name             = module.vpc.name
  subnet_name          = one([for item in module.vpc.subnet_names : item if can(regex(var.zone, item))])
  security_group_names = [module.vpc.bastion_security_group_name]

  ssh_key_names              = var.ssh_key_names
  bastion_public_key         = var.bastion_public_key
  ansible_private_key_pem    = module.daos_common.ansible_private_key_pem
  ansible_public_key         = module.daos_common.ansible_public_key
  daos_admin_private_key_pem = module.daos_common.daos_admin_private_key_pem
  daos_admin_public_key      = module.daos_common.daos_admin_public_key

  daos_client_instances = module.daos_client.daos_client_instances
  daos_server_instances = module.daos_server.daos_server_instances

  ansible_install_script_url = var.admin_ansible_install_script_url
  ansible_playbooks          = var.admin_ansible_playbooks
}
