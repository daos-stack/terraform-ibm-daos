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

#
# variables for all modules
#

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

variable "vpc_name" {
  description = "Name of the VPC for the DAOS cluster"
  default     = null
  type        = string
}

variable "subnet_name" {
  description = "Name of the VPC subnet for the DAOS cluster"
  default     = null
  type        = string
}

variable "cluster_prefix" {
  description = "Prefix to assign to all VPC resource names"
  default     = "daos-example"
  type        = string
}

variable "security_group_ssh_allowed_ips" {
  description = "Map of corporate proxies for ingress rules in Security Groups"
  type = list(object({
    region        = string
    cidr          = string
    first_ipv4_ip = string
    last_ipv4_ip  = string
  }))
  default = [
    {
      region        = "ANY"
      cidr          = "0.0.0.0/0"
      first_ipv4_ip = "0.0.0.0"
      last_ipv4_ip  = "0.0.0.0"
    }
  ]
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of security groups to attach to add to DAOS admin instances"
  type        = list(string)
  default     = []
}


#
# daos_admin module variables
#

variable "admin_instance_base_name" {
  description = "Admin instance base name"
  default     = "daos-admin"
  type        = string
}


#
# daos_server module variables
#

variable "server_instance_count" {
  description = "Number of DAOS instances to deploy"
  default     = 1
  type        = number
}

variable "server_instance_base_name" {
  description = "DAOS Server instance base name"
  default     = "daos-server"
  type        = string
}

variable "server_instance_profile_name" {
  description = "Name of the instance profile to use for DAOS servers"
  default     = "bx2d-48x192" # mx2d-48x384
  type        = string
}

variable "server_os_image_name" {
  description = "Name of disk image to use for DAOS servers"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}


#
# daos_client module variables
#

variable "client_instance_count" {
  description = "Number of DAOS instances to deploy"
  default     = 1
  type        = number
}

variable "client_instance_base_name" {
  description = "DAOS client instance base name"
  default     = "daos-client"
  type        = string
}

variable "client_instance_profile_name" {
  description = "Name of the instance profile to use for DAOS clients"
  default     = "bx2d-48x192" # mx2d-48x384
  type        = string
}

variable "client_os_image_name" {
  description = "Name of disk image to use for DAOS clients"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}
