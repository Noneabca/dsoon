#!/usr/bin/env bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

NGINX_CONF_DIR="/usr/local/nginx/myhttp"
CONF_FILE="${NGINX_CONF_DIR}/reip.conf"
BACKUP_FILE="${CONF_FILE}.backup"

function reip_conf() {
    # 检查配置目录是否存在
    if [ ! -d "${NGINX_CONF_DIR}" ]; then
        echo "错误：配置目录不存在: ${NGINX_CONF_DIR}"
        return 1
    fi

    # 获取 IP 地址
    echo "正在获取公网 IP..."
    myip=$(curl -s --connect-timeout 10 --max-time 30 ip.qaros.com | awk 'NR==1')
    
    # 验证 IP 地址格式
    if [ -z "${myip}" ]; then
        echo "错误：无法获取 IP 地址"
        return 1
    fi
    
    # 简单的 IP 格式验证（支持 IPv4）
    if ! echo "${myip}" | grep -Pq '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$'; then
        echo "错误：获取的 IP 格式无效: ${myip}"
        return 1
    fi
    
    echo "获取到 IP: ${myip}"

    # 备份原配置文件
    if [ -f "${CONF_FILE}" ]; then
        cp "${CONF_FILE}" "${BACKUP_FILE}"
        echo "已备份原配置到: ${BACKUP_FILE}"
    fi

    # 写入新配置 - 307 重定向到 baidu.com
    cat > "${CONF_FILE}" <<EOF
server {
    listen 80;
    server_name ${myip};
    
    # 307 临时重定向到 baidu.com
    return 307 https://www.baidu.com\$request_uri;
}
EOF

    # 检查文件是否写入成功
    if [ ! -f "${CONF_FILE}" ]; then
        echo "错误：配置文件写入失败"
        # 恢复备份
        [ -f "${BACKUP_FILE}" ] && mv "${BACKUP_FILE}" "${CONF_FILE}"
        return 1
    fi
    
    echo "配置文件写入成功"

    # 验证 nginx 配置
    echo "验证 nginx 配置..."
    if ! nginx -t 2>&1 | grep -q "successful"; then
        echo "错误：nginx 配置验证失败"
        # 恢复备份
        if [ -f "${BACKUP_FILE}" ]; then
            mv "${BACKUP_FILE}" "${CONF_FILE}"
            echo "已恢复原配置"
        fi
        return 1
    fi

    # 重载 nginx
    echo "重载 nginx..."
    if nginx -s reload; then
        echo "✓ nginx 重载成功"
        echo "访问 http://${myip} 将返回 307 重定向到 https://www.baidu.com"
        # 删除备份
        [ -f "${BACKUP_FILE}" ] && rm "${BACKUP_FILE}"
        return 0
    else
        echo "错误：nginx 重载失败"
        # 恢复备份
        if [ -f "${BACKUP_FILE}" ]; then
            mv "${BACKUP_FILE}" "${CONF_FILE}"
            echo "已恢复原配置"
        fi
        return 1
    fi
}

# 执行函数并检查返回值
if reip_conf; then
    echo "========== 执行成功 =========="
else
    echo "========== 执行失败 =========="
    exit 1
fi
