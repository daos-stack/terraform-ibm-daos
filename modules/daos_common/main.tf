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

resource "tls_private_key" "ansible" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_private_key" "daos_admin" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_is_ssh_key" "ansible" {
  name           = try("${var.resource_prefix}-${var.ansible_ssh_key_name}", "${var.ansible_ssh_key_name}")
  public_key     = tls_private_key.ansible.public_key_openssh
  resource_group = data.ibm_resource_group.main.id
}

resource "ibm_is_ssh_key" "daos_admin" {
  name           = try("${var.resource_prefix}-${var.daos_admin_ssh_key_name}", "${var.daos_admin_ssh_key_name}")
  public_key     = tls_private_key.daos_admin.public_key_openssh
  resource_group = data.ibm_resource_group.main.id
}
