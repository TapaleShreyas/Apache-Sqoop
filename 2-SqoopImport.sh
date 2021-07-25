# When table name(which is going to import) and directory name in which you want to import table data is same 
# then you can use ( --warehouse-dir directoryName ) in your import syntax.

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items \
--warehouse-dir /sqoop/import/

# -------------------------------------------------------------------------------------------------------------------------

# If you are facing any errors/issues regarding permission/grants then try using below commands #

sudo mysql -u root -
OR
sudo su -
mysql -u root -p

GRANT ALL PRIVILEGES on *.* to 'root'@'192.168.100.139' IDENTIFIED BY 'cloudera';
FLUSH PRIVILEGES;

# -------------------------------------------------------------------------------------------------------------------------

# When directory name and table name are different then use ( --target-dir directoryName ) in syntax #

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items \
--target-dir /sqoop/import/retail_db/order_items

# -------------------------------------------------------------------------------------------------------------------------

# By default number of mappers are 4 , If you want specific number of mappers then you can use 
# ( --num-mappers NoOfMappers ) or  ( --m NoOfMappers )
# ( --delete-target-dir dirName ) deletes if dir is already exists.

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items \
--target-dir /sqoop/import/retail_db/order_items \
--num-mappers 1 \
--delete-target-dir

# -------------------------------------------------------------------------------------------------------------------------

# If target directory already contains data and you want to add tables data to that directory(No overriding)
then you can use ( --append ) in syntax. # 

sqoop import \
--connect jdbc:mysql://192.168.100.139/retail_db \
--username root \
--password cloudera \
--table order_items \
--target-dir /sqoop/import/order_items \
--num-mappers 1 \
--append

# -------------------------------------------------------------------------------------------------------------------------

### By default sqoop uses primary_key column to calculate splits, If you don't have primary key in your table 
### and you want to specify splits on some 'numeric' column then you can use ( --split-by numeric_column_name )
### OR you can specify the splits on column other than primary key column

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items_nopk \
--warehouse-dir /sqoop/import/retail_db/ \
--split-by order_item_id

# -------------------------------------------------------------------------------------------------------------------------

# If your table does not have primary key in that case you 'must' specify number of mappers to one otherwise import will fail #

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items_nopk \
--warehouse-dir /sqoop/import/retail_db/nopk \
--m 1

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items_nopk \
--warehouse-dir /sqoop/import/retail_db/nopk \
--num-mappers 1

-------------------------------------------------------------------------------------------------------------------------

# ( -- autoreset-to-one-mapper ) will check whether your table contains primary key , 
If not then it will set number of mappers to one. #

sqoop import \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items_nopk \
--warehouse-dir /sqoop/import/retail_db/nopk \
--autoreset-to-one-mapper \
--delete-target-dir

# -------------------------------------------------------------------------------------------------------------------------

# Split on column which is not numeric (In another words, Split on string column) #

sqoop import \
-Dorg.apache.sqoop.splitter.allow_text_splitter=true \
--connect jdbc:mysql://192.168.100.139/retail_db \
--username root \
--password cloudera \
--table orders \
--warehouse-dir /sqoop/import/retail_db/split2 \
--split-by order_status \
--direct

sqoop import \
-Dorg.apache.sqoop.splitter.allow_text_splitter=true \
--connect jdbc:mysql://192.168.100.139:3306/retail_db \
--username root \
--password cloudera \
--table order_items_nopk \
--target-dir /sqoop/import/cmdoption \
--split-by order_item_id

# -------------------------------------------------------------------------------------------------------------------------


# SQOOP IMPORT ALL TABLES #

sqoop import-all-tables \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--warehouse-dir /sqoop/import-all/ \
--autoreset-to-one-mapper


# SQOOP EXCLUDE TABLES #

sqoop import-all-tables \
--connect jdbc:mysql://quickstart.cloudera/hr_db \
--username root \
--password cloudera \
--warehouse-dir /sqoop/import/hr_db \
--exclude-tables locations,regions,employees,departments,jobs \
--autoreset-to-one-mapper