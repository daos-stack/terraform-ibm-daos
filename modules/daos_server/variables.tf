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
  default     = null
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  default     = null
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  default     = "Default"
  type        = string
}

variable "instance_count" {
  description = "Number of DAOS instances to deploy"
  default     = 1
  type        = number
}

variable "instance_profile_name" {
  description = "Name of the instance profile to use for DAOS servers"
  default     = "bx2d-48x192" # mx2d-48x384
  type        = string
}

variable "instance_base_name" {
  description = "Prefix to assign to all instances"
  default     = "daos-server"
  type        = string
}

variable "os_image_name" {
  description = "Name of disk image to use for DAOS servers"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS server instances"
  type        = list(string)
  default     = []
}

# TODO: Determine if we need this or not.
#       Since we use the daos-admin-01 instance as our bastion
#       we only need the network ACLs to allow traffic between
#       all of the DAOS instances. We don't need to add security
#       groups to servers and clients because we won't access
#       them directly. We will always access them from the
#       admin node (bastion).
# variable "security_groups" {
#   description = "List of security groups to attach to DAOS server instances"
#   type        = list(string)
#   default     = []
# }

variable "baremetal_image_id" {
  type    = string
  default = "r006-f137ea64-0d27-4d81-afe0-353fd0557e81" # ibm-rocky-linux-8-6-minimal-amd64-4

variable "user_data_ansible_playbooks" {
  description = "List of Ansible playbooks to be run in user_data script"
  type = list(object({
    repo_name             = string
    repo_url              = string
    playbook_dir          = string
    playbook_file         = string
    repo_url              = string
    ansible_playbook_args = list(string)
    extra_vars            = list(string)
  }))
  default = [
    {
      repo_name     = "maodevops/ansible-collection-daos"
      repo_url      = "https://github.com/markaolson/ansible-collection-daos.git"
      playbook_dir  = "playbooks"
      playbook_file = "daos.yaml"
      ansible_playbook_args = [
        "-c local",
        "-i '127.0.0.1,'",
        "-u root"
      ]
      extra_vars = [
        "daos_roles=['admin']",
        "daos_version='2.2.0'"
      ]
    }
  ]
}
