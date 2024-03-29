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
  description = "Name of the instance profile used for DAOS client instances"
  value       = var.instance_profile_name
}

output "instance_base_name" {
  description = "Base name for instances"
  value       = var.instance_base_name
}

output "os_image_name" {
  description = "Name of disk image to use for DAOS clients"
  value       = var.os_image_name
}

output "ssh_key_names" {
  description = "List of SSH key names added to DAOS client instances"
  value       = var.ssh_key_names
}

/* output "security_groups" {
  description = "List of Security Groups attached to the DAOS client instance"
  value       = [for sg in data.ibm_is_security_group.client[*] : sg.name]
} */

/* output "user_data_script" {
  value = local.user_data_script
} */

output "daos_client_names" {
  description = "List of DAOS client names"
  value       = flatten(ibm_is_instance.daos_client.*.name)
}

output "daos_client_instances" {
  value = [for client in ibm_is_instance.daos_client :
    {
      name = "${client.name}"
      ip   = "${client.primary_network_interface[0].primary_ip[0].address}"
    }
  ]
}
