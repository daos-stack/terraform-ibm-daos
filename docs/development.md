# Development

Please use the [pre-commit](https://pre-commit.com/) hooks configured in this repository to ensure that all Terraform modules are validated and properly documented before pushing code changes.


## Install pre-commit and dependencies

In order to use [pre-commit](https://pre-commit.com/) you will need to install it on your system.

You will also need to install the dependencies that are required for the pre-commit plugins used in this repository.

1. Install [pre-commit](https://pre-commit.com/).

   [pre-commit](https://pre-commit.com/) can be installed using standard package managers.

   Instructions can be found at the [pre-commit website](https://pre-commit.com/#install).

2. Install [TFLint](https://github.com/terraform-linters/tflint)

   See the [installation instructions](https://github.com/terraform-linters/tflint#installation)

   After installing tflint change into the root of the locally cloned git repo and run the `init` command.

   ```shell
   cd <root of google-cloud-daos repo>
   tflint --init
   ```

3. Install terraform-docs

   See [https://github.com/terraform-docs/terraform-docs](https://github.com/terraform-docs/terraform-docs)

4. Add `ADDLICENSE_COMPANY_NAME` environment variable to your `~/.bashrc` file

   When pre-commit runs for the first time it will download the [google/addlicense](https://github.com/google/addlicense/releases/tag/v1.0.0) binary into the `tools/autodoc/` directory. The `addlicense` binary is excluded in the `.gitignore` file so it does not get checked into the repo.

   The `addlicense` pre-commit hook will ensure that files have the proper license header.

   The company name that is used in the license header is specified in the `ADDLICENSE_COMPANY_NAME` environment variable.

   If the `ADDLICENSE_COMPANY_NAME` environment variable is not present, the company name in the license header will be set to **Intel Corporation**

   If you do not work for Intel be sure to export the `ADDLICENSE_COMPANY_NAME` environment variable with the name of your company as it should appear in the license header of files.

   ```bash
   export ADDLICENSE_COMPANY_NAME="your_company_name_here"
   ```

5. MacOS only

   MacOS users will need to install `findutils` and `coreutils`.

   Before installing coreutils read the
   [gotchas about coreutils](https://www.pixelbeat.org/docs/coreutils-gotchas.html)
   to ensure that the installation will not negatively impact your
   system.

   **Homebrew**

   ```shell
   brew install findutils
   brew install coreutils
   ```

   Update your PATH  in your `~/.bashrc` or `~/.bash_profile`
   ```shell
   ### Use GNU coreutils instead of macOS default commands
   if type brew &>/dev/null; then
      export HOMEBREW_PREFIX=$(brew --prefix)
      for d in "${HOMEBREW_PREFIX}/opt/*/libexec/gnubin"; do export PATH=$d:$PATH; done
      for d in "${HOMEBREW_PREFIX}/opt/*/libexec/gnuman"; do export MANPATH=$d:$MANPATH; done
   fi
   ```

## Install the pre-commit hook

After you have installed [pre-commit](https://pre-commit.com/) and its dependencies on your system you need to install the pre-commit hook in
your local clone of the terraform-ibm-daos git repository.

```shell
cd <root of terraform-ibm-daos repo>
pre-commit install
```

## Running pre-commit

[pre-commit](https://pre-commit.com/) will now run on any files that are staged when you run `git commit -s`.

To run [pre-commit](https://pre-commit.com/) on all files prior to staging them

```shell
pre-commit run --all-files
```

## Submitting PRs

Direct pushes are not allowed to the `develop` and `main` branches.

You must submit PRs.

All PRs must have an associated ticket in JIRA.

> **TODO:** Document the process and add an example here.
