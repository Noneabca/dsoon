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
rm na.crt
rm na.key
rm nb.crt
rm nb.key
rm nc.crt
rm nc.key
rm bna.crt
rm bna.key
rm bnb.crt
rm bnb.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/a.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/a.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/b.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/c.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/c.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/na.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/na.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/nb.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/nb.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/nc.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/nc.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/bna.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/bna.key
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/bnb.crt
wget https://raw.githubusercontent.com/Noneabca/csoon/main/mycert/bnb.key
