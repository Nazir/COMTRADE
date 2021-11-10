/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Constraints for table "COMTRADE.group"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Primary key for table "COMTRADE.group"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.group DROP CONSTRAINT IF EXISTS pk_group;
-- ALTER TABLE IF EXISTS COMTRADE.group ADD CONSTRAINT pk_group PRIMARY KEY (id);
SELECT mini.fc_add_constraint('COMTRADE', 'group');

/*
 * Unique for table "COMTRADE.group"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.group DROP CONSTRAINT IF EXISTS unq_group;
-- ALTER TABLE IF EXISTS COMTRADE.group ADD CONSTRAINT unq_group UNIQUE (id_app, name);
SELECT mini.fc_add_constraint('COMTRADE', 'group', 'unq_group', 'UNIQUE', 'id_app, name');

/*
 * Foreign key for table "COMTRADE.group" to table "sys.application"
 */
ALTER TABLE IF EXISTS COMTRADE.group DROP CONSTRAINT IF EXISTS fk_group_id_app;
ALTER TABLE IF EXISTS COMTRADE.group
  ADD CONSTRAINT fk_group_id_app FOREIGN KEY (id_app)
      REFERENCES sys.application (id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE RESTRICT;

RESET ROLE;
