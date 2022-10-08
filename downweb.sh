#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cd /var/www/html
rm index.html
wget https://raw.githubusercontent.com/Noneabca/dsoon/main/index.html
