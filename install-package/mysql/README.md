# MySQL Setup

```
mysqld --defaults-file=/usr/local/mysql/my.cnf --initialize --user=mysql
```
```
cat /usr/local/mysql/data/error.log | grep "A temporary password is generated for root@localhost" | awk '{print $NF}'
```
```
mysqld_safe --defaults-file=/usr/local/mysql/my.cnf &
```

#### MySQL ROOT 패스워드 변경
```
ALTER USER 'root'@'localhost' IDENTIFIED WITH 'caching_sha2_password' BY 'mysqlrootpw1!';
```
```
FLUSH PRIVILEGES;
```
```
mysql -uroot -p'mysqlrootpw1!';
```
