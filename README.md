# terraform-ibm-daos

DAOS Terraform modules for deploying DAOS on IBM Cloud

Repository structure

```bash
./
├── docs/                 - Documentation
├── examples/             - Examples
│   ├── daos_cluster/     - Example of how to use this module to deploy a DAOS cluster
│   └── vpc               - Terraform configuration for a VPC to be used with other examples
├── modules/              - Sub modules
│   ├── daos_admin/       - Deploys DAOS admin instances
│   ├── daos_client/      - Deploys DAOS client instances
│   ├── daos_common/      - Deploys resources that are common between all instances
│   └── daos_server/      - Deploys DAOS server instances
├── tools/                - Tools used for development (pre-commit hooks, etc)
├── LICENSE
├── README.md
├── main.tf               - Main module file for deploying a DAOS cluster
├── outputs.tf            - Outputs for the main module
├── requirements-dev.txt  - Pip packages needed for development of this module
└── variables.tf          - Variables for the main module
```

## Warning!

The Terraform modules and examples in this repo are in a very early development stage.

The content in this repo should not be used for production environments.

## Deploying a DAOS Cluster on IBM Cloud

The [examples](examples/) directory contains two example Terraform configurations that can be used to deploy a DAOS Cluster on IBM Cloud.

1. [examples/vpc](examples/vpc/README.md) can be used to create a VPC if you do not already have one.
2. [examples/daos_cluster](examples/daos_cluster/README.md) can be used to deploy a DAOS cluster in your VPC.

### VPC setup

Before you can deploy a DAOS cluster using the [examples/daos_cluster](examples/daos_cluster/README.md) example you first need to create a VPC.

It is recommended that you create a VPC specifically for your DAOS deployment. If you have multiple team members using a single cloud account, each team member can create their own VPC.

See [examples/vpc/README.md](examples/vpc/README.md) for instructions.

### Deploying the daos_cluster example

After you have created a VPC you may deploy a DAOS cluster using the [examples/daos_cluster](examples/daos_cluster/README.md) example

The [examples/daos_cluster](examples/daos_cluster) directory contains a Terraform configuration that demonstrates how to use the Terraform modules in [modules](modules/) to deploy a DAOS cluster.

See [examples/daos_cluster/README.md](examples/daos_cluster/README.md)

## Development

If you are contributing content in this repository, please see the [development](docs/development.md) documentation.
