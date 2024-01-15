#!/bin/bash

process_info=$(sudo netstat -nlpt | grep -w "0.0.0.0:80")

get_nginx_info() {
    nginx_path=($which nginx) #/usr/sbin/nginx
    nginx_version=$(${nginx_path} -v 2>&1 | grep -oP "nginx/\K[0-9]+\.[0-9]+\.[0-9]+")
    echo "Nginx Version: ${nginx_version}"
}

centos_get_apache_info() {
    apache_path=/usr/local/apache2/bin/httpd
    apache_version=$(${apache_path} -v | grep -oP "Apache/\K[0-9]+\.[0-9]+\.[0-9]+")
    echo "Apache Version: ${apache_version}"
}

cenots_get_php_info() {
    php_path=/usr/local/php/bin/php
    php_version=$(${php_path} -v | head -n 1 | awk '{print $2}')
    echo "PHP Version: ${php_version}"
}

centos_get_phpfpm_info() {
    phpfpm_path=$(which php-fpm)
    phpfpm_version=$(${phpfpm_path} -v | grep -oP "PHP \K[0-9]+\.[0-9]+\.[0-9]+")
    echo "PHP-FPM Version: ${phpfpm_version}"
}

ubuntu_get_phpfpm_info() {
    phpfpm_path=$(which php-fpm8.1)
    phpfpm_version=$(${phpfpm_path} -v | grep -oP "PHP \K[0-9]+\.[0-9]+\.[0-9]+")
    echo "PHP-FPM Version: ${phpfpm_version}"
}

# Check the distribution type
if command -v apt &> /dev/null; then
    echo "우분투 작업(Ubuntu)"

    if [[ -n "$process_info" ]]; then
        if echo "$process_info" | grep -qi 'nginx'; then
            echo "Nginx is running on port 80."
            get_nginx_info
            ubuntu_get_phpfpm_info
        fi

        if echo "$process_info" | grep -qi 'httpd'; then
            echo "Apache(httpd) is running on port 80."
        fi
    else
        echo "No process found listening on port 80."
    fi

elif command -v yum &> /dev/null; then
    echo "센트오에스 작업(CentOS)"

    if [[ -n "$process_info" ]]; then
        if echo "$process_info" | grep -qi 'nginx'; then
            echo "Nginx is running on port 80."
            get_nginx_info
            centos_get_phpfpm_info
        fi

        if echo "$process_info" | grep -qi 'httpd'; then
            echo "Apache(httpd) is running on port 80."
            centos_get_apache_info
            cenots_get_php_info
        fi

    else
        echo "No process found listening on port 80."
    fi

else
    echo "Unknown distribution."
fi
