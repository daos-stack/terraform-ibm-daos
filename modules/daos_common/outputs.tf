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

output "ansible_key_name" {
  value = ibm_is_ssh_key.ansible.name
}

output "ansible_private_key_pem" {
  value     = tls_private_key.ansible.private_key_pem
  sensitive = true
}

output "ansible_public_key" {
  value = tls_private_key.ansible.public_key_openssh
}

output "daos_admin_key_name" {
  value = ibm_is_ssh_key.daos_admin.name
}

output "daos_admin_private_key_pem" {
  value     = tls_private_key.daos_admin.private_key_pem
  sensitive = true
}

output "daos_admin_public_key" {
  value = tls_private_key.daos_admin.public_key_openssh
}
