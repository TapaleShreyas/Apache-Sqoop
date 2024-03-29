﻿:'Text File : default plain text file format
AvroData File : Binary Json file format
Parquet File : Columnar file format
Sequence File : Binary file format

- By default number of mappers is 4, it can be changed with –num-mappers
- Split logic will be applied on primary key, if exists
- If primary key does not exists and if we use number of mappers more than 1, then sqoop import will fail
- At that time we can use –split-by to split on a non key column or explicitly set –num-mappers to 1 or use –auto-reset-to-one-mapper
- If the primary key column or the column specified in split-by clause is non numeric type, 
  then we need to use this additional argument 
  -Dorg.apache.sqoop.splitter.allow_text_splitter=true'

# --------------------------------------------------------------------------------------------------------------------------------------------------------

# IMPORT AS SEQUENCE FILE ###

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir /sqoop/import/orders_sequence_file \
--as-sequencefile \
--delete-target-dir \
--num-mappers 8

# --------------------------------------------------------------------------------------------------------------------------------------------------------

# IMPORT AS PARQUET FILE ###

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir /sqoop/import/orders_parquet_file \
--as-parquetfile \
--delete-target-dir \
--m 3

# --------------------------------------------------------------------------------------------------------------------------------------------------------

# IMPORT AS AVRODATA FILE ###

sqoop import \
--connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir /sqoop/import/orders_avro_file \
--as-avrodatafile \
--delete-target-dir \
--autoreset-to-one-mapper

# --------------------------------------------------------------------------------------------------------------------------------------------------------


### If you want to check available compression algorithms
### navigate to 	etc/hadoop/conf --> core-site.xml

# --------------------------------------------------------------------------------------------------------------------------------------------------------

### Enable comression using ( --compress )  #

sqoop import \
--connect jdbc:mysql://quickstart.cloudera:3306/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir /sqoop/import/orders \
--delete-target-dir \
--compress 

--------------------------------------------------------------------------------------------------------------------------------------------------------

### use of compression codec ( --compression-codec name_of_codec )  #

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/retail_db \
--username root \
--password cloudera \
--table orders \
--target-dir sqoop/import/orders_avro_file \
--delete-target-dir \
--compress \
--compression-codec org.apache.hadoop.io.compres.SnappyCodec

# --------------------------------------------------------------------------------------------------------------------------------------------------------
