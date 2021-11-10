@echo all

SET host=127.0.0.1
SET dbname=postgres
SET username=dev

SET dbname=comtrade

SET filepath=%~dp0

SET name=test1.cfg
SET filename=test1.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"

SET name=test1.dat
SET filename=test1.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"


SET name=test2.cfg
SET filename=test2.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"

SET name=test2.dat
SET filename=test2.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"


SET name=test3.cfg
SET filename=test3.cfg
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.cfg SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"

SET name=test3.dat
SET filename=test3.dat
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on --file=%filepath%%filename%.DATA.sql
psql --host=%host% --dbname=%dbname% --username=%username% --set=ON_ERROR_STOP=on -c "UPDATE COMTRADE.dat SET file_name='%filepath%%filename%', file_content = convert_from(pg_read_binary_file('%filepath%%filename%'), 'WIN866')::text WHERE name LIKE '%name%';"
