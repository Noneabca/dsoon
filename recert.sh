#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cd /usr/local/nginx/mycert
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.key
