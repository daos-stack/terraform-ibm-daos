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
  description = "VPC name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "security_group_names" {
  description = "Names of security groups"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "Default"
  type        = string
}

variable "resource_prefix" {
  description = "String to prepend to all resource names"
  type        = string
  default     = null
}

variable "use_bare_metal" {
  description = "Use bare metal instances"
  default     = true
  type        = bool
}

variable "instance_count" {
  description = "Number of DAOS instances to deploy"
  default     = 1
  type        = number
}

variable "instance_profile_name" {
  description = "Name of the instance profile to use for DAOS server instances"
  default     = "bx2d-48x192"
  type        = string
}

variable "instance_bare_metal_profile_name" {
  description = "Name of the instance profile for DAOS server bare metal instances"
  default     = "bx2d-metal-96x384" # "cx2-metal-96x192"
  type        = string
}

variable "instance_base_name" {
  description = "Base name for instances"
  default     = "daos-server"
  type        = string
}

variable "os_image_name" {
  description = "Name of disk image to use for DAOS server"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS server instances"
  type        = list(string)
  default     = []
}

# Find bare_metal_image_id:
# ibmcloud is images --visibility public | grep -v deprecated
variable "bare_metal_image_id" {
  type    = string
  default = "r006-d2a541d6-ceac-420d-a612-8ab43453f376" # ibm-redhat-8-6-minimal-amd64-3
}

variable "daos_admin_public_key" {
  description = "Public key data for the daos_admin user in 'Authorized Keys' format"
  type        = string
}

variable "ansible_public_key" {
  description = "Public key data for the ansible user in 'Authorized Keys' format"
  type        = string
}
