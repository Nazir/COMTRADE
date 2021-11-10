/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.group"
 * Group
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.group;
CREATE TABLE IF NOT EXISTS COMTRADE.group (
  id     mini.dm_id          -- ID (Identifier)
, id_app mini.dm_id          -- ID Application
, name   mini.dm_long_string -- Name
) WITHOUT OIDS;

/*
 * Create system columns in table
 */
SELECT mini.fc_add_system_columns('COMTRADE', 'group');

/*
 * Sequences
 */
-- DROP SEQUENCE IF EXISTS COMTRADE.group_id_seq;
CREATE SEQUENCE IF NOT EXISTS COMTRADE.group_id_seq;
ALTER TABLE IF EXISTS COMTRADE.group ALTER COLUMN id SET DEFAULT nextval('COMTRADE.group_id_seq');

/*
 * Constraints
 */
-- \i group.CONSTRAINTS.sql

/*
 * Indexes
 */
-- \i group.INDEXES.sql

/*
 * Triggers
 */
-- \i group.TRIGGERS.sql

/*
 * Comments
 */
COMMENT ON TABLE COMTRADE.group IS 'Group';
COMMENT ON COLUMN COMTRADE.group.id IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.group.id_app IS 'ID Application';
COMMENT ON COLUMN COMTRADE.group.name IS 'Name';

/*
 * Security
 */
-- \i group.SEC.sql

/*
 * Filling data
 */
-- \i group.DATA.sql

RESET ROLE;
