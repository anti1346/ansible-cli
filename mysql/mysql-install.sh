#!/bin/bash

# Change directory to /usr/local/src
cd /usr/local/src

# # Download MySQL tarball
# wget -q https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.34-linux-glibc2.28-x86_64.tar.gz

# # Extract MySQL tarball
# tar xf mysql-8.0.34-linux-glibc2.28-x86_64.tar.gz -C /usr/local/mysql --strip-components=1

# Create MySQL data directory
mkdir -p /usr/local/mysql/data

# Create MySQL configuration file
cat <<EOF > /usr/local/mysql/my.cnf
### my.cnf
[mysqld]
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
socket=/tmp/mysql.sock
user=mysql
bind-address=0.0.0.0
port=3306
pid-file=/usr/local/mysql/data/mysqld.pid

### general log
general-log=TRUE
general-log-file=/usr/local/mysql/data/general.log

### error log
log-error-verbosity=1
log-error=/usr/local/mysql/data/error.log

### slow query log
slow-query-log=TRUE
slow-launch-time=5
slow-query-log-file=/usr/local/mysql/data/slow-query.log

#skip-grant-tables=FALSE
symbolic-links=FALSE
skip-name-resolve=TRUE

server-id=1
binlog-format=ROW
log-bin=/usr/local/mysql/data/mysql-bin
sync-binlog=1
relay-log=/usr/local/mysql/data/relay-log
#relay-log-index=/usr/local/mysql/data/relay-log.index
relay-log-purge=TRUE
expire-logs-days=7
log-slave-updates=TRUE
EOF

# Set ownership for MySQL directory
chown -R mysql:mysql /usr/local/mysql

# Set ENV
echo 'export PATH="/usr/local/mysql/bin:$PATH"' >> /etc/profile

# Set Link
sudo ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
sudo ln -s /usr/local/mysql/bin/mysqlbinlog /usr/bin/mysqlbinlog

