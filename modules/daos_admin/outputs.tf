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

output "region" {
  description = "IBM Cloud region"
  value       = var.region
}

output "zone" {
  description = "IBM Cloud region"
  value       = var.zone
}

output "vpc_name" {
  description = "Name of VPC containing the DAOS Admin instance"
  value       = data.ibm_is_vpc.daos_admin.name
}

output "subnet_name" {
  description = "Name of the subnet for the DAOS Admin instance"
  value       = data.ibm_is_subnet.daos_admin.name
}

output "ssh_key_names" {
  description = "Names of SSH keys attached to DAOS Admin instance"
  value       = var.ssh_key_names
}

output "instance_base_name" {
  description = ""
  value       = var.instance_base_name
}

output "instance_profile_name" {
  description = ""
  value       = var.instance_profile_name
}

output "os_image_name" {
  description = ""
  value       = var.os_image_name
}

output "floating_ip" {
  description = "DAOS Admin instance floating IP"
  value       = ibm_is_floating_ip.daos_admin
}

output "security_group_names" {
  description = "List of Security Groups attached to the DAOS admin instance"
  value       = var.security_group_names
}

/* output "security_groups" {
  description = "List of Security Groups attached to the DAOS admin instance"
  value       = [for sg in data.ibm_is_security_group.admin[*] : sg.name]
} */
/*
output "user_data_script" {
  value = local.user_data_script
}*/

output "admin_security_groups" {
  value = data.ibm_is_security_group.daos_admin
}
