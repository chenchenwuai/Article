## 忘记 Mysql root账户密码如何修改

打开命令行界面 然后输入打开 *my.cnf* 配置文件的命令
```bash
    vi /etc/my.cnf 

```

在 [mysqld] 的段中加上一句：skip-grant-tables 

```bash
    [mysqld] 
    datadir=/var/lib/mysql 
    socket=/var/lib/mysql/mysql.sock 
    skip-grant-tables 
```

然后保存重启mysql 

```bash
    // mariadb
    systemctl restart mariadb
```

然后登录

```bash
    mysql -uroot -p
    // 然后直接回车，要求输入密码的时候也直接回车
```

登录之后选择mysql这个数据库然后修改用户密码

```bash
    use mysql;  --选择要操作的数据库
    UPDATE user SET password = password('vbox_12306') WHERE User = 'root'; -- vbox_12306 为密码
```
回车之后显示下面的表示成功
```bash
    Query OK, 1 row affected (0.00 sec)
    Rows matched: 1  Changed: 1  Warnings: 0
```
如果提示下面的错误
```bash
    The MySQL server is running with the --skip-grant-tables option so it cannot execute this statement
```
则运行一下刷新权限的命令
```bash
    flush privileges;
```
然后在执行上面的 update 命令，执行成功之后再次执行 flush 刷新权限命令

此时退出mysql 再次打开 *my.cnf* 配置文件 把已开始加入的 skip-grant-tables 删除 :wq 保存 ，然后重启mysql
```bash
    systemctl restart mariadb
```
然后安正常步骤登录mysql。


    
