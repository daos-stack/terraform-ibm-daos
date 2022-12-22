# IBM Cloud Shell Configuration

1. [Open cloud shell](https://cloud.ibm.com/shell)
2. Create ~/.ssh directory

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

3. Upload your private and public SSH key files to `~/.ssh`
4. Set permissions

   This assumes you are using RSA keys

   ```bash
   chmod 600 ~/.ssh/id_rsa
   chmod 644 ~/.ssh/id_rsa.pub
   chown -R ${USER} ~/.ssh
   ```

5. Create a `~/.config/ibmcloud/ibmcloud.env` file

   ```bash
   mkdir -p ~/.config/ibmcloud

   cat > ~/.config/ibmcloud/ibmcloud.env <<EOF
   export IC_API_KEY="ibmcloud_api_key"
   export IAAS_CLASSIC_USERNAME="iaas_classic_username"
   export IAAS_CLASSIC_API_KEY="iaas_classic_api_key"

   # Optional. Will prefix your user name to all resources.
   # If working in a shared project this is useful for identifying  owners of
   # resources within the project.
   # Cloud Shell usernames can be long. You may want to use a shorter string.
   # export TFVAR_resource_prefix="${USER}"

   # The public SSH key that will be added to the ~/.ssh/ authorized_keys file
   # of the daos_admin user on the admin instance (bastion)
   export TFVAR_bastion_public_key="$(cat ~/.ssh/id_rsa.pub)"
   EOF

   chmod 600 ~/.config/ibmcloud/ibmcloud.env
   ```

At this point you should be able to follow the instructions in the **Deploy the VPC and DAOS Cluster** section of the [examples/daos_cluster_new_vpc/README.md](../examples/daos_cluster_new_vpc/README.md)
