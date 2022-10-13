# DAOS Cluster Example

Example that demonstrates how to use the submodules in the
**terraform-ibm-daos** module to deploy a DAOS cluster on IBM Cloud.

## How to deploy a DAOS cluster with this example

TODO: This documentation needs to be updated. For now just adding the shell commands.

```bash
# Clone the repo
git clone git@github.com:daos-stack/terraform-ibm-daos.git
cd terraform-ibm-daos
git checkout develop

cd examples/daos_cluster
cp terraform.tfvars.example cp terraform.tfvars
# Edit terraform.tfvars and replace all values in <> brackets

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
| <a name="input_client_instance_base_name"></a> [client\_instance\_base\_name](#input\_client\_instance\_base\_name) | DAOS client instance base name | `string` | `"daos-client"` | no |
| <a name="input_client_instance_count"></a> [client\_instance\_count](#input\_client\_instance\_count) | Number of DAOS instances to deploy | `number` | `1` | no |
| <a name="input_client_instance_profile_name"></a> [client\_instance\_profile\_name](#input\_client\_instance\_profile\_name) | Name of the instance profile to use for DAOS clients | `string` | `"bx2d-48x192"` | no |
| <a name="input_client_os_image_name"></a> [client\_os\_image\_name](#input\_client\_os\_image\_name) | Name of disk image to use for DAOS clients | `string` | `"ibm-rocky-linux-8-6-minimal-amd64-2"` | no |
| <a name="input_cluster_prefix"></a> [cluster\_prefix](#input\_cluster\_prefix) | Prefix to assign to all VPC resource names | `string` | `"daos-example"` | no |
| <a name="input_ibmcloud_api_key"></a> [ibmcloud\_api\_key](#input\_ibmcloud\_api\_key) | IBM Cloud API Key | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | IBM Cloud Region | `string` | `"us-south"` | no |
| <a name="input_security_group_ssh_allowed_ips"></a> [security\_group\_ssh\_allowed\_ips](#input\_security\_group\_ssh\_allowed\_ips) | Map of corporate proxies for ingress rules in Security Groups | <pre>list(object({<br>    region        = string<br>    cidr          = string<br>    first_ipv4_ip = string<br>    last_ipv4_ip  = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr": "0.0.0.0/0",<br>    "first_ipv4_ip": "0.0.0.0",<br>    "last_ipv4_ip": "0.0.0.0",<br>    "region": "ANY"<br>  }<br>]</pre> | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of security groups to attach to add to DAOS admin instances | `list(string)` | `[]` | no |
| <a name="input_server_instance_base_name"></a> [server\_instance\_base\_name](#input\_server\_instance\_base\_name) | DAOS Server instance base name | `string` | `"daos-server"` | no |
| <a name="input_server_instance_count"></a> [server\_instance\_count](#input\_server\_instance\_count) | Number of DAOS instances to deploy | `number` | `1` | no |
| <a name="input_server_instance_profile_name"></a> [server\_instance\_profile\_name](#input\_server\_instance\_profile\_name) | Name of the instance profile to use for DAOS servers | `string` | `"bx2d-metal-96x384"` | no |
| <a name="input_server_os_image_name"></a> [server\_os\_image\_name](#input\_server\_os\_image\_name) | Name of disk image to use for DAOS servers | `string` | `"ibm-rocky-linux-8-6-minimal-amd64-2"` | no |
| <a name="input_ssh_key_names"></a> [ssh\_key\_names](#input\_ssh\_key\_names) | List of SSH key names to add to DAOS instances | `list(string)` | `[]` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Name of the VPC subnet for the DAOS cluster | `string` | `null` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC for the DAOS cluster | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | IBM Cloud Zone | `string` | `"us-south-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_instance_floating_ip_address"></a> [admin\_instance\_floating\_ip\_address](#output\_admin\_instance\_floating\_ip\_address) | DAOS Admin instance floating IP address |
| <a name="output_admin_user_data_script"></a> [admin\_user\_data\_script](#output\_admin\_user\_data\_script) | n/a |
| <a name="output_cluster_prefix"></a> [cluster\_prefix](#output\_cluster\_prefix) | n/a |
| <a name="output_region"></a> [region](#output\_region) | IBM Cloud region |
| <a name="output_server_instance_base_name"></a> [server\_instance\_base\_name](#output\_server\_instance\_base\_name) | n/a |
| <a name="output_server_instance_count"></a> [server\_instance\_count](#output\_server\_instance\_count) | n/a |
| <a name="output_server_instance_profile_name"></a> [server\_instance\_profile\_name](#output\_server\_instance\_profile\_name) | n/a |
| <a name="output_server_os_image_name"></a> [server\_os\_image\_name](#output\_server\_os\_image\_name) | n/a |
| <a name="output_ssh_key_names"></a> [ssh\_key\_names](#output\_ssh\_key\_names) | n/a |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | n/a |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |
| <a name="output_zone"></a> [zone](#output\_zone) | IBM Cloud region |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
