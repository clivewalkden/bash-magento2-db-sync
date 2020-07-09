# Magento 2 Production DB Sync v1.0.0

A script to copy over a production database to a staging server.

## Installation
To install or update the script run the following curl script
```curl -o- https://raw.githubusercontent.com/clivewalkden/bash-magento2-db-sync/development/install.sh | bash```

You can save a configuration file in the Magento directory to save answering some of the questions.

```bash
remote_host=cotswoldcollections.com
remote_domain=www.cotswoldcollections.com
remote_port=22
remote_username=magento
remote_magento_dir=/opt/magento/magento2
remote_backup_dir=/opt/magento/backups
remote_shared_deployment_dir=/opt/magento/deployment/shared/magento
```

| Notes: Make sure you've connected to the host machine with the -A flag so that your ssh agent is forwarded to allow additional connections.