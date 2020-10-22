/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Constraints for table "COMTRADE.dat"
 * The data file (*.dat)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Primary key for table "COMTRADE.dat"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.dat DROP CONSTRAINT IF EXISTS pk_dat;
-- ALTER TABLE IF EXISTS COMTRADE.dat ADD CONSTRAINT pk_dat PRIMARY KEY (id);
SELECT mini.fc_add_constraint('COMTRADE', 'dat');

/*
 * Unique for table "COMTRADE.dat"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.dat DROP CONSTRAINT IF EXISTS unq_dat_name;
-- ALTER TABLE IF EXISTS COMTRADE.dat ADD CONSTRAINT unq_dat_name UNIQUE (id_cfg, name, file_name, _date_create);
SELECT mini.fc_add_constraint('COMTRADE', 'dat', 'unq_dat_name', 'UNIQUE', 'id_cfg, name, file_name, _date_create');

/*
 * Foreign key for table "COMTRADE.dat" to table "COMTRADE.cfg"
 */
ALTER TABLE IF EXISTS COMTRADE.dat DROP CONSTRAINT IF EXISTS fk_dat_id_cfg;
ALTER TABLE IF EXISTS COMTRADE.dat
  ADD CONSTRAINT fk_dat_id_cfg FOREIGN KEY (id_cfg)
      REFERENCES COMTRADE.cfg (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;

RESET ROLE;
