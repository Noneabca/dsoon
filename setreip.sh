#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

function reip_conf() {
rm /usr/local/nginx/myhttp/reip.conf
myip=$(curl ip.qaros.com | awk 'NR==1')
if [ ! -z ${myip} ]; then
echo "server {
        listen 80;
        server_name "${myip}";
        location / {
            root   html;
            index  index.html index.htm;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }">/usr/local/nginx/myhttp/reip.conf
    echo "${myip}"
    echo "写入成功"
    nginx -s reload
    echo "热重启成功"
else
	echo "执行失败"
fi
}

reip_conf
