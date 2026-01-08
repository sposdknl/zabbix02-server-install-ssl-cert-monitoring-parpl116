#!/bin/bash
set -e


apt update && apt upgrade -y


wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-1+ubuntu22.04_all.deb
apt update


apt install -y apache2 \
    zabbix-server-pgsql zabbix-frontend-php php-pgsql \
    zabbix-apache-conf zabbix-sql-scripts \
    zabbix-agent2 zabbix-agent2-plugin-* \
    postgresql postgresql-contrib


sudo -u postgres psql -c "CREATE USER zabbix WITH PASSWORD 'ZabbixPass123';"
sudo -u postgres psql -c "CREATE DATABASE zabbix OWNER zabbix;"
zcat /usr/share/zabbix-sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix

cp /tmp/templates/zabbix_server.conf /etc/zabbix/zabbix_server.conf
cp /tmp/templates/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf
cp /tmp/templates/zabbix.conf.php /etc/zabbix/apache2.conf.d/zabbix.conf.php
cp /tmp/templates/apache2.conf /etc/apache2/conf-available/zabbix.conf


a2enconf zabbix
a2enmod rewrite
systemctl restart apache2

systemctl restart zabbix-server zabbix-agent2 postgresql
systemctl enable apache2 zabbix-server zabbix-agent2 postgresql
