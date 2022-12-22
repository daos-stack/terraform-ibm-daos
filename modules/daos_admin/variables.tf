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

variable "resource_prefix" {
  description = "String to prepend to all resource names"
  type        = string
  default     = null
}

variable "instance_base_name" {
  description = "Base name for instances"
  default     = "daos-admin"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the instance profile to use for DAOS admin instances"
  default     = "bx2-2x8"
  type        = string
}


variable "os_image_name" {
  description = "Name of disk image to use for DAOS admin instances"
  default     = "ibm-rocky-linux-8-6-minimal-amd64-2"
  type        = string
}

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS admin instances. These are names of keys added to the VPC."
  type        = list(string)
  default     = []
}

variable "security_group_names" {
  description = "Names of security groups for DAOS admin instances"
  type        = list(string)
}

variable "ansible_install_script_url" {
  description = "URL for script that installs Ansible"
  type        = string
  default     = "https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/main/install_ansible.sh"
}

# List of Ansible playbooks that exist within collections.
# Playbooks will run in the order specified.
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
      venv_dir           = "/root/ansible-daos/venv"
      collection_fqn     = "daos_stack.daos"
      collection_git_url = "git+https://github.com/daos-stack/ansible-collection-daos.git,main"
      playbook_fqn       = "daos_stack.daos.daos_cluster"
    }
  ]
}

variable "daos_access_points" {
  description = "List of DAOS access points. This value should be provided by the daos_server module output."
  type        = list(string)
  default     = []
}

variable "daos_client_instances" {
  description = "List of DAOS client instance names and IPs"

  type = list(object({
    name = string,
    ip   = string
  }))

  default = []
}

variable "daos_server_instances" {
  description = "List of DAOS server instance names and IPs"

  type = list(object({
    name            = string,
    ip              = string,
    is_access_point = bool
  }))

  default = []
}

variable "ansible_private_key_pem" {
  description = "Private key data for the ansible user in PEM format"
  type        = string
}

variable "ansible_public_key" {
  description = "Public key data for the ansible user in 'Authorized Keys' format"
  type        = string
}

variable "daos_admin_private_key_pem" {
  description = "Private key data for the daos_admin user in PEM format"
  type        = string
}

variable "daos_admin_public_key" {
  description = "Public key data for the daos_admin user in 'Authorized Keys' format"
  type        = string
}

variable "bastion_public_key" {
  description = "Public key data in 'Authorized Keys' format to allow you to log into the bastion host as the daos_admin user."
  type        = string
}
