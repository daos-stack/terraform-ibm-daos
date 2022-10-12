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

#-------------------------------------------------------------------------------
# Single instance resource with a count
#-------------------------------------------------------------------------------
resource "ibm_is_bare_metal_server" "daos_server" {
  count   = var.instance_count
  name    = format("%s-%04s", var.instance_base_name, "${count.index + 1}")
  profile = var.instance_profile_name
  image   = var.baremetal_image_id
  zone    = var.zone
  keys    = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  vpc     = data.ibm_is_vpc.daos_server_vpc.id
  primary_network_interface {
    name                      = "eth0"
    enable_infrastructure_nat = true
    subnet                    = data.ibm_is_subnet.daos_server_sn.id
    #security_groups            = [ibm_is_security_group.login_sg.id]
  }

  timeouts {
    create = "40m"
  }
}
