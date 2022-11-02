# DAOS Cluster Example

Example that demonstrates how to use the submodules in the
**terraform-ibm-daos** module to deploy a DAOS cluster on IBM Cloud.

## Prerequisites

Before deploying a DAOS cluster using this example Terraform configuration you must first create a VPC.

If you have not yet done that see the instructions in [examples/vpc/README.md](../vpc/README.md)

## How to deploy a DAOS cluster with this example

TODO: This documentation needs to be updated. For now just adding the shell commands.

```bash
cd examples/daos_cluster
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars and replace all values in <> brackets
# If you followed the instructions in the examples/vpc/README.md to
# create your VPC, then you can use the following commands to update
# your terraform.tfvars file. Otherwise, you will need to set the
# variables with the settings that match your VPC.
sed -i "s/<ibmcloud_api_key>/${IBMCLOUD_API_KEY}/g" terraform.tfvars
sed -i "s/<prefix>/${USER}/g" terraform.tfvars

# Run it
terraform init
terraform plan
terraform apply

# Tear it down.  DON'T FORGET THIS!
terraform destroy
```


## Terraform Reference

The following Terraform documentation was auto generated.

### License

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Copyright 2022 Intel Corporation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | 1.46.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_daos_admin"></a> [daos\_admin](#module\_daos\_admin) | ../../modules/daos_admin | n/a |
| <a name="module_daos_client"></a> [daos\_client](#module\_daos\_client) | ../../modules/daos_client | n/a |
| <a name="module_daos_server"></a> [daos\_server](#module\_daos\_server) | ../../modules/daos_server | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_instance_base_name"></a> [admin\_instance\_base\_name](#input\_admin\_instance\_base\_name) | Admin instance base name | `string` | `"daos-admin"` | no |
| <a name="input_admin_security_group_names"></a> [admin\_security\_group\_names](#input\_admin\_security\_group\_names) | List of security groups to attach to add to DAOS admin instances | `list(string)` | `[]` | no |
| <a name="input_ansible_install_script_url"></a> [ansible\_install\_script\_url](#input\_ansible\_install\_script\_url) | URL for script that installs Ansible | `string` | `"https://raw.githubusercontent.com/mark-olson/ansible-collection-daos/develop/install_ansible.sh"` | no |
| <a name="input_ansible_playbooks"></a> [ansible\_playbooks](#input\_ansible\_playbooks) | Ansible information to be used in a template that generates a user\_data script | <pre>list(object({<br>    venv_dir           = string<br>    collection_fqn     = string<br>    collection_git_url = string<br>    playbook_fqn       = string<br>  }))</pre> | <pre>[<br>  {<br>    "collection_fqn": "mark_olson.daos",<br>    "collection_git_url": "git+https://github.com/mark-olson/ansible-collection-daos.git,develop",<br>    "playbook_fqn": "mark_olson.daos.daos_install",<br>    "venv_dir": "/usr/local/ansible-collection-daos/venv"<br>  }<br>]</pre> | no |
| <a name="input_client_instance_base_name"></a> [client\_instance\_base\_name](#input\_client\_instance\_base\_name) | DAOS client instance base name | `string` | `"daos-client"` | no |
| <a name="input_client_instance_count"></a> [client\_instance\_count](#input\_client\_instance\_count) | Number of DAOS instances to deploy | `number` | `1` | no |
| <a name="input_client_instance_profile_name"></a> [client\_instance\_profile\_name](#input\_client\_instance\_profile\_name) | Name of the instance profile to use for DAOS clients | `string` | `"bx2d-48x192"` | no |
| <a name="input_client_os_image_name"></a> [client\_os\_image\_name](#input\_client\_os\_image\_name) | Name of disk image to use for DAOS clients | `string` | `"ibm-rocky-linux-8-6-minimal-amd64-2"` | no |
| <a name="input_client_security_group_names"></a> [client\_security\_group\_names](#input\_client\_security\_group\_names) | List of security group names to attach to add to DAOS client instances | `list(string)` | `[]` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud API Key | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to assign to all VPC resource names | `string` | `"daos-example"` | no |
| <a name="input_region"></a> [region](#input\_region) | IBM Cloud Region | `string` | `"us-south"` | no |
| <a name="input_server_enable_bare_metal"></a> [server\_enable\_bare\_metal](#input\_server\_enable\_bare\_metal) | Use bare metal instances instead of VMs | `bool` | `true` | no |
| <a name="input_server_instance_bare_metal_profile_name"></a> [server\_instance\_bare\_metal\_profile\_name](#input\_server\_instance\_bare\_metal\_profile\_name) | Name of the instance profile for DAOS server bare metal instances | `string` | `"cx2-metal-96x192"` | no |
| <a name="input_server_instance_base_name"></a> [server\_instance\_base\_name](#input\_server\_instance\_base\_name) | DAOS Server instance base name | `string` | `"daos-server"` | no |
| <a name="input_server_instance_count"></a> [server\_instance\_count](#input\_server\_instance\_count) | Number of DAOS Server instances to deploy on VMs | `number` | `0` | no |
| <a name="input_server_os_image_name_vm"></a> [server\_os\_image\_name\_vm](#input\_server\_os\_image\_name\_vm) | Name of disk image to use for DAOS server VPC VM images | `string` | `"ibm-rocky-linux-8-6-minimal-amd64-2"` | no |
| <a name="input_server_security_group_names"></a> [server\_security\_group\_names](#input\_server\_security\_group\_names) | List of security group names to attach to add to DAOS server instances | `list(string)` | `[]` | no |
| <a name="input_ssh_key_names"></a> [ssh\_key\_names](#input\_ssh\_key\_names) | List of SSH key names to add to DAOS instances | `list(string)` | `[]` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the VPC subnet for the DAOS cluster | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC for the DAOS cluster | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | IBM Cloud Zone | `string` | `"us-south-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_instance_floating_ip_address"></a> [admin\_instance\_floating\_ip\_address](#output\_admin\_instance\_floating\_ip\_address) | DAOS Admin instance floating IP address |
| <a name="output_admin_security_group_names"></a> [admin\_security\_group\_names](#output\_admin\_security\_group\_names) | List of Security Groups attached to the DAOS admin instance |
| <a name="output_admin_security_groups"></a> [admin\_security\_groups](#output\_admin\_security\_groups) | List of Security Groups attached to the DAOS admin instance |
| <a name="output_daos_client_names"></a> [daos\_client\_names](#output\_daos\_client\_names) | List of DAOS client instance names |
| <a name="output_daos_server_access_point_ips"></a> [daos\_server\_access\_point\_ips](#output\_daos\_server\_access\_point\_ips) | List of DAOS access point IPs |
| <a name="output_daos_server_access_points"></a> [daos\_server\_access\_points](#output\_daos\_server\_access\_points) | List of DAOS access points |
| <a name="output_daos_server_names"></a> [daos\_server\_names](#output\_daos\_server\_names) | List of DAOS server instance names |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | n/a |
| <a name="output_region"></a> [region](#output\_region) | IBM Cloud region |
| <a name="output_server_instance_base_name"></a> [server\_instance\_base\_name](#output\_server\_instance\_base\_name) | n/a |
| <a name="output_server_instance_count"></a> [server\_instance\_count](#output\_server\_instance\_count) | n/a |
| <a name="output_ssh_key_names"></a> [ssh\_key\_names](#output\_ssh\_key\_names) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | IBM Cloud region |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
