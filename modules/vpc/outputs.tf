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

output "id" {
  description = "The ID of the VPC"
  value       = ibm_is_vpc.daos_vpc.id
}

output "crn" {
  description = "The CRN of the VPC"
  value       = ibm_is_vpc.daos_vpc.crn
}

output "name" {
  description = "The name of the VPC"
  value       = ibm_is_vpc.daos_vpc.name
}

output "subnet_names" {
  description = "The names of the subnets in the VPC"
  value       = ibm_is_subnet.daos_sn[*].name
}

output "bastion_sg_name" {
  description = "The name of the bastion security group"
  value       = ibm_is_security_group.bastion.name
}

output "instance_sg_name" {
  description = "The name of the instance security group"
  value       = ibm_is_security_group.instance.name
}
