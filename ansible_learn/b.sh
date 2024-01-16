#!/bin/bash

# Function to check version
check_version() {
    server=$1

    if [ -e "$(command -v ${server})" ]; then
        os_name=$(awk -F= '/^NAME/ {print $2}' /etc/os-release | tr -d '"')
        version=$("${server}" -v 2>&1 | grep -oP "v=\K[0-9]+\.[0-9]+\.[0-9]+")

        echo -e "\n${os_name} - ${server}"
        echo "${server}_name=${server}"
        echo "${server}_version=${version}"
    else
        echo "${server} file does not exist"
    fi
}

# Function to check Nginx version
# check_redis-server_version() {
#     server=$1
#     if [ -e "$(command -v ${server})" ]; then
#         echo "$(cat /etc/os-release | awk -F= '/^NAME/ {print $2}' | tr -d '"')"
#         echo "cache_name=${server}"
#         cache_version=$("${server}" -v | grep -oP "v=\K[0-9]+\.[0-9]+\.[0-9]+")
#         echo "cache_version=${cache_version}"
#     else
#         echo "${server} file does not exist"
#     fi
# }

# Function to check Nginx version
check_nginx_version() {
    server="nginx"
    server_path="/usr/local/${server}"
    server2="nginx2"
    server_path2="/usr/local/${server2}"

    if [ -e "${server_path}/bin/${server}" ] && command -v yum &> /dev/null; then
        echo "CentOS 7 - ${server}"
        echo "web_name=${server}"
        web_version=$("${server_path}/bin/${server}" -v 2>&1 | grep -oP "nginx/\K[0-9]+\.[0-9]+\.[0-9]+")
        echo "web_version=${web_version}"

    elif [ -e "${server_path2}/bin/${server2}" ] && command -v apt-get &> /dev/null; then
        echo "Ubuntu 22.04 - ${server2}"
        echo "web_name=${server2}"
        web_version=$("${server_path2}/bin/${server2}" -v 2>&1 | grep -oP "nginx/\K[0-9]+\.[0-9]+\.[0-9]+")
        echo "web_version=${web_version}"

    elif [ -e "$(command -v ${server})" ]; then
        echo "$(cat /etc/os-release | awk -F= '/^NAME/ {print $2}' | tr -d '"')"
        echo "web_name=${server}"
        web_version=$("${server}" -v 2>&1 | grep -oP "\K[0-9]+\.[0-9]+\.[0-9]+")
        echo "web_version=${web_version}"

    else
        echo "${server} file does not exist"
    fi
}

# Function to check PHP-FPM version
check_php-fpm_version() {
    server="php-fpm"
    server_path="/usr/local/${server}"
    server2="php-fpm8.1"
    server_path2="/usr/local/${server2}"

    if [ -e "${server_path}/bin/${server}" ] && command -v yum &> /dev/null; then
        echo "CentOS 7 - ${server}"
        echo "was_name=${server}"
        was_version=$("${server_path}/bin/${server}" -v 2>&1 | grep -oP "\K[0-9]+\.[0-9]+\.[0-9]+")
        echo "was_version=${was_version}"

    elif [ -e "$(command -v ${server2})" ] && command -v apt-get &> /dev/null; then
        echo "$(cat /etc/os-release | awk -F= '/^NAME/ {print $2}' | tr -d '"')"
        echo "was_name=${server2}"
        was_version=$("${server2}" -v | grep -oP "PHP \K[0-9]+\.[0-9]+\.[0-9]+")
        echo "was_version=${was_version}"

    elif [ -e "$(command -v ${server})" ]; then
        echo "$(cat /etc/os-release | awk -F= '/^NAME/ {print $2}' | tr -d '"')"
        echo "was_name=${server}"
        was_version=$("${server}" -v | grep -oP "PHP \K[0-9]+\.[0-9]+\.[0-9]+")
        echo "was_version=${was_version}"

    else
        echo "${server} file does not exist"
    fi
}


check_nginx_version
check_php-fpm_version

check_version "redis-server"

