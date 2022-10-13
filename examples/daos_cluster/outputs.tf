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
  description = ""
  value       = var.vpc_name
}

output "subnet_name" {
  description = ""
  value       = var.subnet_name
}

output "cluster_prefix" {
  description = ""
  value       = var.cluster_prefix
}

output "ssh_key_names" {
  description = ""
  value       = var.ssh_key_names
}

output "admin_instance_floating_ip_address" {
  description = "DAOS Admin instance floating IP address"
  value       = module.daos_admin.floating_ip.address
}

output "admin_user_data_script" {
  value = module.daos_admin.user_data_script
}

output "server_instance_count" {
  description = ""
  value       = var.server_instance_count
}

output "server_instance_base_name" {
  description = ""
  value       = var.server_instance_base_name
}

output "server_instance_profile_name" {
  description = ""
  value       = var.server_instance_profile_name
}

output "server_os_image_name" {
  description = ""
  value       = var.server_os_image_name
}
