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

resource "ibm_is_bare_metal_server" "daos_server" {
  count = var.enable_bare_metal ? var.instance_count : 0
  name  = format("%s-%03s", var.instance_base_name, "${count.index + 1}")

  image     = var.bare_metal_image_id
  keys      = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  profile   = var.instance_bare_metal_profile_name
  user_data = local.user_data_script
  vpc       = data.ibm_is_vpc.daos_server_vpc.id
  zone      = var.zone

  primary_network_interface {
    name                      = "eth0"
    enable_infrastructure_nat = true
    subnet                    = data.ibm_is_subnet.daos_server_sn.id
    security_groups           = [for sg in data.ibm_is_security_group.server : sg.id]
  }

  timeouts {
    create = "40m"
  }
}
