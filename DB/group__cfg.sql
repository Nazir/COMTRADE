/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.group__cfg"
 * Group - Cfg
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.group;
CREATE TABLE IF NOT EXISTS COMTRADE.group__cfg (
  id_group mini.dm_id -- ID Group
, id_cfg   mini.dm_id -- ID Cfg
) WITHOUT OIDS;

/*
 * Primary key for table "COMTRADE.group__cfg"
 */
-- -- ALTER TABLE IF EXISTS COMTRADE.group__cfg DROP CONSTRAINT IF EXISTS pk_cfg;
-- ALTER TABLE IF EXISTS COMTRADE.group__cfg ADD CONSTRAINT pk_group__cfg PRIMARY KEY (id_group, id_cfg);
SELECT mini.fc_add_constraint('COMTRADE', 'group__cfg', 'pk_group__cfg', 'PRIMARY KEY', 'id_group, id_cfg');

/*
 * Comments
 */
COMMENT ON TABLE COMTRADE.group__cfg IS 'Group - Cfg';
COMMENT ON COLUMN COMTRADE.group__cfg.id_group IS 'ID Group';
COMMENT ON COLUMN COMTRADE.group__cfg.id_cfg IS 'ID Cfg';

/*
 * Security
 */
-- \i group__cfg.SEC.sql

RESET ROLE;
