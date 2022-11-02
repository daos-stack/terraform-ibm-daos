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

output "prefix" {
  description = ""
  value       = var.prefix
}

output "ssh_key_names" {
  description = ""
  value       = var.ssh_key_names
}

output "admin_instance_floating_ip_address" {
  description = "DAOS Admin instance floating IP address"
  value       = module.daos_admin.floating_ip.address
}

/* output "admin_user_data_script" {
  value = module.daos_admin.user_data_script
} */

output "server_instance_count" {
  description = ""
  value       = var.server_instance_count
}

output "server_instance_base_name" {
  description = ""
  value       = var.server_instance_base_name
}

output "admin_security_group_names" {
  description = "List of Security Groups attached to the DAOS admin instance"
  value       = module.daos_admin.security_group_names
}

output "admin_security_groups" {
  description = "List of Security Groups attached to the DAOS admin instance"
  value       = module.daos_admin.admin_security_groups
}

output "daos_server_access_points" {
  description = "List of DAOS access points"
  value       = module.daos_server.daos_access_points
}

output "daos_server_access_point_ips" {
  description = "List of DAOS access point IPs"
  value       = module.daos_server.daos_access_point_ips
}

output "daos_server_names" {
  description = "List of DAOS server instance names"
  value       = module.daos_server.daos_server_names
}

output "daos_client_names" {
  description = "List of DAOS client instance names"
  value       = module.daos_client.daos_client_names
}
