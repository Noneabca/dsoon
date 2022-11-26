#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "server {
        listen 80;
        server_name cdn.mumbestbuy.com;
        location / {
            root   html;
            index  index.html index.htm;
        }
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }">/usr/local/nginx/myhttp/cdnsay.conf
    
nginx -s reload
echo "热重启成功"
