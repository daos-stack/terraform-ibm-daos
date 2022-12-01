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
  description = "VPC name"
  value       = var.vpc_name
}

output "subnet_name" {
  description = "Subnet name"
  value       = var.subnet_name
}

output "resource_group_name" {
  description = "Resource group name"
  value       = var.subnet_name
}

output "instance_count" {
  description = "Number of DAOS instances"
  value       = var.instance_count
}

output "instance_profile_name" {
  description = "Name of the instance profile used for DAOS server instances"
  value       = var.instance_profile_name
}

output "instance_base_name" {
  description = "resource_prefix assigned to all instances"
  value       = var.instance_base_name
}

output "os_image_name" {
  description = "Name of disk image to use for DAOS servers"
  value       = var.os_image_name
}

output "ssh_key_names" {
  description = "List of SSH key names added to DAOS server instances"
  value       = var.ssh_key_names
}

/* output "security_groups" {
  description = "List of Security Groups attached to the DAOS server instance"
  value       = [for sg in data.ibm_is_security_group.daos_server[*] : sg.name]
} */

/* output "user_data_script" {
  value = local.user_data_script
} */

output "enable_bare_metal" {
  description = "Boolean which indicates if DAOS servers use bare_metal or not."
  value       = var.enable_bare_metal
}

output "daos_access_points" {
  description = "List of DAOS server instances that should be specified in the access_points setting in DAOS .yml config files"
  value       = local.access_points
}

output "daos_access_point_ips" {
  description = "List of DAOS server instance IPs that should be specified in the access_points setting in DAOS .yml config files"
  value       = local.access_points
}

output "daos_access_points_bm" {
  description = "List of DAOS server instances that should be specified in the access_points setting in DAOS .yml config files"
  value       = local.access_points
}

output "daos_access_points_ips_bm" {
  description = "List of DAOS server instance IPs that should be specified in the access_points setting in DAOS .yml config files"
  value       = ibm_is_bare_metal_server.daos_server[*].network_interfaces.*.primary_ip
  #value = [for bm in ibm_is_bare_metal_server.daos_server: bm.network_interfaces.*.primary_ip ]
}

output "daos_server_names" {
  description = "List of DAOS server names"
  value       = var.enable_bare_metal ? ibm_is_bare_metal_server.daos_server.*.name : ibm_is_instance.daos_server.*.name
}
