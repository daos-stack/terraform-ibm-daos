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

## Warning

The Terraform modules and examples in this repo are currently in the very
early development stage.

The content in this repo should not be used for Production environments or demos.

## Development

If you are contributing content in this repository, please see the [development](docs/development.md) documentation.
