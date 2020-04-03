#!/bin/bash

user=`whoami`
project_path=`pwd`

role_name=''
passwd=''
base_name=''
dump_path=''

read -p "ROLE NAME:       " role_name
read -p "PASSWORD:        " passwd
read -p "DB NAME:         " base_name 
read -p "DUMP PATH(full): " dump_path

sudo -u postgres psql -c "create user $role_name with superuser password '$passwd';"
sudo -u postgres psql -c "create database $base_name;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $base_name to $role_name;" 
sudo -u postgres psql $base_name < $dump_path
