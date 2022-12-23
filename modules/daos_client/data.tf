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


data "ibm_is_vpc" "daos_client" {
  name = var.vpc_name
}

data "ibm_is_subnet" "daos_client" {
  name = var.subnet_name
}

data "ibm_is_image" "daos_client_os_image" {
  name = var.os_image_name
}

data "ibm_resource_group" "daos" {
  name = var.resource_group_name
}

data "ibm_is_ssh_key" "ssh_keys" {
  for_each = toset(var.ssh_key_names)
  name     = each.value
}

data "ibm_is_security_group" "client" {
  for_each = toset(var.security_group_names)
  name     = each.value
}

data "ibm_is_security_groups" "admin" {
  vpc_name = var.vpc_name
}
