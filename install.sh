#!/bin/bash

echo "SETUP START"

cat ~/server-template/bash/bashrc > ~/.bashrc
cat ~/server-template/bash/vimrc > ~/.vimrc

source ~/.bashrc
source ~/.vimrc

sudo apt update -y && sudo apt upgrade -y

sudo apt install -y neofetch python3-pip libpq-dev python-dev postgresql tree nginx gunicorn python3-venv

pip3 install Django requests psycopg2 virtualenv 

clear

neofetch

echo "UPDATE && INSTALL FINISHED"


