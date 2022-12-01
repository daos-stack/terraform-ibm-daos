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
  default     = "us-south"
  type        = string
}

variable "zone" {
  description = "IBM Cloud Zone"
  default     = "us-south-3"
  type        = string
}

variable "resource_prefix" {
  description = "String to prepend to all resource names"
  default     = "example"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Default"
}

variable "vpc_bastion_sg_ssh_allowed_ips" {
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

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = []
}

variable "server_instance_count" {
  description = "Number of DAOS server instances to deploy"
  default     = 1
  type        = number
}

variable "server_instance_base_name" {
  description = "DAOS server instance base name"
  default     = "daos-server"
  type        = string
}

variable "client_instance_count" {
  description = "Number of DAOS client instances to deploy"
  default     = 1
  type        = number
}

variable "client_instance_base_name" {
  description = "DAOS client instance base name"
  default     = "daos-client"
  type        = string
}

variable "admin_instance_count" {
  description = "Number of DAOS admin instances to deploy"
  default     = 1
  type        = number
}

variable "admin_instance_base_name" {
  description = "DAOS admin instance base name"
  default     = "daos-admin"
  type        = string
}
