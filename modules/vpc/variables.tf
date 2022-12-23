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

variable "region" {
  description = "IBM Cloud Region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Default"
}

variable "name" {
  description = "Name of the VPC"
  type        = string
}

variable "subnet_total_ipv4_address_count" {
  description = "Total number of IPv4 addresses per subnet"
  default     = 256
  type        = number
}

variable "bastion_ssh_allowed_ips" {
  description = "Allowed CIDRs for ingress rules to the bastion Security Group"
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "ANY"
      cidr = "0.0.0.0/0"
    }
  ]
}
