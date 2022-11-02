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

variable "ibmcloud_api_key" {
  description = "IBM Cloud API Key"
  type        = string
}

variable "ibmcloud_timeout" {
  default = 900
}

variable "region" {
  description = "IBM Cloud Region where resources will be deployed"
  default     = "us-south"
  type        = string
}

variable "resource_group" {
  default = "Default"
}

variable "prefix" {
  description = "Prefix to assign to all resource names"
  default     = "daos-example"
  type        = string
}


/* variable "subnets" {
  description = "VPN Subnets"
  type = list(object({
    zone            = string
    address_prefix  = string
    ipv4_cidr_block = string
    enable_gateway  = bool
    gateway_mode    = string

  }))
  default = [
    {
      zone            = "us-south-1"
      address_prefix  = "10.240.0.0/18"
      ipv4_cidr_block = "10.240.0.0/24"
      enable_gateway  = true
      gateway_mode    = "route"
    },
    {
      zone            = "us-south-2"
      address_prefix  = "10.240.63.0/18"
      ipv4_cidr_block = "10.240.63.0/24"
      enable_gateway  = true
      gateway_mode    = "route"
    },
    {
      zone            = "us-south-3"
      address_prefix  = "10.240.128.0/18"
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
  description = "Corporate proxies for ingress rules in Security Groups"
  type = list(object({
    name = string
    cidr = string
  }))
  # See https://wiki.ith.intel.com/pages/viewpage.action?pageId=1034194135
  default = [
    {
      name = "ANY"
      cidr = "0.0.0.0/0"
    }
  ]
}
