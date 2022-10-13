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
  description = "Name of the VPC"
  default     = null
  type        = string
}

variable "subnet_name" {
  description = "Name of the VPC subnet"
  default     = null
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name of resource group for  DAOS admin instances"
  default     = "Default"
  type        = string
}

variable "instance_count" {
  description = "Number of DAOS admin instances to deploy"
  default     = 1
  type        = number
}

variable "instance_profile_name" {
  description = "Name of the instance profile to use for DAOS admin instances"
  default     = "bx2-2x8"
  type        = string
}

variable "instance_base_name" {
  description = "Prefix to assign to all instances"
  default     = "daos-admin"
  type        = string
}

variable "os_image_name" {
  description = "Name of disk image to use for DAOS admin instances"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS admin instances"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of security groups to attach to add to DAOS admin instances"
  type        = list(string)
  default     = []
}

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
