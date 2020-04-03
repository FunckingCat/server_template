#!/bin/bash

project_domain=''
project_name=''
build_src=''
wsgi_dir=''
python=$(which python3)


read -p "PROJECT DOMAIN:        " project_domain
read -p "PROJECT NAME:          " project_name
read -p "BUILD SRC(full):       " build_src
read -p "WSGI DIR NAME(short):  " wsgi_dir

project_path=/home/$(whoami)/$project_name

`$python -m venv ~/$project_name`

source $project_path/bin/activate

pip install -U pip
pip install Django requests psycopg2 gunicorn

mkdir -pv  ~/$project_name/src
mkdir -pv  ~/$project_name/gunicorn
touch ~/$project_name/gunicorn/access.log
touch ~/$project_name/gunicorn/error.log
cp -r  $build_src/* ~/$project_name/src

cat ~/server-template/nginx/nginx.conf > ~/server-template/nginx/nginx.conf.copy

cat ~/server-template/systemd/gunicorn.service > ~/server-template/systemd/gunicorn.service.copy

sed -i "s~project_path~$project_path~g" ~/server-template/nginx/nginx.conf.copy ~/server-template/systemd/gunicorn.service.copy

sed -i "s~project_domain~$project_domain~g" ~/server-template/nginx/nginx.conf.copy

sed -i "s~wsgi_dir~$wsgi_dir~g" ~/server-template/systemd/gunicorn.service.copy

sudo mv ~/server-template/nginx/nginx.conf.copy  /etc/nginx/nginx.conf

sudo mv ~/server-template/systemd/gunicorn.service.copy /etc/systemd/system/gunicorn.service

sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart

echo "SETUP SUCSESSFULLY FINISHED"
