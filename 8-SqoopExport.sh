:'
	Create table in Hive 
	
	create table daily_revenue as
	select order_date, sum(order_item_subtotal) daily_revenue
	from orders join order_items 
	on order_id = order_item_order_id
	where order_date like '2013-07%'
	group by order_date;

	Create table with same structure to accept data coming from hive/HDFS via sqoop

	create table daily_revenue(
		order_date varchar(30),
		revenue float
	);
'

# Use sqoop export 

# Please see the name of database (database to which we are going to perform write operation)
# In import case we always performs a read operation on sql db.

sqoop export \
--connect jdbc:mysql://quickstart.cloudera/hive_export \
--username root \
--password cloudera \
--table daily_revenue \
--export-dir /user/hive/warehouse/hive_retail_db.db/daily_revenue \
--input-fields-terminated-by '\001'


:'
	create table order_status as
	select order_id, sum(order_item_subtotal) total, order_status 
	from orders join order_items
	on order_id = order_item_order_id
	where order_status = 'COMPLETE'
	group by order_id, order_status;
'

sqoop export \
--connect jdbc:mysql://quickstart.cloudera:3306/hive_export \
--username root \
--password cloudera \
--table order_status \
--export-dir /user/hive/warehouse/hive_retail_db.db/order_status \
--input-fields-terminated-by '\001'


# In case you target table is having column order different than the sorce table
# then add --columns col1,col2..... 
# Here order for the columns should be from source table and names for the columns should be from target table.

:'
MySQL table:
create table order_status_total(
    order_status varchar(30),
    order_id  int(11),
    total double
);
'

sqoop export \
--connect jdbc:mysql://quickstart.cloudera/hive_export \
--username root \
--password cloudera \
--export-dir /user/hive/warehouse/hive_retail_db.db/order_status \
--table order_status_total \
--columns order_id,total,order_status \
--input-fields-terminated-by '\001' \



:'

insert into table daily_revenue
	select order_date, sum(order_item_subtotal) daily_revenue
	from orders join order_items 
	on order_id = order_item_order_id
	where order_date like '2013-08%'
	group by order_date;

'


sqoop export \
--connect jdbc:mysql://quickstart.cloudera/hive_export \
--username root \
--password cloudera \
--table daily_revenue \
--export-dir /user/hive/warehouse/hive_retail_db.db/daily_revenue \
--update-key order-date \
--input-fields-terminated-by '\001';

sqoop export \
--connect jdbc:mysql://quickstart.cloudera/hive_export \
--username root \
--password cloudera \
--export-dir /user/hive/warehouse/hive_retail_db.db/order_status \
--table order_status_total \
--update-key order-date \
--input-fields-terminated-by '\001'








