#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

cd /usr/local/nginx/mytcp
rm mytcp.conf
rm xitcp.conf
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mytcp.conf
wget https://raw.githubusercontent.com/Noneabca/csoon/main/xitcp.conf
echo "写入成功"
nginx -s reload
echo "热重启成功"
