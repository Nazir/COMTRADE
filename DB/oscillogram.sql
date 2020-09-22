/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.oscillogram"
 * oscillogram
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.oscillogram;
CREATE TABLE IF NOT EXISTS COMTRADE.oscillogram (
  id               mini.dm_id      -- ID (Identifier)
, id_dat           mini.dm_id      -- ID Dat
, num              mini.dm_integer -- 
, time             mini.dm_integer -- 
, analogue_signals mini.dm_float[] -- 
, discrete_signals mini.dm_bit[]   -- 
) WITHOUT OIDS;

/*
 * Create system columns in table
 */
SELECT mini.fc_add_system_columns('COMTRADE', 'oscillogram');

/*
 * Sequences
 */
-- DROP SEQUENCE IF EXISTS COMTRADE.oscillogram_id_seq;
CREATE SEQUENCE IF NOT EXISTS COMTRADE.oscillogram_id_seq;
ALTER TABLE IF EXISTS COMTRADE.oscillogram ALTER COLUMN id SET DEFAULT nextval('COMTRADE.oscillogram_id_seq');

/*
 * Constraints
 */
-- \i oscillogram.CONSTRAINTS.sql

/*
 * Indexes
 */
-- \i oscillogram.INDEXES.sql

/*
 * Triggers
 */
-- \i oscillogram.TRIGGERS.sql

/*
 * Security
 */
ALTER TABLE IF EXISTS COMTRADE.oscillogram OWNER TO role_owner;
GRANT ALL ON COMTRADE.oscillogram TO role_owner;
-- GRANT SELECT, INSERT, UPoscillogramE, DELETE, REFERENCES ON COMTRADE.oscillogram TO role_superadmin;
-- GRANT SELECT, INSERT, UPoscillogramE, DELETE, REFERENCES ON COMTRADE.oscillogram TO role_admin;
-- GRANT SELECT, INSERT, UPoscillogramE, DELETE, REFERENCES ON COMTRADE.oscillogram TO role_expert;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_moderator;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_dispatcher;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_supervisor;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_manager;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_user;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_read;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO role_guest;
-- GRANT SELECT, REFERENCES ON COMTRADE.oscillogram TO PUBLIC;
/*
 * Columns security
 */
-- REVOKE INSERT(hits), UPoscillogramE(hits) ON COMTRADE.oscillogram FROM GROUP role_guest;
-- GRANT UPoscillogramE(hits) ON COMTRADE.oscillogram TO role_guest;
/*
 * Sequences security
 */
ALTER SEQUENCE IF EXISTS COMTRADE.oscillogram_id_seq OWNER TO role_owner;
-- ALTER SEQUENCE IF EXISTS COMTRADE.oscillogram_id_seq OWNED BY NONE;
ALTER SEQUENCE IF EXISTS COMTRADE.oscillogram_id_seq OWNED BY COMTRADE.oscillogram.id;
GRANT ALL ON SEQUENCE COMTRADE.oscillogram_id_seq TO role_owner;

/*
 * Comments
 */
COMMENT ON TABLE COMTRADE.oscillogram                   IS 'Oscillogram';
COMMENT ON COLUMN COMTRADE.oscillogram.id               IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.oscillogram.id_dat           IS 'ID Dat';
COMMENT ON COLUMN COMTRADE.oscillogram.num              IS '';
COMMENT ON COLUMN COMTRADE.oscillogram.time             IS '';
COMMENT ON COLUMN COMTRADE.oscillogram.analogue_signals IS '';
COMMENT ON COLUMN COMTRADE.oscillogram.discrete_signals IS '';

/*
 * Filling oscillograma for table "COMTRADE.oscillogram"
 */
-- \i oscillogram.oscillogramA.sql

RESET ROLE;
