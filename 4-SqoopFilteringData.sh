:'
If you want to filter the data i.e. want data from specific range only then you can make use of 
(  --boundary-query your_query)
'

# Here are the 2 ways 

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table order_items \
--target-dir /sqoop/import/ \
--delete-target-dir \
--boundary-query 'select min(order_item_id), max(order_item_id) from order_items where order_item_id > 99999'

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table order_items \
--target-dir /sqoop/import/ \
--delete-target-dir \
--boundary-query 'select 100000, 172198'

# -------------------------------------------------------------------------------------------------------------------------