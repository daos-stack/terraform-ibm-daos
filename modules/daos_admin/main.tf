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
  base_name           = try("${var.resource_prefix}-${var.instance_base_name}", "${var.instance_base_name}")
  admin_instance_name = "${local.base_name}-001"

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

  cloud_init_parts = [
    {
      file_path    = "${path.module}/templates/cloud-init.yaml.tftpl"
      content_type = "text/cloud-config"
      vars = {
        admin_instance_name        = local.admin_instance_name
        ansible_private_key_pem    = base64encode(var.ansible_private_key_pem)
        ansible_public_key         = var.ansible_public_key
        bastion_public_key         = var.bastion_public_key
        daos_admin_private_key_pem = base64encode(var.daos_admin_private_key_pem)
        daos_admin_public_key      = var.daos_admin_public_key
        daos_client_instances      = var.daos_client_instances
        daos_server_instances      = var.daos_server_instances
      }
    },
    {
      file_path    = "${path.module}/templates/startup-script.sh.tftpl"
      content_type = "x-shellscript-per-once"
      vars = {
        access_points              = var.daos_access_points
        ansible_install_script_url = var.ansible_install_script_url
        ansible_playbooks          = var.ansible_playbooks
      }
    }
  ]

  cloud_init_parts_rendered = [for part in local.cloud_init_parts : <<EOT
--MIMEBOUNDARY
Content-Transfer-Encoding: 7bit
Content-Type: ${part.content_type}
Mime-Version: 1.0

${templatefile(part.file_path, part.vars)}
    EOT
  ]

  user_data = templatefile("${path.module}/templates/cloud-init.tftpl", { cloud_init_parts = local.cloud_init_parts_rendered })

}

# This template format can be used with instance groups
resource "ibm_is_instance_template" "daos_admin" {
  name      = "${local.base_name}-it"
  image     = data.ibm_is_image.daos_admin_os_image.id
  keys      = [for ssh_key in local.ssh_key_ids : ssh_key.id]
  profile   = var.instance_profile_name
  user_data = local.user_data
  vpc       = data.ibm_is_vpc.daos_admin.id
  zone      = var.zone

  metadata_service_enabled = true

  primary_network_interface {
    name            = "eth0"
    subnet          = data.ibm_is_subnet.daos_admin.id
    security_groups = [for sg in data.ibm_is_security_group.daos_admin : sg.id]
  }
}

resource "ibm_is_instance" "daos_admin" {
  name              = local.admin_instance_name
  instance_template = ibm_is_instance_template.daos_admin.id

  boot_volume {
    name = "${var.resource_prefix}-${var.instance_base_name}-001-bv"
  }
}

resource "ibm_is_floating_ip" "daos_admin" {
  name   = "${local.base_name}-floating-ip"
  target = ibm_is_instance.daos_admin.primary_network_interface[0].id
}
