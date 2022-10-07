#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
Info="${green}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"

# check root
[[ $EUID -ne 0 ]] && echo -e "${Error} 必须使用root用户运行此脚本！\n" && exit 1

check_system() {
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	fi
	bit=$(uname -m)
}

set_nfconf() {
cd /etc
rm nftables.conf
wget https://raw.githubusercontent.com/Noneabca/csoon/main/nftables.conf
chmod +x /etc/nftables.conf
systemctl enable nftables.service
systemctl start nftables.service
echo "执行完毕 进入系统重启"
reboot
}

install_nftables() {
	getnftables=$(nft -v | awk 'NR==1{print  $1}')
	if [ "$release" == "debian" ] || [ "$release" == "ubuntu" ]; then
		if [ -z ${getnftables} ]; then
			apt install nftables -y
		fi
	elif [[ "$release" == "centos" ]] && [ -z ${getnftables} ]; then
		yum install nftables -y
	fi
}


check_system
install_nftables
set_nfconf
