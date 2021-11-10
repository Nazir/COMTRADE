/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Constraints for table "COMTRADE.cfg"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Primary key for table "COMTRADE.cfg"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.cfg DROP CONSTRAINT IF EXISTS pk_cfg;
-- ALTER TABLE IF EXISTS COMTRADE.cfg ADD CONSTRAINT pk_cfg PRIMARY KEY (id);
SELECT mini.fc_add_constraint('COMTRADE', 'cfg');

/*
 * Unique for table "COMTRADE.cfg"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.cfg DROP CONSTRAINT IF EXISTS unq_cfg;
-- ALTER TABLE IF EXISTS COMTRADE.cfg ADD CONSTRAINT unq_cfg UNIQUE (id_app, name, file_name, _date_create);
SELECT mini.fc_add_constraint('COMTRADE', 'cfg', 'unq_cfg', 'UNIQUE', 'id_app, name, file_name, _date_create');

/*
 * Foreign key for table "COMTRADE.cfg" to table "sys.application"
 */
ALTER TABLE IF EXISTS COMTRADE.cfg DROP CONSTRAINT IF EXISTS fk_cfg_id_app;
ALTER TABLE IF EXISTS COMTRADE.cfg
  ADD CONSTRAINT fk_cfg_id_app FOREIGN KEY (id_app)
      REFERENCES sys.application (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;

RESET ROLE;
