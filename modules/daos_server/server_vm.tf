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

# This template format can be used with instance groups
resource "ibm_is_instance_template" "daos_server" {
  count = var.enable_bare_metal ? 0 : 1
  name  = "${var.instance_base_name}-it"

  image     = data.ibm_is_image.server_os_image.id
  keys      = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  profile   = var.instance_profile_name
  user_data = local.user_data_script
  vpc       = data.ibm_is_vpc.daos_server_vpc.id
  zone      = var.zone

  metadata_service_enabled = true

  primary_network_interface {
    name            = "eth0"
    subnet          = data.ibm_is_subnet.daos_server_sn.id
    security_groups = [for sg in data.ibm_is_security_group.server : sg.id]
  }
}

resource "ibm_is_instance" "daos_server" {
  count             = var.enable_bare_metal ? 0 : var.instance_count
  name              = format("%s-%04s", var.instance_base_name, "${count.index + 1}")
  instance_template = ibm_is_instance_template.daos_server[0].id

  boot_volume {
    name = format("%s-%03s-bv", var.instance_base_name, "${count.index + 1}")
  }
}
