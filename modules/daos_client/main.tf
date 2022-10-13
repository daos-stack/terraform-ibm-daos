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

locals {
  ssh_key_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]

  user_data_script = templatefile("${path.module}/templates/user_data.sh.tftpl",
    {
      playbooks = var.user_data_ansible_playbooks
    }
  )

  # first_client  = format("%s-%04s", var.instance_base_name, 1)
  # clients       = var.instance_count == 1 ? local.first_client : format("%s-[%04s-%04s]", var.instance_base_name, 1, var.instance_count)
  # max_aps       = var.instance_count > 5 ? 5 : (var.instance_count % 2) == 1 ? var.instance_count : var.instance_count - 1
  # access_points = formatlist("%s-%04s", var.instance_base_name, range(1, local.max_aps + 1))

}

data "ibm_is_vpc" "daos_client_vpc" {
  name = var.vpc_name
}

data "ibm_is_subnet" "daos_client_sn" {
  name = var.subnet_name
}

data "ibm_is_image" "client_os_image" {
  name = var.os_image_name
}

data "ibm_resource_group" "daos_rg" {
  name = var.resource_group_name
}

data "ibm_is_ssh_key" "ssh_keys" {
  for_each = toset(var.ssh_key_names)
  name     = each.value
}

# This template format can be used with instance groups
resource "ibm_is_instance_template" "daos_client_it" {
  name    = "${var.instance_base_name}-it"
  image   = data.ibm_is_image.client_os_image.id
  profile = var.instance_profile_name

  primary_network_interface {
    name   = "eth0"
    subnet = data.ibm_is_subnet.daos_client_sn.id
    #security_groups = var.security_groups
  }

  vpc  = data.ibm_is_vpc.daos_client_vpc.id
  zone = var.zone
  keys = [for ssh_key in local.ssh_key_ids : ssh_key.id]

  metadata_service_enabled = true
  user_data                = local.user_data_script

}

#-------------------------------------------------------------------------------
# Single instance resource with a count
#-------------------------------------------------------------------------------
resource "ibm_is_instance" "daos_client" {
  count             = var.instance_count
  name              = format("%s-%04s", var.instance_base_name, "${count.index + 1}")
  instance_template = ibm_is_instance_template.daos_client_it.id
}
