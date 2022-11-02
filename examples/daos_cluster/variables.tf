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

variable "prefix" {
  description = "Prefix to assign to all VPC resource names"
  default     = "daos-example"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = []
}

# TODO: Remove this override when
#       https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/main/install_ansible.sh"
#       is available
variable "ansible_install_script_url" {
  description = "URL for script that installs Ansible"
  type        = string
  default     = "https://raw.githubusercontent.com/mark-olson/ansible-collection-daos/develop/install_ansible.sh"
}

# TODO: Remove this override when
#       https://github.com/mark-olson/ansible-collection-daos.git,main
#       is available.
variable "ansible_playbooks" {
  description = "Ansible information to be used in a template that generates a user_data script"
  type = list(object({
    venv_dir           = string
    collection_fqn     = string
    collection_git_url = string
    playbook_fqn       = string
  }))
  default = [
    {
      venv_dir           = "/usr/local/ansible-collection-daos/venv"
      collection_fqn     = "mark_olson.daos"
      collection_git_url = "git+https://github.com/mark-olson/ansible-collection-daos.git,develop"
      playbook_fqn       = "mark_olson.daos.daos_install"
    }
  ]
}


#
# daos_admin module variables
#

variable "admin_instance_base_name" {
  description = "Admin instance base name"
  default     = "daos-admin"
  type        = string
}

variable "admin_security_group_names" {
  description = "List of security groups to attach to add to DAOS admin instances"
  type        = list(string)
  default     = []
}


#
# daos_server module variables
#

variable "server_instance_count" {
  description = "Number of DAOS Server instances to deploy on VMs"
  default     = 0
  type        = number
}

variable "server_instance_base_name" {
  description = "DAOS Server instance base name"
  default     = "daos-server"
  type        = string
}

variable "server_enable_bare_metal" {
  description = "Use bare metal instances instead of VMs"
  default     = true
  type        = bool
}

variable "server_instance_bare_metal_profile_name" {
  description = "Name of the instance profile for DAOS server bare metal instances"
  default     = "cx2-metal-96x192"
  type        = string
}

variable "server_os_image_name_vm" {
  description = "Name of disk image to use for DAOS server VPC VM images"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}

variable "server_security_group_names" {
  description = "List of security group names to attach to add to DAOS server instances"
  type        = list(string)
  default     = []
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

variable "client_security_group_names" {
  description = "List of security group names to attach to add to DAOS client instances"
  type        = list(string)
  default     = []
}
