### SIMPLE SQOOP COMMANDS ###

sqoop list-databases \
--connect jdbc:mysql://192.168.100.137:3306 \
--username root \
--password cloudera
    
sqoop-list-tables \
--connect jdbc:mysql://192.168.100.137/retail_db \
--username root \
--password cloudera

sqoop eval \
--connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
--username root \
--password cloudera \
--query "show tables"

sqoop eval \
--connect jdbc:mysql://192.168.100.137/retail_db \
--username root \
--password cloudera \
--query "select * from order_items limit 10"

sqoop eval \
--connect jdbc:mysql://192.168.100.137/retail_db \
--username root \
--password cloudera \
--query "create table dummy(str VARCHAR(20))"

sqoop eval \
--connect jdbc:mysql://192.168.100.137/retail_db \
--username root \
--password cloudera \
--query "insert into dummy values('Shreyas')"

sqoop eval \
--connect jdbc:mysql://192.168.100.137/retail_db \
--username root \
--password cloudera \
--query "select * from dummy"

sqoop eval \
--connect jdbc:mysql://192.168.100.139/retail_db \
--username root \
--password cloudera \
--query "describe order_items"