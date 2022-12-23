# terraform-ibm-daos

Terraform modules for deploying [Distributed Asynchronous Object Storage (DAOS)](https://docs.daos.io/v2.2/)  on IBM Cloud

**Not recommended for production!**

The Terraform modules in this repo are in the early stages of development.

## Deploy a DAOS Cluster on IBM Cloud

The [examples](examples/) directory contains Terraform configurations that can be used to deploy a DAOS Cluster on IBM Cloud.

- [examples/daos_cluster](examples/daos_cluster/README.md) can be used to deploy a DAOS cluster in an existing VPC.
- [examples/daos_cluster_new_vpc](examples/daos_cluster_new_vpc/README.md) can be used to deploy a DAOS cluster in a new VPC.

The [daos_cluster_new_vpc](examples/daos_cluster_new_vpc/README.md) example is preferred as it creates a dedicated VPC. This example is the quickest way to get started.

## DAOS Versions

The examples in this repo deploy DAOS v2.2

## Support

As this is a pre-release version, support is limited and provided on a best effort basis.

The following types of support are avaialable.

- **Community Support**

  Community support is provided on a best-effort basis and has no SLA attached.

  Community support is available to anyone via JIRA and Slack.

  - **JIRA**

    Issues with code under the https://github.com/daos-stack GitHub organization are tracked in JIRA Cloud.

    JIRA Project URL:  https://daosio.atlassian.net/jira/software/c/projects/DAOS/issues/

    In order to create and update issues (tickets), you will need to:

      - Have an [Atlassian account](https://support.atlassian.com/atlassian-account/docs/create-an-atlassian-account/)

      - Request access to the [DAOS JIRA project](https://daosio.atlassian.net/jira/software/c/projects/DAOS/issues/).

  - **Slack**

    [DAOS Community Channel on Slack](https://daos-stack.slack.com/archives/C4SM0RZ54)

- **Commercial L3 Support**

  Commercial L3 support is available from Intel Corporation via an on-demand basis.

  For more information about commercial support please get in touch with Intel Corporation via the [DAOS Community Channel on Slack](https://daos-stack.slack.com/archives/C4SM0RZ54)

## Development

If you are contributing content in this repository, please see the [development](docs/development.md) documentation.

## Disclaimer

All roles, playbooks, and other content in this repo are available for use "AS IS" without any warranties of any kind, including, but not limited to their installation, use, or performance. Intel Corporation is not responsible for any damage or charges or data loss incurred with their use. You are responsible for reviewing and testing any scripts you run thoroughly before use in any production environment. This content is subject to change without notice.

## License

Content in this repository is licensed under the [Apache License Version 2.0](LICENSE) open-source license.

[DAOS](https://github.com/daos-stack/daos) is being distributed under the [BSD-2-Clause-Patent](https://github.com/daos-stack/daos/blob/master/LICENSE) open-source license.
