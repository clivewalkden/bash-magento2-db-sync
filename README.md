# Magento 2 Production DB Sync

A script to copy over a production database to a staging server.

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