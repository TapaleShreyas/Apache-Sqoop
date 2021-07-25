sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--query "select * from orders where \$CONDITIONS and order_date like '2014-%'" \
--target-dir /sqoop/import/orders \
--delete-target-dir \
--split-by order_customer_id

# --------------------------------------------------------------------------------------------------------------------------------------------------------

# Load the data based on some condition and append to existing directory
sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--target-dir /sqoop/import/orders \
--query "select * from orders where \$CONDITIONS and order_date like '2013-12%'" \
--split-by order_status \
--append

# --------------------------------------------------------------------------------------------------------------------------------------------------------

# Where clause in conjuction with table
sqoop import \
--connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
--username root \
--password cloudera \
--target-dir /sqoop/import/orders \
--delete-target-dir \
--table orders \
--where "order_date like '2014-01-%'" 

--------------------------------------------------------------------------------------------------------------------------------------------------------

# Incremental append using argument specific to incremental load
sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir /sqoop/import/orders \
--check-column order_date \
--incremental append \
--last-value '2014-02-28'

# --------------------------------------------------------------------------------------------------------------------------------------------------------

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--where 'order_date like "2013-12-%"' \
--warehouse-dir /sqoop/import/

# --------------------------------------------------------------------------------------------------------------------------------------------------------

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--check-column order_date \
--incremental append \
--last-value '2013-12-28' \
--warehouse-dir /sqoop/import/

# --------------------------------------------------------------------------------------------------------------------------------------------------------