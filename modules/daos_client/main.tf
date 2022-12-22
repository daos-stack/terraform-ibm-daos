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

locals {
  base_name    = try("${var.resource_prefix}-${var.instance_base_name}", "${var.instance_base_name}")
  first_client = format("%s-%03s", local.base_name, 1)
  clients      = var.instance_count == 1 ? local.first_client : format("%s-[%03s-%03s]", local.base_name, 1, var.instance_count)

  ssh_key_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]

  security_group_ids = [
    for sg in data.ibm_is_security_group.client : {
      id = sg.id
    }
  ]

  user_data = templatefile("${path.module}/templates/user_data.tftpl", {
    ansible_public_key    = var.ansible_public_key
    daos_admin_public_key = var.daos_admin_public_key
  })
}

resource "ibm_is_instance_template" "daos_client" {
  name    = "${local.base_name}-it"
  image   = data.ibm_is_image.daos_client_os_image.id
  keys    = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  profile = var.instance_profile_name
  vpc     = data.ibm_is_vpc.daos_client.id
  zone    = var.zone

  resource_group = data.ibm_resource_group.daos.id

  metadata_service_enabled = true

  user_data = local.user_data

  primary_network_interface {
    name            = "eth0"
    subnet          = data.ibm_is_subnet.daos_client.id
    security_groups = [for sg in data.ibm_is_security_group.client : sg.id]
  }
}

resource "ibm_is_instance" "daos_client" {
  count = var.instance_count
  name  = format("%s-%03s", local.base_name, "${count.index + 1}")

  instance_template = ibm_is_instance_template.daos_client.id

  boot_volume {
    name = format("%s-%03s-bv", local.base_name, "${count.index + 1}")
  }
}
