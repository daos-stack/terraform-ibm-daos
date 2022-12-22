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
  base_name     = try("${var.resource_prefix}-${var.instance_base_name}", "${var.instance_base_name}")
  first_server  = format("%s-%03s", local.base_name, 1)
  server_names  = var.instance_count == 1 ? local.first_server : format("%s-[%03s-%03s]", local.base_name, 1, var.instance_count)
  max_aps       = var.instance_count > 5 ? 5 : (var.instance_count % 2) == 1 ? var.instance_count : var.instance_count - 1
  access_points = formatlist("%s-%03s", local.base_name, range(1, local.max_aps + 1))

  ssh_key_ids = [
    for ssh_key in data.ibm_is_ssh_key.ssh_keys : {
      id = ssh_key.id
    }
  ]

  security_group_ids = [
    for sg in data.ibm_is_security_group.daos_server : [
      sg.id
    ]
  ]

  user_data = templatefile("${path.module}/templates/user_data.tftpl", {
    ansible_public_key    = var.ansible_public_key
    daos_admin_public_key = var.daos_admin_public_key
  })
}
