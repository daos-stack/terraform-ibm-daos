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

/* variable "private_ssh_key_path" {
  description = "Path to the local SSH key that will be used to connect to the DAOS admin instance (bastion)"
  type        = string
  default     = "~/.ssh/id_rsa"
} */

variable "bastion_public_key" {
  description = "Public key data in 'Authorized Keys' format to allow you to log into the bastion host as the daos_admin user."
  type        = string
}

/* variable "daos_admin_ssh_key_name" {
  description = "Name of the generated SSH key pair that will be used to manage the DAOS cluster from the admin instance"
  type        = string
  default     = "example-daos-cluster"
} */

variable "ssh_key_names" {
  description = "List of SSH key names to add to DAOS instances"
  type        = list(string)
  default     = ["daos-cluster"]
}

#
# DAOS Server
#

variable "server_instance_count" {
  description = "Number of DAOS server instances to deploy"
  type        = number
  default     = 1
}

variable "server_instance_base_name" {
  description = "DAOS server instance base name"
  type        = string
  default     = "daos-server"
}

variable "server_use_bare_metal" {
  description = "Use bare metal for DAOS server instances"
  type        = bool
  default     = false
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

variable "client_instance_base_name" {
  description = "DAOS client instance base name"
  type        = string
  default     = "daos-client"
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

variable "admin_instance_base_name" {
  description = "DAOS admin instance base name"
  type        = string
  default     = "daos-admin"
}

variable "admin_subnet_name" {
  description = "DAOS admin instance subnet name"
  type        = string
}

variable "admin_security_group_name" {
  description = "Name of security group to attach to DAOS admin instance"
  type        = string
}

# TODO: Remove this override when
#       https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/main/install_ansible.sh" is available
variable "admin_ansible_install_script_url" {
  description = "URL for script that installs Ansible"
  type        = string
  default     = "https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/develop/install_ansible.sh"
}

# TODO: Remove this override when
#       https://github.com/daos-stack/ansible-collection-daos.git,main is available.
variable "admin_ansible_playbooks" {
  description = "Ansible information to be used in a template that generates a user_data script"
  type = list(object({
    venv_dir           = string
    collection_fqn     = string
    collection_git_url = string
    playbook_fqn       = string
  }))
  default = [
    {
      venv_dir           = "/root/daos-ansible/venv"
      collection_fqn     = "daos_stack.daos"
      collection_git_url = "git+https://github.com/daos-stack/ansible-collection-daos.git,develop"
      playbook_fqn       = "daos_stack.daos.daos_cluster"
    }
  ]
}
