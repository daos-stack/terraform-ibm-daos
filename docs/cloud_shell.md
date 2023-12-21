# IBM Cloud Shell

Steps required to configure IBM Cloud Shell for use with the modules and examples in this repository.

## WARNING

If an IBM Cloud Shell session ends ALL data will be lost!!!

IBM Cloud Shell sessions time out after 60 mins of inactivity.

In the current version of the terraform-ibm-daos modules and examples
the default "local" backend is used. This means that all Terraform state
will be stored locally. If using IBM Cloud Shell and the session times out or
a browser tab is accidentally closed all state will be lost. In that case
all resources will need to be cleaned up manually.

Cleaning up resources manually would be a very time consuming process!

Therefore, it is not recommended to use IBM Cloud Shell with the modules
and examples in this repo.

**Use IBM Cloud Shell at your own risk!**

## IBM Cloud Shell Configuration

1. [Open cloud shell](https://cloud.ibm.com/shell)
2. Create `~/.ssh directory`

   ```bash
   mkdir -m 700 -p ~/.ssh

   cat > ~/.ssh/config <<EOF
   Host *
       CheckHostIp no
       UserKnownHostsFile /dev/null
       StrictHostKeyChecking no
       PreferredAuthentications publickey,password
       ForwardAgent yes
       TCPKeepAlive yes
       ServerAliveInterval 60
       ServerAliveCountMax 5
   EOF

   chmod 600 ~/.ssh/config
   ```

3. Create an SSH key pair

   ```bash
   ssh-keygen -t rsa -b 4096 -f id_rsa -C "${USER}"
   ```

4. Create a `~/.config/ibmcloud/ibmcloud.env` file

   ```bash
   mkdir -p ~/.config/ibmcloud

   cat > ~/.config/ibmcloud/ibmcloud.env <<EOF
   export IC_API_KEY="<your_ibmcloud_api_key>"
   export IAAS_CLASSIC_USERNAME="<your_email@example.com>"
   export IAAS_CLASSIC_API_KEY="<iaas_classic_api_key>"

   # Optional. To add a prefix to all resource names.
   # If working in a shared project this is useful for identifying owners of
   # resources within the project.
   # export TF_VAR_resource_prefix="${USER}"

   # The public SSH key that will be added to the ~/.ssh/ authorized_keys file
   # of the daos_admin user on the admin instance (bastion)
   export TF_VAR_bastion_public_key="$(cat ~/.ssh/id_rsa.pub)"
   EOF

   chmod 600 ~/.config/ibmcloud/ibmcloud.env

   source ~/.config/ibmcloud/ibmcloud.env
   ```
