#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

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

var_v4_v6_iptables() {
	v4iptables=$(iptables -V)
	v6iptables=$(ip6tables -V)
	if [[ ! -z ${v4iptables} ]]; then
		v4iptables="iptables"
		if [[ ! -z ${v6iptables} ]]; then
			v6iptables="ip6tables"
		fi
	else
		exit 1
	fi
}

save_iptables_v4_v6() {
	if [[ ${release} == "centos" ]]; then
		if [[ ! -z "$v6iptables" ]]; then
			service ip6tables save
			chkconfig --level 2345 ip6tables on
		fi
		service iptables save
		chkconfig --level 2345 iptables on
	else
		if [[ ! -z "$v6iptables" ]]; then
			ip6tables-save >/etc/ip6tables.up.rules
			echo -e "#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules\n/sbin/ip6tables-restore < /etc/ip6tables.up.rules" >/etc/network/if-pre-up.d/iptables
		else
			echo -e "#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules" >/etc/network/if-pre-up.d/iptables
		fi
		iptables-save >/etc/iptables.up.rules
		chmod +x /etc/network/if-pre-up.d/iptables
	fi
}


check_system
var_v4_v6_iptables
save_iptables_v4_v6
