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

variable "zone" {
  description = "IBM Cloud Zone"
  type        = string
  default     = "us-south-3"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Default"
}

variable "resource_prefix" {
  description = "String to prepend to all resource names"
  type        = string
  default     = null
}

variable "vpc_name" {
  description = "Name of VPC where DAOS instances will be deployed"
  type        = string
}

variable "bastion_public_key" {
  description = "Public key data in 'Authorized Keys' format to allow you to log into the bastion host as the daos_admin user."
  type        = string
}


variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = []
}

#
# DAOS Server
#

variable "server_instance_count" {
  description = "Number of DAOS server instances to deploy"
  type        = number
  default     = 1
}

variable "server_use_bare_metal" {
  description = "Use bare metal for DAOS server instances"
  type        = bool
  default     = true
}

variable "server_subnet_name" {
  description = "DAOS server instances subnet name"
  type        = string
}

variable "server_security_group_name" {
  description = "DAOS server security group"
  type        = string
}


#
# DAOS Client
#

variable "client_instance_count" {
  description = "Number of DAOS client instances to deploy"
  type        = number
  default     = 1
}

variable "client_subnet_name" {
  description = "DAOS client instances subnet name"
  type        = string
}

variable "client_security_group_name" {
  description = "DAOS client security group"
  type        = string
}


#
# DAOS Admin
#

variable "admin_subnet_name" {
  description = "DAOS admin instance subnet name"
  type        = string
}

variable "admin_security_group_name" {
  description = "Name of security group to attach to DAOS admin instance"
  type        = string
}
