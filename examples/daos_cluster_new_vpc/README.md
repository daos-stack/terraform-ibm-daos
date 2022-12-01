# DAOS Cluster in a new VPC

Example that demonstrates how to use the submodules in the
**terraform-ibm-daos** module to deploy a DAOS cluster on IBM Cloud.

## Prerequisites

Before deploying a DAOS cluster using this example Terraform configuration you must first create a VPC.

If you have not yet done that see the instructions in [examples/vpc/README.md](../vpc/README.md)

If you would like to deploy the resources in a new resource group, you
will need to create one prior to running this Terraform configuration.
Then you will need to provide the name of the new resource group in the terraform.tfvars file.

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
sed -i "s/<resource_prefix>/${USER}/g" terraform.tfvars

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

| Name | Version |
|------|---------|
| <a name="provider_ibm"></a> [ibm](#provider\_ibm) | 1.46.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_daos_admin"></a> [daos\_admin](#module\_daos\_admin) | ../../modules/daos_admin | n/a |
| <a name="module_daos_client"></a> [daos\_client](#module\_daos\_client) | ../../modules/daos_client | n/a |
| <a name="module_daos_server"></a> [daos\_server](#module\_daos\_server) | ../../modules/daos_server | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [ibm_resource_group.daos](https://registry.terraform.io/providers/IBM-Cloud/ibm/1.46.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_instance_base_name"></a> [admin\_instance\_base\_name](#input\_admin\_instance\_base\_name) | DAOS admin instance base name | `string` | `"daos-admin"` | no |
| <a name="input_admin_instance_count"></a> [admin\_instance\_count](#input\_admin\_instance\_count) | Number of DAOS admin instances to deploy | `number` | `1` | no |
| <a name="input_client_instance_base_name"></a> [client\_instance\_base\_name](#input\_client\_instance\_base\_name) | DAOS client instance base name | `string` | `"daos-client"` | no |
| <a name="input_client_instance_count"></a> [client\_instance\_count](#input\_client\_instance\_count) | Number of DAOS client instances to deploy | `number` | `1` | no |
| <a name="input_region"></a> [region](#input\_region) | IBM Cloud Region where resources will be deployed | `string` | `"us-south"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | `"Default"` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | String to prepend to all resource names | `string` | `"example"` | no |
| <a name="input_server_instance_base_name"></a> [server\_instance\_base\_name](#input\_server\_instance\_base\_name) | DAOS server instance base name | `string` | `"daos-server"` | no |
| <a name="input_server_instance_count"></a> [server\_instance\_count](#input\_server\_instance\_count) | Number of DAOS server instances to deploy | `number` | `1` | no |
| <a name="input_ssh_key_names"></a> [ssh\_key\_names](#input\_ssh\_key\_names) | List of SSH key names to add to DAOS instances | `list(string)` | `[]` | no |
| <a name="input_vpc_bastion_sg_ssh_allowed_ips"></a> [vpc\_bastion\_sg\_ssh\_allowed\_ips](#input\_vpc\_bastion\_sg\_ssh\_allowed\_ips) | Allowed CIDRs for ingress rules to the bastion Security Group | <pre>list(object({<br>    name = string<br>    cidr = string<br>  }))</pre> | <pre>[<br>  {<br>    "cidr": "0.0.0.0/0",<br>    "name": "ANY"<br>  }<br>]</pre> | no |
| <a name="input_zone"></a> [zone](#input\_zone) | IBM Cloud Zone | `string` | `"us-south-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_region"></a> [region](#output\_region) | IBM Cloud region |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
