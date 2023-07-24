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

