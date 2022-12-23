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
  description = "IBM Cloud zone"
  value       = var.zone
}

output "resource_group_name" {
  description = "Resource group name for DAOS cluster resources"
  value       = var.resource_group_name
}

output "bastion_ip_address" {
  description = "External floating IP for the DAOS admin instance (bastion)"
  value       = module.daos_admin.floating_ip_address
}
