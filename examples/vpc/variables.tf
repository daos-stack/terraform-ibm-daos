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

#-------------------------------------------------------------
# Variables for all modules
#-------------------------------------------------------------

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
}

variable "region" {
  description = "IBM Cloud Region"
  default     = "us-south"
  type        = string
}

variable "zone" {
  description = "IBM Cloud Zone"
  default     = "us-south-3"
  type        = string
}

variable "vpc_prefix" {
  description = "Prefix to assign to all VPC resource names"
  default     = "daos-example"
  type        = string
}

variable "ipv4_cidr_block" {
  description = "The IPv4 range of the subnet"
  default     = "10.1.1.0/24"
  type        = string
}

variable "security_group_ssh_allowed_ips" {
  description = "Corporate proxies for ingress rules in Security Groups"
  type = list(object({
    name          = string
    cidr          = string
    first_ipv4_ip = string
    last_ipv4_ip  = string
  }))
  # See https://wiki.ith.intel.com/pages/viewpage.action?pageId=1034194135
  default = [
    {
      name          = "ANY"
      cidr          = "0.0.0.0/0"
      first_ipv4_ip = "0.0.0.0"
      last_ipv4_ip  = "0.0.0.0"
    },
    {
      name          = "VPC"
      cidr          = "10.1.0.0/16"
      first_ipv4_ip = "10.1.1.1"
      last_ipv4_ip  = "10.1.255.255"
    }
  ]
}
