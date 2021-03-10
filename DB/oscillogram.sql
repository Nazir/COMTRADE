/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.oscillogram"
 * Oscillogram
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.oscillogram;
CREATE TABLE IF NOT EXISTS COMTRADE.oscillogram (
  id              mini.dm_id      -- ID (Identifier)
, id_dat          mini.dm_id      -- ID Dat
, channel_a_an    mini.dm_integer -- are the analog channel data values separated by commas until data for all analog channels are displayed. Non-critical, numeric (integer or real), minimum length = 1 character, maximum length = 13 characters, minimum value = -3.4028235E38, maximum value = 3.4028235E38. Missing analog values must be represented by data separators immediately following each other with no spaces (null fields).
, num             mini.dm_integer -- Sample number. Critical, integer, numeric, minimum length = 1 character, maximum length = 10 characters, minimum value = 1, maximum value = 9999999999.
, time            mini.dm_integer -- Time stamp. Non-critical if nrates and samp variables in .CFG file are nonzero, critical if nrates and samp variables in .CFG file are zero. Integer, numeric, minimum length = 1 character, maximum length = 10 characters. Base unit of time is microseconds (µs). The elapsed time from the first data sample in a data file to the sample marked by any time stamp field is the product of the time stamp and the time multiplier in the configuration file (timestamp * timemult) in microseconds.
, analogue_signal mini.dm_float   --
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
COMMENT ON TABLE COMTRADE.oscillogram IS 'Oscillogram';
COMMENT ON COLUMN COMTRADE.oscillogram.id IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.oscillogram.id_dat IS 'ID Dat';
COMMENT ON COLUMN COMTRADE.oscillogram.channel_a_an IS 'The analog channel data values separated by commas until data for all analog channels are displayed. Non-critical, numeric (integer or real), minimum length = 1 character, maximum length = 13 characters, minimum value = -3.4028235E38, maximum value = 3.4028235E38. Missing analog values must be represented by data separators immediately following each other with no spaces (null fields).';
COMMENT ON COLUMN COMTRADE.oscillogram.num IS 'Sample number. Critical, integer, numeric, minimum length = 1 character, maximum length = 10 characters, minimum value = 1, maximum value = 9999999999.';
COMMENT ON COLUMN COMTRADE.oscillogram.time IS 'Time stamp. Non-critical if nrates and samp variables in .CFG file are nonzero, critical if nrates and samp variables in .CFG file are zero. Integer, numeric, minimum length = 1 character, maximum length = 10 characters. Base unit of time is microseconds (µs). The elapsed time from the first data sample in a data file to the sample marked by any time stamp field is the product of the time stamp and the time multiplier in the configuration file (timestamp * timemult) in microseconds.';
COMMENT ON COLUMN COMTRADE.oscillogram.analogue_signal IS '';

/*
 * Filling oscillograma for table "COMTRADE.oscillogram"
 */
-- \i oscillogram.oscillogramA.sql

RESET ROLE;
