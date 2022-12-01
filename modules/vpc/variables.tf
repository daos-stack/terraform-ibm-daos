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
  default     = "us-south"
}

variable "ibmcloud_timeout" {
  description = "The timeout, expressed in seconds, for interacting with IBM Cloud APIs"
  type        = number
  default     = 900
}

variable "resource_prefix" {
  description = "String that is prepended to all resource names"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Default"
}

variable "subnet_total_ipv4_address_count" {
  description = "Total number of IPv4 addresses per subnet"
  default     = 256
  type        = number
}


/* variable "subnets" {
  description = "VPN Subnets"
  type = list(object({
    zone            = string
    address_resource_prefix  = string
    ipv4_cidr_block = string
    enable_gateway  = bool
    gateway_mode    = string

  }))
  default = [
    {
      zone            = "us-south-1"
      address_resource_prefix  = "10.240.0.0/18"
      ipv4_cidr_block = "10.240.0.0/24"
      enable_gateway  = true
      gateway_mode    = "route"
    },
    {
      zone            = "us-south-2"
      address_resource_prefix  = "10.240.63.0/18"
      ipv4_cidr_block = "10.240.63.0/24"
      enable_gateway  = true
      gateway_mode    = "route"
    },
    {
      zone            = "us-south-3"
      address_resource_prefix  = "10.240.128.0/18"
      ipv4_cidr_block = "10.240.128.0/24"
      enable_gateway  = true
      gateway_mode    = "route"
    }
  ]
} */

/* variable "zones" {
  description = "IBM Cloud Zone"
  default     = ["us-south-1", "us-south-2", "us-south-3"]
  type        = list(string)
} */



/* variable "ipv4_cidr_block" {
  description = "The IPv4 range of the subnet"
  default     = "10.1.1.0/24"
  type        = string
} */

variable "bastion_sg_ssh_allowed_ips" {
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
