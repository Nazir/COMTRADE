#!/bin/bash
host=127.0.0.1
dbname=comtrade
username=dev
# password=

rm -f 00_COMTRADE.log
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --file=00_COMTRADE.sql --log-file=00_COMTRADE.log

dbname=comtrade

filepath=${PWD}\

encoding=UTF8
name=COMTRADE
filename=config.DATA.prod.json
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE sys.config SET attributes = convert_from(pg_read_binary_file('$filepath$filename'), '$encoding')::json WHERE name LIKE '$name';"

encoding=WIN1251
name=test1.ascii.cfg
filename=test1.ascii.cfg
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), '$encoding')::text WHERE name LIKE '$name';"

name=test1.ascii.dat
filename=test1.ascii.dat
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='$filepath$filename', file_content = pg_read_binary_file('$filepath$filename') WHERE name LIKE '$name';"

encoding=UTF8
name=test1.binary.cfg
filename=test1.binary.cfg
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), '$encoding')::text WHERE name LIKE '$name';"

name=test1.binary.dat
filename=test1.binary.dat
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='$filepath$filename', file_content = pg_read_binary_file('$filepath$filename') WHERE name LIKE '$name';"
