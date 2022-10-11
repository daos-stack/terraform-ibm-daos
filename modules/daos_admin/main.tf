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

# main.tf for daos_admin module
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

  security_group_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]
}

data "ibm_is_vpc" "daos_admin_vpc" {
  name = var.vpc_name
}

data "ibm_is_subnet" "daos_admin_sn" {
  name = var.subnet_name
}

data "ibm_is_image" "admin_os_image" {
  name = var.os_image_name
}

data "ibm_resource_group" "daos_rg" {
  name = var.resource_group_name
}

data "ibm_is_ssh_key" "ssh_keys" {
  for_each = toset(var.ssh_key_names)
  name     = each.value
}

# All security groups in the VPC
data "ibm_is_security_groups" "vpc" {
  vpc_name = var.vpc_name
}

# This template format can be used with instance groups
resource "ibm_is_instance_template" "daos_admin_it" {
  name    = "${var.instance_base_name}-it"
  image   = data.ibm_is_image.admin_os_image.id
  profile = var.instance_profile_name

  primary_network_interface {
    name            = "eth0"
    subnet          = data.ibm_is_subnet.daos_admin_sn.id
    security_groups = [for sg in data.ibm_is_security_groups.vpc.security_groups : sg.id]
  }

  vpc  = data.ibm_is_vpc.daos_admin_vpc.id
  zone = var.zone
  keys = [for ssh_key in local.ssh_key_ids : ssh_key.id]

  metadata_service_enabled = true

}

resource "ibm_is_instance" "daos_admin" {
  name              = "${var.instance_base_name}-01"
  instance_template = ibm_is_instance_template.daos_admin_it.id
}

resource "ibm_is_floating_ip" "daos_admin_fip" {
  name   = "${var.instance_base_name}-floating-ip"
  target = ibm_is_instance.daos_admin.primary_network_interface[0].id
}
