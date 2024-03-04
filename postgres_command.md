# Postgres Cheatsheet

## Cài đặt

##### Ubuntu
http://www.postgresql.org/download/linux/ubuntu/
https://help.ubuntu.com/community/PostgreSQL
``` shell
sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ wily-pgdg main" > \
  /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5

sudo su - postgres
psql
```

##### Truy cập kết nối database
http://www.postgresql.org/docs/current/static/app-psql.html
```sql
psql

psql -U <username> -d <database> -h <hostname>

psql --username=<username> --dbname=<database> --host=<hostname>
```

##### disconnect
```sql
\q
\!
```

##### clear the screen
```sql
(CTRL + L)
```

##### Hiển thị thông tin
```sql
\conninfo
```

##### Cấu hình

http://www.postgresql.org/docs/current/static/runtime-config.html

```shell
sudo nano $(locate -l 1 main/postgresql.conf)
sudo service postgresql restart
```

##### debug logs
```shell
# print the last 24 lines of the debug log
sudo tail -24 $(find /var/log/postgresql -name 'postgresql-*-main.log')
```
<br/><br/><br/>

##### Xem version hiện tại.
```
SHOW SERVER_VERSION;
```

##### Xem trạng thái hiện tại.
```sql
\conninfo
```

##### Xem các biến môi trường
```sql
SHOW ALL;
```

##### Xem danh sách users.
```sql
SELECT rolname FROM pg_roles;
```

##### Xem user hiện tại.
```sql
SELECT current_user;
```

##### Xem các quyền của user.
```
\du
```

##### Xem tất cả databases đang có trên hệ thống.
```sql
\l
```

##### Xem database hiện tại.
```sql
SELECT current_database();
```

##### Xem tất cả table của database.
```sql
\dt
```

##### Danh sách functions
```sql
\df <schema>
```
<br/><br/><br/>





## Databases

##### Danh sách databasees
```sql
\l
```

##### Kết nối đến database
```sql
\c <database_name>
```

##### Xem database hiện tại
```sql
SELECT current_database();
```

##### Tạo database
http://www.postgresql.org/docs/current/static/sql-createdatabase.html
```sql
CREATE DATABASE <database_name> WITH OWNER <username>;
```
##### Xoá database
http://www.postgresql.org/docs/current/static/sql-dropdatabase.html
```sql
DROP DATABASE IF EXISTS <database_name>;
```

##### Đổi tên database
http://www.postgresql.org/docs/current/static/sql-alterdatabase.html
```sql
ALTER DATABASE <old_name> RENAME TO <new_name>;
```
<br/><br/><br/>




## Users

##### Danh sách roles
```sql
SELECT rolname FROM pg_roles;
```

##### Tạo user
http://www.postgresql.org/docs/current/static/sql-createuser.html
```sql
CREATE USER <user_name> WITH PASSWORD '<password>';
```

##### Xoá user
http://www.postgresql.org/docs/current/static/sql-dropuser.html
```sql
DROP USER IF EXISTS <user_name>;
```

##### Set password cho user
http://www.postgresql.org/docs/current/static/sql-alterrole.html
```sql
ALTER ROLE <user_name> WITH PASSWORD '<password>';
```
<br/><br/><br/>





## Permissions

##### Truy cập với vai trò là user
```shell
sudo su - postgres
psql
```

##### Cấp tất cả các quyền trên database
http://www.postgresql.org/docs/current/static/sql-grant.html
```sql
GRANT ALL PRIVILEGES ON DATABASE <db_name> TO <user_name>;
```

##### Cấp quyền kết nối trên database
```sql
GRANT CONNECT ON DATABASE <db_name> TO <user_name>;
```

##### Cấp quyền trên schema
```sql
GRANT USAGE ON SCHEMA public TO <user_name>;
```

##### Cấp quyền cho các functions
```sql
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO <user_name>;
```

##### Cấp quyền để select, update, insert, delete trên tất cả tables
```sql
GRANT SELECT, UPDATE, INSERT ON ALL TABLES IN SCHEMA public TO <user_name>;
```

##### Cấp quyền trên một table
```sql
GRANT SELECT, UPDATE, INSERT ON <table_name> TO <user_name>;
```

##### Cấp quyền select trên một table
```sql
GRANT SELECT ON ALL TABLES IN SCHEMA public TO <user_name>;
```
<br/><br/><br/>





## Schema

#####  Danh sách schemas
```sql
\dn

SELECT schema_name FROM information_schema.schemata;

SELECT nspname FROM pg_catalog.pg_namespace;
```

#####  Tạo schema
http://www.postgresql.org/docs/current/static/sql-createschema.html
```sql
CREATE SCHEMA IF NOT EXISTS <schema_name>;
```

#####  Xoá schema
http://www.postgresql.org/docs/current/static/sql-dropschema.html
```sql
DROP SCHEMA IF EXISTS <schema_name> CASCADE;
```
<br/><br/><br/>





## Tables

##### Xem danh sách tables trong database hiện tại.
```sql
\dt

SELECT table_schema,table_name FROM information_schema.tables ORDER BY table_schema,table_name;
```

##### Danh sách tables trên hệ thống.
```sql
\dt *.*.

SELECT * FROM pg_catalog.pg_tables
```

##### Danh sách table schema
```sql
\d <table_name>
\d+ <table_name>

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name = '<table_name>';
```

##### Tạo table
http://www.postgresql.org/docs/current/static/sql-createtable.html
```sql
CREATE TABLE <table_name>(
  <column_name> <column_type>,
  <column_name> <column_type>
);
```

##### Tạo table, với một auto-incrementing primary key
```sql
CREATE TABLE <table_name> (
  <column_name> SERIAL PRIMARY KEY
);
```

##### Xoá table
http://www.postgresql.org/docs/current/static/sql-droptable.html
```sql
DROP TABLE IF EXISTS <table_name> CASCADE;
```
<br/><br/><br/>





## Columns

##### Thêm column
http://www.postgresql.org/docs/current/static/sql-altertable.html
```sql
ALTER TABLE <table_name> IF EXISTS
ADD <column_name> <data_type> [<constraints>];
```

##### Cập nhật column
```sql
ALTER TABLE <table_name> IF EXISTS
ALTER <column_name> TYPE <data_type> [<constraints>];
```

##### Xoá column
```sql
ALTER TABLE <table_name> IF EXISTS
DROP <column_name>;
```

##### Cập nhật column thành một auto-incrementing primary key
```sql
ALTER TABLE <table_name>
ADD COLUMN <column_name> SERIAL PRIMARY KEY;
```

##### Chèn vào 1 bảng với một auto-incrementing primary key
```sql
INSERT INTO <table_name>
VALUES (DEFAULT, <value1>);


INSERT INTO <table_name> (<column1_name>,<column2_name>)
VALUES ( <value1>,<value2> );
```
<br/><br/><br/>





## Data

##### Lấy tất cả data của một table.
http://www.postgresql.org/docs/current/static/sql-select.html
```sql
SELECT * FROM <table_name>;
```

##### Lấy ra 1 hàng của table.
```sql
SELECT * FROM <table_name> LIMIT 1;
```

##### Truy vấn với điều kiện
```sql
SELECT * FROM <table_name> WHERE <column_name> = <value>;
```

##### Chèn data
http://www.postgresql.org/docs/current/static/sql-insert.html
```sql
INSERT INTO <table_name> VALUES( <value_1>, <value_2> );
```

##### Cập nhật data
http://www.postgresql.org/docs/current/static/sql-update.html
```sql
UPDATE <table_name>
SET <column_1> = <value_1>, <column_2> = <value_2>
WHERE <column_1> = <value>;
```

##### Xoá tất cả data của table
http://www.postgresql.org/docs/current/static/sql-delete.html
```sql
DELETE FROM <table_name>;
```

##### Xoá data với điều kiện
```sql
DELETE FROM <table_name>
WHERE <column_name> = <value>;
```
<br/><br/><br/>





## Scripting

##### run local script, on remote host
http://www.postgresql.org/docs/current/static/app-psql.html
```shell
psql -U <username> -d <database> -h <host> -f <local_file>

psql --username=<username> --dbname=<database> --host=<host> --file=<local_file>
```

##### backup database data gồm tất cả mọi thứ.
http://www.postgresql.org/docs/current/static/app-pgdump.html
```shell
pg_dump <database_name>

pg_dump <database_name>
```

##### backup database chỉ mình data
```shell
pg_dump -a <database_name>

pg_dump --data-only <database_name>
```

##### backup database chỉ lấy schema
```shell
pg_dump -s <database_name>

pg_dump --schema-only <database_name>
```

##### restore database data
http://www.postgresql.org/docs/current/static/app-pgrestore.html
```shell
pg_restore -d <database_name> -a <file_pathway>

pg_restore --dbname=<database_name> --data-only <file_pathway>
```

##### restore database schema
```shell
pg_restore -d <database_name> -s <file_pathway>

pg_restore --dbname=<database_name> --schema-only <file_pathway>
```

##### export table vào file csv
http://www.postgresql.org/docs/current/static/sql-copy.html
```sql
\copy <table_name> TO '<file_path>' CSV
```

##### export table, các columns chỉ định vào file csv.
```sql
\copy <table_name>(<column_1>,<column_1>,<column_1>) TO '<file_path>' CSV
```

##### Import csv vào table
http://www.postgresql.org/docs/current/static/sql-copy.html
```sql
\copy <table_name> FROM '<file_path>' CSV
```

##### import CSV vào table với các column chỉ định
```sql
\copy <table_name>(<column_1>,<column_1>,<column_1>) FROM '<file_path>' CSV
```
<br/><br/><br/>





## Debugging

http://www.postgresql.org/docs/current/static/using-explain.html

http://www.postgresql.org/docs/current/static/runtime-config-logging.html
<br/><br/><br/>





## Tài liệu
http://www.tutorialspoint.com/postgresql/postgresql_constraints.htm
