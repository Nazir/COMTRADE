#!/bin/bash
host=127.0.0.1
dbname=comtrade
username=dev
# password=

rm -f 00_COMTRADE.log
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --file=00_COMTRADE.sql --log-file=00_COMTRADE.log


dbname=comtrade

filepath=${PWD}\

name=COMTRADE
filename=config.DATA.prod.json
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE sys.config SET attributes = convert_from(pg_read_binary_file('$filepath$filename'), 'UTF8')::json WHERE name LIKE '$name';"

name=test.cfg
filename=test.cfg
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), 'WIN866')::text WHERE name LIKE '$name';"

name=test.dat
filename=test.dat
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), 'WIN866')::text WHERE name LIKE '$name';"

name=test_binary.cfg
filename=test_binary.cfg
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), 'WIN866')::text WHERE name LIKE '$name';"

name=test_binary.dat
filename=test_binary.dat
psql --host=$host --dbname=$dbname --username=$username --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='$filepath$filename', file_content = convert_from(pg_read_binary_file('$filepath$filename'), 'WIN866')::text WHERE name LIKE '$name';"
