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

module "daos_admin" {
  source             = "../../modules/daos_admin"
  ibmcloud_api_key   = var.ibmcloud_api_key
  instance_base_name = var.admin_instance_base_name
  security_groups    = var.security_groups
  ssh_key_names      = var.ssh_key_names
  subnet_name        = var.subnet_name
  vpc_name           = var.vpc_name
}

module "daos_server" {
  source                = "../../modules/daos_server"
  ibmcloud_api_key      = var.ibmcloud_api_key
  instance_base_name    = var.server_instance_base_name
  instance_count        = var.server_instance_count
  instance_profile_name = var.server_instance_profile_name
  ssh_key_names         = var.ssh_key_names
  subnet_name           = var.subnet_name
  vpc_name              = var.vpc_name
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
}
