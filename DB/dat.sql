/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.dat"
 * The data file (*.dat)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.dat;
CREATE TABLE IF NOT EXISTS COMTRADE.dat (
  id           mini.dm_id          -- ID (Identifier)
, id_cfg       mini.dm_id          -- ID Cfg
, name         mini.dm_long_string -- Name
, file_name    mini.dm_long_string -- File name
, file_content mini.dm_text        -- File contents
-- 6.3 ASCII data fle format
-- n, timestamp, A1, A2,...Ak, D1, D2,...Dm
, n            integer[]           -- Sample number. Critical, integer, numeric, minimum length = 1 character, maximum length = 10 characters, minimum value = 1, maximum value = 9999999999.
, timestamp    integer[]           -- Time stamp. Non-critical if nrates and samp variables in .CFG file are nonzero, critical if nrates and samp variables in .CFG file are zero. Integer, numeric, minimum length = 1 character, maximum length = 10 characters. Base unit of time is microseconds (µs). The elapsed time from the first data sample in a data file to the sample marked by any time stamp field is the product of the time stamp and the time multiplier in the configuration file (timestamp * timemult) in microseconds.
, channel_a    integer[][]         -- are the analog channel data values separated by commas until data for all analog channels are displayed. Non-critical, integer, numeric, minimum length = 1 character, maximum length = 6 characters, minimum value = -99999, maximum value = 99998. Missing analog values must be represented by placing the value 99999 in the field.
, channel_d    integer[][]         -- are the status channel data values separated by commas until data for all status channels are displayed. Non-critical, integer, numeric, minimum length = 1 character, maximum length = 1 character. The only valid values are 0 or 1. No provision is made for tagging missing status data and in such cases the field must be set to 1 or to 0. The last data value in a sample shall be terminated with carriage return/line feed.
) WITHOUT OIDS;

/*
 * Create system columns in table
 */
SELECT mini.fc_add_system_columns('COMTRADE', 'dat');

/*
 * Sequences
 */
-- DROP SEQUENCE IF EXISTS COMTRADE.dat_id_seq;
CREATE SEQUENCE IF NOT EXISTS COMTRADE.dat_id_seq;
ALTER TABLE IF EXISTS COMTRADE.dat ALTER COLUMN id SET DEFAULT nextval('COMTRADE.dat_id_seq');

/*
 * Constraints
 */
-- \i dat.CONSTRAINTS.sql

/*
 * Indexes
 */
-- \i dat.INDEXES.sql

/*
 * Triggers
 */
-- \i dat.TRIGGERS.sql

/*
 * Security
 */
ALTER TABLE IF EXISTS COMTRADE.dat OWNER TO role_owner;
GRANT ALL ON COMTRADE.dat TO role_owner;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.dat TO role_superadmin;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.dat TO role_admin;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.dat TO role_expert;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_moderator;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_dispatcher;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_supervisor;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_manager;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_user;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_read;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO role_guest;
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO PUBLIC;
/*
 * Columns security
 */
-- REVOKE INSERT(hits), UPDATE(hits) ON COMTRADE.dat FROM GROUP role_guest;
-- GRANT UPDATE(hits) ON COMTRADE.dat TO role_guest;
/*
 * Sequences security
 */
ALTER SEQUENCE IF EXISTS COMTRADE.dat_id_seq OWNER TO role_owner;
-- ALTER SEQUENCE IF EXISTS COMTRADE.dat_id_seq OWNED BY NONE;
ALTER SEQUENCE IF EXISTS COMTRADE.dat_id_seq OWNED BY COMTRADE.dat.id;
GRANT ALL ON SEQUENCE COMTRADE.dat_id_seq TO role_owner;

/*
 * Comments
 */
COMMENT ON TABLE COMTRADE.dat               IS 'The data file (*.dat)';
COMMENT ON COLUMN COMTRADE.dat.id           IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.dat.id_cfg       IS 'ID Cfg';
COMMENT ON COLUMN COMTRADE.dat.name         IS 'Name';
COMMENT ON COLUMN COMTRADE.dat.file_name    IS 'File name';
COMMENT ON COLUMN COMTRADE.dat.file_content IS 'File content';
COMMENT ON COLUMN COMTRADE.dat.n            IS 'Sample number';
COMMENT ON COLUMN COMTRADE.dat.timestamp    IS 'Time stamp';
COMMENT ON COLUMN COMTRADE.dat.channel_a    IS 'Analog channel data values';
COMMENT ON COLUMN COMTRADE.dat.channel_d    IS 'Status channel data values';

/*
 * Filling data for table "COMTRADE.dat"
 */
-- \i dat.DATA.sql

RESET ROLE;
