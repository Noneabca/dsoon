#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cd /usr/local/nginx/mycert
rm a.crt
rm a.key
rm b.crt
rm b.key
rm c.crt
rm c.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/a.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/a.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/c.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/c.key
