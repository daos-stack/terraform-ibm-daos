# daos_server Terraform Module

This module deploys VM instances that function DAOS servers.

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

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_is_bare_metal_server.daos_server](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/resources/is_bare_metal_server) | resource |
| [ibm_is_instance.daos_server](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/resources/is_instance) | resource |
| [ibm_is_instance_template.daos_server](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/resources/is_instance_template) | resource |
| [ibm_is_image.server_os_image](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_image) | data source |
| [ibm_is_security_group.server](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_security_group) | data source |
| [ibm_is_security_groups.server](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_security_groups) | data source |
| [ibm_is_ssh_key.ssh_keys](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_ssh_key) | data source |
| [ibm_is_subnet.daos_server_sn](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_subnet) | data source |
| [ibm_is_vpc.daos_server_vpc](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/is_vpc) | data source |
| [ibm_resource_group.daos_rg](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_install_script_url"></a> [ansible\_install\_script\_url](#input\_ansible\_install\_script\_url) | URL for script that installs Ansible | `string` | `"https://raw.githubusercontent.com/daos-stack/ansible-collection-daos/main/install_ansible.sh"` | no |
| <a name="input_ansible_playbooks"></a> [ansible\_playbooks](#input\_ansible\_playbooks) | Ansible information to be used in a template that generates a user\_data script | <pre>list(object({<br>    venv_dir           = string<br>    collection_fqn     = string<br>    collection_git_url = string<br>    playbook_fqn       = string<br>  }))</pre> | <pre>[<br>  {<br>    "collection_fqn": "daos_stack.daos",<br>    "collection_git_url": "git+https://github.com/daos-stack/ansible-collection-daos.git,main",<br>    "playbook_fqn": "daos_stack.daos.daos_install",<br>    "venv_dir": "/usr/local/ansible-collection-daos/venv"<br>  }<br>]</pre> | no |
| <a name="input_bare_metal_image_id"></a> [bare\_metal\_image\_id](#input\_bare\_metal\_image\_id) | Find bare\_metal\_image\_id: ibmcloud is images --visibility public \| grep -v deprecated | `string` | `"r006-ddca7216-184b-49a1-83d1-bfd3b356cd97"` | no |
| <a name="input_enable_bare_metal"></a> [enable\_bare\_metal](#input\_enable\_bare\_metal) | Use bare metal instances | `bool` | `true` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud API Key | `string` | n/a | yes |
| <a name="input_instance_bare_metal_profile_name"></a> [instance\_bare\_metal\_profile\_name](#input\_instance\_bare\_metal\_profile\_name) | Name of the instance profile for DAOS server bare metal instances | `string` | `"bx2d-metal-96x384"` | no |
| <a name="input_instance_base_name"></a> [instance\_base\_name](#input\_instance\_base\_name) | Prefix to assign to all instances | `string` | `"daos-server"` | no |
| <a name="input_instance_count"></a> [instance\_count](#input\_instance\_count) | Number of DAOS instances to deploy | `number` | `1` | no |
| <a name="input_instance_profile_name"></a> [instance\_profile\_name](#input\_instance\_profile\_name) | Name of the instance profile to use for DAOS server instances | `string` | `"bx2d-48x192"` | no |
| <a name="input_os_image_name"></a> [os\_image\_name](#input\_os\_image\_name) | Name of disk image to use for DAOS server | `string` | `"ibm-rocky-linux-8-6-minimal-amd64-2"` | no |
| <a name="input_region"></a> [region](#input\_region) | IBM Cloud Region | `string` | `"us-south"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group name | `string` | `"Default"` | no |
| <a name="input_security_group_names"></a> [security\_group\_names](#input\_security\_group\_names) | Names of security groups | `list(string)` | n/a | yes |
| <a name="input_ssh_key_names"></a> [ssh\_key\_names](#input\_ssh\_key\_names) | List of SSH key names to add to DAOS server instances | `list(string)` | `[]` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC name | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | IBM Cloud Zone | `string` | `"us-south-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_daos_access_point_ips"></a> [daos\_access\_point\_ips](#output\_daos\_access\_point\_ips) | List of DAOS server instance IPs that should be specified in the access\_points setting in DAOS .yml config files |
| <a name="output_daos_access_points"></a> [daos\_access\_points](#output\_daos\_access\_points) | List of DAOS server instances that should be specified in the access\_points setting in DAOS .yml config files |
| <a name="output_daos_access_points_bm"></a> [daos\_access\_points\_bm](#output\_daos\_access\_points\_bm) | List of DAOS server instances that should be specified in the access\_points setting in DAOS .yml config files |
| <a name="output_daos_access_points_ips_bm"></a> [daos\_access\_points\_ips\_bm](#output\_daos\_access\_points\_ips\_bm) | List of DAOS server instance IPs that should be specified in the access\_points setting in DAOS .yml config files |
| <a name="output_daos_server_names"></a> [daos\_server\_names](#output\_daos\_server\_names) | List of DAOS server names |
| <a name="output_enable_bare_metal"></a> [enable\_bare\_metal](#output\_enable\_bare\_metal) | Boolean which indicates if DAOS servers use bare\_metal or not. |
| <a name="output_instance_base_name"></a> [instance\_base\_name](#output\_instance\_base\_name) | Prefix assigned to all instances |
| <a name="output_instance_count"></a> [instance\_count](#output\_instance\_count) | Number of DAOS instances |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | Name of the instance profile used for DAOS server instances |
| <a name="output_os_image_name"></a> [os\_image\_name](#output\_os\_image\_name) | Name of disk image to use for DAOS servers |
| <a name="output_region"></a> [region](#output\_region) | IBM Cloud region |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource group name |
| <a name="output_ssh_key_names"></a> [ssh\_key\_names](#output\_ssh\_key\_names) | List of SSH key names added to DAOS server instances |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Subnet name |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | VPC name |
| <a name="output_zone"></a> [zone](#output\_zone) | IBM Cloud region |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
