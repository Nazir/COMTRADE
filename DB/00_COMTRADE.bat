@echo all

SET host=127.0.0.1
SET dbname=postgres
SET username=dev

DEL 00_COMTRADE.log
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=00_COMTRADE.sql --log-file=00_COMTRADE.log

SET dbname=comtrade

SET filepath=%~dp0

SET encoding=UTF8
SET name=COMTRADE
SET filename=config.DATA.prod.json
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE sys.config SET attributes = convert_from(pg_read_binary_file('%filepath%%filename%'), 'UTF8')::json WHERE name LIKE '%name%';"

SET encoding=WIN1251
SET name=test1.ascii.cfg
SET filename=test1.ascii.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), '%encoding%') WHERE name LIKE '%name%';"

SET name=test1.ascii.dat
SET filename=test1.ascii.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = pg_read_binary_file('%filepath%%filename%') WHERE name LIKE '%name%';"


SET encoding=UTF8
SET name=test1.binary.cfg
SET filename=test1.binary.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), '%encoding%') WHERE name LIKE '%name%';"

SET name=test1.binary.dat
SET filename=test1.binary.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --log-file=00_COMTRADE.log -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = pg_read_binary_file('%filepath%%filename%') WHERE name LIKE '%name%';"
