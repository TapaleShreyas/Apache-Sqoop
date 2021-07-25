:'
	USE OF DELIMITERS IN SQOOP
	- Use ( --fields-terminated-by fields_seperator_in double_quotes ) syntax to specify field seperator
	- Use ( --lines-terminated-by fields_seperator_in double_quotes ) syntax to specify line seperator'

:'
	TREAT NULL VALUES
	- For string column use ( -- null-string string-to_replace_null) e.g. --null-string "empty field"
	- For numeric column use ( --null-non-string numeric_value_to_replace_null ) e.g.  --null-non-string '-1''


# --------------------------------------------------------------------------------------------------------------------------------------------------------

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/hr_db \
--username root \
--password cloudera \
--table departments \
--warehouse-dir /sqoop/import/ \
--fields-terminated-by ":" \
--lines-terminated-by '\n' \
--delete-target-dir \
--null-non-string '-1'

# --------------------------------------------------------------------------------------------------------------------------------------------------------

sqoop import \
--connect jdbc:mysql://quickstart.cloudera/hr_db \
--username root \
--password cloudera \
--table employees \
--warehouse-dir /sqoop/import/ \
--delete-target-dir \
--fields-terminated-by "\0001" \
--lines-terminated-by '\n' \
--null-non-string '-1111' \
--null-string "empty field"

# --------------------------------------------------------------------------------------------------------------------------------------------------------

