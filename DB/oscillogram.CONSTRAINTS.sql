/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Constraints for table "COMTRADE.oscillogram"
 * oscillogram
 * Осциллограмма
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Primary key for table "COMTRADE.oscillogram"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.oscillogram DROP CONSTRAINT IF EXISTS pk_oscillogram;
-- ALTER TABLE IF EXISTS COMTRADE.oscillogram ADD CONSTRAINT pk_oscillogram PRIMARY KEY (id);
SELECT mini.fc_add_constraint('COMTRADE', 'oscillogram');

/*
 * Unique for table "COMTRADE.oscillogram"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.oscillogram DROP CONSTRAINT IF EXISTS unq_oscillogram;
-- ALTER TABLE IF EXISTS COMTRADE.oscillogram ADD CONSTRAINT unq_oscillogram UNIQUE (id_dat, num);
SELECT mini.fc_add_constraint('COMTRADE', 'oscillogram', 'unq_oscillogram', 'UNIQUE', 'id_dat, num');

/*
 * Foreign key for table "COMTRADE.oscillogram" to table "COMTRADE.dat"
 */
ALTER TABLE IF EXISTS COMTRADE.oscillogram DROP CONSTRAINT IF EXISTS fk_oscillogram_id_dat;
ALTER TABLE IF EXISTS COMTRADE.oscillogram
  ADD CONSTRAINT fk_oscillogram_id_dat FOREIGN KEY (id_dat)
      REFERENCES COMTRADE.dat (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;

RESET ROLE;
