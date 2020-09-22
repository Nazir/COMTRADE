@echo all

SET host=127.0.0.1
SET dbname=postgres
SET username=dev

DEL 00_COMTRADE.log
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=00_COMTRADE.sql --log-file=00_COMTRADE.log

SET dbname=comtrade

SET filepath=%~dp0

SET name=COMTRADE
SET filename=config.DATA.prod.json
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE sys.config SET attributes = convert_from(pg_read_binary_file('%filepath%%filename%'), 'UTF8')::json WHERE name LIKE '%name%';"

SET name=test.cfg
SET filename=test.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"

SET name=test.dat
SET filename=test.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"
