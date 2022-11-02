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

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

# TODO: Need to call daos_common module here to create a COS bucket that
#       will be used for shared files between the DAOS server, client and
#       admin instances. Also need to use Secrets Manager to store the
#       certificates for secure transport.


module "daos_server" {
  source               = "../../modules/daos_server"
  ibmcloud_api_key     = var.ibmcloud_api_key
  instance_base_name   = var.server_instance_base_name
  instance_count       = var.server_instance_count
  ssh_key_names        = var.ssh_key_names
  subnet_name          = var.subnet_name
  vpc_name             = var.vpc_name
  enable_bare_metal    = var.server_enable_bare_metal
  security_group_names = var.server_security_group_names

  instance_bare_metal_profile_name = var.server_instance_bare_metal_profile_name

  # TODO: Remove these overrides when
  #       https://github.com/daos-stack/ansible-collection-daos.git,main
  #       is available. Removing these fall back to the default variable values
  #       in the daos_server module.
  ansible_install_script_url = var.ansible_install_script_url
  ansible_playbooks          = var.ansible_playbooks
}

module "daos_client" {
  source                = "../../modules/daos_client"
  ibmcloud_api_key      = var.ibmcloud_api_key
  instance_base_name    = var.client_instance_base_name
  instance_count        = var.client_instance_count
  instance_profile_name = var.client_instance_profile_name
  ssh_key_names         = var.ssh_key_names
  subnet_name           = var.subnet_name
  vpc_name              = var.vpc_name
  security_group_names  = var.client_security_group_names
  daos_access_points    = module.daos_server.daos_access_point_ips

  # TODO: Remove these overrides when
  #       https://github.com/daos-stack/ansible-collection-daos.git,main
  #       is available. Removing these fall back to the default variable values
  #       in the daos_client module.
  ansible_install_script_url = var.ansible_install_script_url
  ansible_playbooks          = var.ansible_playbooks
}

module "daos_admin" {
  source               = "../../modules/daos_admin"
  ibmcloud_api_key     = var.ibmcloud_api_key
  instance_base_name   = var.admin_instance_base_name
  ssh_key_names        = var.ssh_key_names
  subnet_name          = var.subnet_name
  vpc_name             = var.vpc_name
  security_group_names = var.admin_security_group_names
  daos_access_points   = module.daos_server.daos_access_point_ips
  daos_client_names    = module.daos_client.daos_client_names
  daos_server_names    = module.daos_server.daos_server_names

  # TODO: Remove these overrides when
  #       https://github.com/daos-stack/ansible-collection-daos.git,main
  #       is available. Removing these fall back to the default variable values
  #       in the daos_admin module.
  ansible_install_script_url = var.ansible_install_script_url
  ansible_playbooks          = var.ansible_playbooks
}
