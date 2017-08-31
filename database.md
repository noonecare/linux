### mysql

- [index](https://www.tutorialspoint.com/mysql/mysql-indexes.htm)
- [事务 Transaction](https://www.tutorialspoint.com/mysql/mysql-transactions.htm)
- 中文编码
    最佳实践，建数据库，建表，建立连接时都指明编码为 utf8 就不会有问题。
    ```shell
    # 指明 数据库 的编码为 utf8
    CREATE DATABASE IF NOT EXISTS my_db default charset utf8 COLLATE utf8_general_ci;
    # 指明 表 的编码为 utf8
    create table my_table (name varchar(20) not null default '')type=myisam default charset utf8;
    ```

    ```python
    # 特意指明 charset 为 utf8, 这样就不会有中文乱码的问题
    db = pymysql.connect(host="10.136.7.81", user='datascience', password="d1a2t3a4science!#", charset="utf8")
    # prepare a cursor object using cursor() method
    cursor = db.cursor()
    ```

- grant and revoke， 特殊的 file 权限
    ```shell
    # 把 data_base_1 数据库的所有权限，赋予以任意方式访问的用户 wangmeng, wangmeng 的 密码为 123456
    grant all privileges on data_base_1.* to wangmeng@'%' identified by "123456";
    # 把 data_base_2.table_1 表的所有权限，赋予以 localhost 访问的用户 wangmeng, wangmeng 可以免密码登录
    grant all privileges on data_base_2.table_1 to wangmeng@'localhost';
    # 把 data_base_2.table_2 表的只读权限，赋予以 任意 访问的用户 wangmeng, wangmeng 可以免密码登录
    grant read on data_base_2.table_2 to wangmeng@'%';
    # revoke 是剥夺权限，用法和 grant 基本一样，除了把 to 改成 from
    revoke read on data_base_2.table_2 from wangmeng@'%';
    # 要让更改生效需要执行 flush
    flush privileges;

    # file 权限不包括在 all 权限中，而且 file 权限是全局权限，就是说对于所有数据库和表都有效
    # 赋予 以 localhost 方式登录的用户 wangmeng file 权限，有了file 权限可以执行 load data local infile 命令
    grant file to wangmeng@'localhsot';
    ```
- [更改 mysql 保存数据的目录（磁盘）](https://www.digitalocean.com/community/tutorials/how-to-change-a-mysql-data-directory-to-a-new-location-on-centos-7)
- 数据库迁移 mysqldump
    ```shell
    # mysqldump 会生成 sql 文件， 执行这个 sql 文件，就能重建数据库或者表
    # 把 test 数据库写进 test.dump 文件
    mysqldump -uroot -p123 test > test.dump
    # 从 test.dump 中生成 test 数据库
    mysql -uroot -p123 < test.dump
    ```
- 乐观锁悲观锁