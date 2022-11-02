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
  first_server  = format("%s-%03s", var.instance_base_name, 1)
  servers       = var.instance_count == 1 ? local.first_server : format("%s-[%03s-%03s]", var.instance_base_name, 1, var.instance_count)
  max_aps       = var.instance_count > 5 ? 5 : (var.instance_count % 2) == 1 ? var.instance_count : var.instance_count - 1
  access_points = formatlist("%s-%03s", var.instance_base_name, range(1, local.max_aps + 1))

  ssh_key_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]

  security_group_ids = [
    for sg in data.ibm_is_security_group.server : [
      sg.id
    ]
  ]

  user_data_script = templatefile("${path.module}/templates/user_data.sh.tftpl",
    {
      ansible_install_script_url = var.ansible_install_script_url
      ansible_playbooks          = var.ansible_playbooks
      access_points              = local.access_points
    }
  )
}
