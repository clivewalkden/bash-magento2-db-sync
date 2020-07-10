# Magento 2 Production DB Sync v1.2.1

## About
A script to copy over a production database to another server, also has the ability to copy across imagery.

Currently the script is configured to attempt Magento 2 and WordPress database migrations and assumes you have your WordPress database details configured in the `magento/app/etc/env.php` file as a second `connection`.

## Requirements
- You need curl installed locally. 
- The excellent [n98-magerun2](https://github.com/netz98/n98-magerun2) needs to be installed on both the local machine and the production machine. (Needs to be executable as n98-magerun).
- MySQL (or equivalent) needs to be installed on both the local machine and the server (obviously).
- Magento 2 needs to be installed and configured on both the local and the host machine.
- rsync needs to be installed locally.

## Installing and Updating
To install or update the script run the following curl script
```curl -o- https://raw.githubusercontent.com/clivewalkden/bash-magento2-db-sync/v1.2.1/install.sh | bash```

## Usage
To copy over a production database first get a shell on the system you want to copy the data to. 

> Notes: If using SSH to connect to the host machine make sure you've connected with the -A flag so that your ssh agent is forwarded to allow additional connections. 

Execute the script in your Magento directory
```
$ db-sync.sh
```

You can save a configuration file in the Magento directory to save answering some of the questions. An example is included in this repository [example.conf](./example.conf)

```bash
remote_host=cotswoldcollections.com
remote_domain=www.cotswoldcollections.com
remote_port=22
remote_username=magento
remote_magento_dir=/opt/magento/magento2
remote_backup_dir=/opt/magento/backups
remote_shared_deployment_dir=/opt/magento/deployment/shared/magento
```

