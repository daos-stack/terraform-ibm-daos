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
  ssh_key_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]

  security_group_ids = [
    for sg in data.ibm_is_security_group.daos_admin : {
      id = sg.id
    }
  ]

  user_data_script = templatefile("${path.module}/templates/user_data.sh.tftpl",
    {
      ansible_install_script_url = var.ansible_install_script_url
      ansible_playbooks          = var.ansible_playbooks
      access_points              = var.daos_access_points
    }
  )

}


# This template format can be used with instance groups
resource "ibm_is_instance_template" "daos_admin" {
  name      = "${var.instance_base_name}-it"
  image     = data.ibm_is_image.daos_admin_os_image.id
  keys      = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  profile   = var.instance_profile_name
  user_data = local.user_data_script
  vpc       = data.ibm_is_vpc.daos_admin.id
  zone      = var.zone

  metadata_service_enabled = true

  primary_network_interface {
    name            = "eth0"
    subnet          = data.ibm_is_subnet.daos_admin.id
    security_groups = [for sg in data.ibm_is_security_group.daos_admin : sg.id]
    # security_groups = var.security_group_names
    # security_groups = local.security_group_ids
    # security_groups = data.ibm_is_security_group.admin
    #security_groups = [data.ibm_is_security_group.admin]
    #security_groups = ["${data.ibm_is_security_group.admin}"]
    #security_groups = [data.ibm_is_security_group.admin]
    #security_groups = toset(data.ibm_is_security_group.admin)
    #security_groups = [ibm_is_security_group.bastion]
  }
}

resource "ibm_is_instance" "daos_admin" {
  name              = "${var.instance_base_name}-001"
  instance_template = ibm_is_instance_template.daos_admin.id

  boot_volume {
    name = "${var.instance_base_name}-001-bv"
  }
}

resource "ibm_is_floating_ip" "daos_admin" {
  name   = "${var.instance_base_name}-floating-ip"
  target = ibm_is_instance.daos_admin.primary_network_interface[0].id
}
