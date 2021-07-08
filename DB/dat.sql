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
  id               mini.dm_id          -- ID (Identifier)
, id_cfg           mini.dm_id          -- ID Cfg
, name             mini.dm_long_string -- Name
, file_name        mini.dm_long_string -- File name
, file_content     mini.dm_binary_data -- File contents
, file_content_md5 mini.dm_md5         -- MD5 hash of file contents
-- 8.4 ASCII data file format
-- n, timestamp, A1, A2,...Ak, D1, D2,...Dm
, n int8[] -- Sample number. Critical, integer, numeric, minimum length = 1 character, maximum length = 10 characters, minimum value = 1, maximum value = 9999999999.
, timestamp int8[]    -- Time stamp. Non-critical if nrates and samp variables in .CFG file are nonzero, critical if nrates and samp variables in .CFG file are zero. Integer, numeric, minimum length = 1 character, maximum length = 13 characters. Base unit of time is microseconds or nanoseconds depending on the definition of the date/time stamp in the CFG file. The elapsed time from the first data sample in a data file to the sample marked by any time stamp field is the product of the time stamp and the time multiplier in the configuration file (timestamp * timemult) in microseconds. When both the nrates and samp variable information are available and the timestamp information is available? the use of nrates and samp variables is preferred for precise timing.
, channel_a float8[][]     -- are the analog channel data values separated by commas until data for all analog channels are displayed. Non-critical, numeric (integer or real), minimum length = 1 character, maximum length = 13 characters, minimum value = -3.4028235E38, maximum value = 3.4028235E38. Missing analog values must be represented by data separators immediately following each other with no spaces (null fields).
, channel_d int2[][] -- are the status channel data values separated by commas. Non-critical, integer, numeric, minimum length = 1 character, maximum length = 1 character. The only valid values are 0 or 1. No provision is made for tagging missing status data and in such cases the field must be set to 1 or to 0. The last data value in a sample shall be terminated with carriage return/line feed.
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
-- GRANT SELECT, REFERENCES ON COMTRADE.dat TO PUBLIC;
/*
 * Columns security
 */

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
COMMENT ON TABLE COMTRADE.dat IS 'The data file (*.dat)';
COMMENT ON COLUMN COMTRADE.dat.id IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.dat.id_cfg IS 'ID Cfg';
COMMENT ON COLUMN COMTRADE.dat.name IS 'Name';
COMMENT ON COLUMN COMTRADE.dat.file_name IS 'File name';
COMMENT ON COLUMN COMTRADE.dat.file_content IS 'File content';
COMMENT ON COLUMN COMTRADE.dat.file_content_md5 IS 'MD5 hash of file contents';
COMMENT ON COLUMN COMTRADE.dat.n IS 'Sample number';
COMMENT ON COLUMN COMTRADE.dat.timestamp IS 'Time stamp';
COMMENT ON COLUMN COMTRADE.dat.channel_a IS 'Analog channel data values';
COMMENT ON COLUMN COMTRADE.dat.channel_d IS 'Status channel data values';

/*
 * Filling data for table "COMTRADE.dat"
 */
-- \i dat.DATA.sql

RESET ROLE;
