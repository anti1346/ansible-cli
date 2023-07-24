#!/bin/bash

# Change directory to /usr/local/src
cd /usr/local/src

# # Download MySQL tarball
# wget -q https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.34-linux-glibc2.28-x86_64.tar.gz

# # Extract MySQL tarball
# tar xf mysql-8.0.34-linux-glibc2.28-x86_64.tar.gz -C /usr/local/mysql --strip-components=1

# Create MySQL data directory
mkdir -p /usr/local/mysql/data

# Set ownership for MySQL directory
chown -R mysql:mysql /usr/local/mysql

# Create MySQL configuration file
cat <<EOF > /usr/local/mysql/my.cnf
[mysqld]
basedir = /usr/local/mysql
datadir = /usr/local/mysql/data
socket = /tmp/mysql.sock
user = mysql
bind-address = 0.0.0.0
port = 3306
pid-file = /usr/local/mysql/data/mysqld.pid

### general log
general-log = 1
general-log-file = /usr/local/mysql/data/general.log

### error log
log-error = /usr/local/mysql/data/error.log

skip-grant-tables

server-id = 1
binlog_format = mixed
log_bin = mysql-bin

slow_launch_time = 5
### slow query log
slow_query_log = TRUE
slow_query_log_file = /usr/local/mysql/data/mysql-slow-query.log

log_bin_trust_function_creators = 1
skip_name_resolve

max_allowed_packet = 1000M
sync_binlog = 1

sql_mode = "STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION"
EOF
