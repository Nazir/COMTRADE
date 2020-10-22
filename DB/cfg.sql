/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Table: "COMTRADE.cfg"
 * A file with the configuration (*.cfg)
 *
 * IEEE Standard Common Format for Transient Data Exchange (COMTRADE) for Power Systems
 * IEEE Std C37.111-1999 (Revision of IEEE Std C37.111-1991)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- DROP TABLE IF EXISTS COMTRADE.cfg;
CREATE TABLE IF NOT EXISTS COMTRADE.cfg (
  id               mini.dm_id          -- ID (Identifier)
, id_app           mini.dm_id          -- ID Application
, name             mini.dm_long_string -- Name
, file_name        mini.dm_long_string -- File name
, file_content     mini.dm_text        -- File contents
, file_content_md5 mini.dm_md5         -- MD5 hash of file contents

-- 5.3.1 Station name, identification, and revision year
-- station_name,rec_dev_id,rev_year<CR/LF>
, station_name   mini.dm_varchar_64  -- Name of the substation location. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters.
, rec_dev_id     mini.dm_varchar_64  -- Identification number or name of the recording device. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters
, rev_year       mini.dm_year CHECK (rev_year IN (1991, 1999))       -- Year of the standard revision, e.g. 1999, that identifies the COMTRADE file version. Critical, numeric, minimum length = 4 characters, maximum length = 4 characters. This field shall identify that the file structure differs from the file structure requirement in the original IEEE Std C37.111-1991 COMTRADE Standard. Absence of the field or an empty field is interpreted to mean that the file complies with the 1991 version of the standard.

-- 5.3.2 Number and type of channels
-- TT,##A,##D<CR/LF>
, tt             mini.dm_integer CHECK (tt BETWEEN 1 AND 999999)    -- Total number of channels. Critical, numeric, integer, minimum length = 1 character, maximum length = 7 characters, minimum value = 1, maximum value = 999999, TT must equal the sum of ##A and ##D below.
, nn_a           mini.dm_integer CHECK (nn_a BETWEEN 0 AND 999999)   -- Number of analog channels followed by identifier A. Critical, alphanumeric, minimum length = 2 characters, maximum length = 7 characters, minimum value = 0A, maximum value = 999999A.
, nn_d           mini.dm_integer CHECK (nn_d BETWEEN 0 AND 999999)    -- Number of status channels followed by identifier D. Critical, alphanumeric, minimum length = 2 characters, maximum length = 7 characters, minimum value = 0D, maximum value = 999999D.

-- 5.3.3 Analog channel information
-- An,ch_id,ph,ccbm,uu,a,b,skew,min,max,primary,secondary,PS<CR/LF>
, channels_a_an           mini.dm_integer[]     -- Analog channel index number. Critical, numeric, integer, minimum length = 1 character, maximum length = 6 characters, minimum value = 1, maximum value = 999999. Leading zeroes or spaces are not required. Sequential counter from 1 to total number of analog channels (##A) without regard to recording device channel number.
, channels_a_ch_id        mini.dm_varchar_64[]  -- Channel identifer. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters.
, channels_a_ph           mini.dm_varchar_2[]   -- Channel phase identification. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 2 characters.
, channels_a_ccbm         mini.dm_integer[]     -- Circuit component being monitored. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters.
, channels_a_uu           mini.dm_varchar_32[]  -- Channel units (e.g., kV, V, kA, A). Critical, alphabetical, minimum length = 1 character, maximum length = 32 characters. Units of physical quantities shall use the standard nomenclature or abbreviations specified in IEEE Std 260.1-1993 [B4] or IEEE Std 280-1985 (R1996) [B5], if such standard nomenclature exists. Numerical multipliers shall not be included. Standard multiples such as k (thousands), m (one thousandth), M (millions), etc. may be used.
, channels_a_а            mini.dm_float[]       -- Channel multiplier. Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters. Standard floating point notation may be used (Kreyszig [B7]).
, channels_a_b            mini.dm_float[]       -- Channel offset adder. Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters. Standard floating point notation may be used (Kreyszig [B7]).
, channels_a_skew         mini.dm_float[]       -- Channel time skew (in µs) from start of sample period. Non-critical, real number, minimum length = 1 character, maximum length = 32 characters. Standard ßoating point notation may be used (Kreyszig [B7]). The field provides information on time differences between sampling of channels within the sample period of a record. For example, in an eight-channel device with one A/D converter without synchronized sample and hold running at a 1 ms sample rate, the Þrst sample will be, at the time, represented by the timestamp; the sample times for successive channels within each sample period could be up to 125µs behind each other. In such cases the skew for successive channels will be 0; 125; 250; 375...; etc.
, channels_a_min          mini.dm_integer[]     -- Range minimum data value (lower limit of possible data value range) for data values of this channel. Critical, integer, numeric, minimum length = 1 character, maximum length = 6 characters, minimum value = -99999, maximum value = 99999 (in binary data files the range of data values is limited to -32767 to 32767).
, channels_a_max          mini.dm_integer[]     -- Range maximum data value (upper limit of possible data value range) for data values of this channel. Critical, integer, numeric, minimum length = 1 character, maximum length = 6 characters, minimum value = -99999, maximum value = 99999 (in binary data Þles the range of data values is limited to -32767 to 32767).
, channels_a_primary      mini.dm_float[]       -- Channel voltage or current transformer ratio primary factor. Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters.
, channels_a_secondary    mini.dm_float[]       -- Channel voltage or current transformer ratio secondary factor. Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters.
, channels_a_ps           mini.dm_char_1[]      -- Primary or secondary data scaling identifier. The character specifies whether the value received from the channel conversion factor equation ax+b will represent a primary (P) or secondary (S) value. Critical, alphabetical, minimum length = 1 character, maximum length = 1 character. The only valid characters are: p,P,s,S.

-- 5.3.4 Status (digital) channel information
-- Dn,ch_id,ph,ccbm,y<CR/LF>
, channels_d_dn           mini.dm_integer[]    -- Status channel index number. Critical, integer, numeric, minimum length = 1 character, maximum length = 6 characters, minimum value = 1, maximum value = 999999. Leading zeroes or spaces are not required. Sequential counter ranging from 1 to total number of status channels (##D) without regard to recording device channel number.
, channels_d_ch_id        mini.dm_varchar_64[] -- Channel name. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters.
, channels_d_ph           mini.dm_varchar_2[]  -- Channel phase identification. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 2 characters.
, channels_d_ccbm         mini.dm_varchar_64[] -- Circuit component being monitored. Non-critical, alphanumeric, minimum length = 0 characters, maximum length = 64 characters.
, channels_d_y            mini.dm_bit[]        -- Normal state of status channel (applies to status channels only), that is, the state of the input when the primary apparatus is in the steady state "in service" condition. Critical, integer, numeric, minimum length = 1 character, maximum length = 1 character, the only valid values are 0 or 1.

-- 5.3.5 Line frequency
-- lf<CR/LF>
, lf                      mini.dm_float        -- Nominal line frequency in Hz (for example, 50, 60, 33.333). Non-critical, real, numeric, minimum length = 0 characters, maximum length = 32 characters. Standard floating point notation may be used (Kreyszig [B7]).

-- 5.3.6 Sampling rate information
-- This section contains information on the sample rates and the number of data samples at a given rate.
, nrates         mini.dm_integer   -- Number of sampling rates in the data file. Critical, integer, numeric, minimum length = 1 character, maximum length = 3 characters, minimum value = 0, maximum value = 999.
, samp           mini.dm_float[]   -- Sample rate in Hertz (Hz). Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters. Standard floating point notation may be used (Kreyszig [B7]).
, endsamp        mini.dm_integer[] -- Last sample number at sample rate. Critical, integer, numeric, minimum length = 1 character, maximum length = 10 characters, minimum value = 1, maximum value = 9999999999.

-- 5.3.7 Date/time stamps
-- dd/mm/yyyy,hh:mm:ss.ssssss<CR/LF>
-- dd/mm/yyyy,hh:mm:ss.ssssss<CR/LF>
, datetime_first mini.dm_timestamp -- Time of the first data value in the data file.
, datetime_start mini.dm_timestamp -- Time of the trigger point.

-- 5.3.8 Data file type
-- ft <CR/LF>
, ft             mini.dm_boolean   -- File type. Critical, alphabetical, non-case sensitive, minimum length = 5 characters, maximum length = 6 characters. Only text allowed = ASCII or ascii, BINARY or binary. ASCII = TRUE или BINARY = FALSE

-- 5.3.9 Time stamp multiplication factor
-- timemult<CR/LF>
, timemult       mini.dm_float     -- Multiplication factor for the time differential (timestamp) field in the data file. Critical, real, numeric, minimum length = 1 character, maximum length = 32 characters. Standard floating point notation may be used (Kreyszig [B7]).
) WITHOUT OIDS;

/*
 * Create system columns in table
 */
SELECT mini.fc_add_system_columns('COMTRADE', 'cfg');

/*
 * Sequences
 */
-- DROP SEQUENCE IF EXISTS COMTRADE.cfg_id_seq;
CREATE SEQUENCE IF NOT EXISTS COMTRADE.cfg_id_seq;
ALTER TABLE IF EXISTS COMTRADE.cfg ALTER COLUMN id SET DEFAULT nextval('COMTRADE.cfg_id_seq');

/*
 * Constraints
 */
-- \i cfg.CONSTRAINTS.sql

/*
 * Indexes
 */
-- \i cfg.INDEXES.sql

/*
 * Triggers
 */
-- \i cfg.TRIGGERS.sql

/*
 * Security
 */
ALTER TABLE IF EXISTS COMTRADE.cfg OWNER TO role_owner;
GRANT ALL ON COMTRADE.cfg TO role_owner;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.cfg TO role_superadmin;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.cfg TO role_admin;
-- GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON COMTRADE.cfg TO role_expert;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_moderator;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_dispatcher;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_supervisor;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_manager;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_user;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_read;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO role_guest;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO PUBLIC;
/*
 * Columns security
 */
-- REVOKE INSERT(hits), UPDATE(hits) ON COMTRADE.cfg FROM GROUP role_guest;
-- GRANT UPDATE(hits) ON COMTRADE.cfg TO role_guest;
/*
 * Sequences security
 */
ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNER TO role_owner;
-- ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNED BY NONE;
ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNED BY COMTRADE.cfg.id;
GRANT ALL ON SEQUENCE COMTRADE.cfg_id_seq TO role_owner;

/*
 * Comments
 */
COMMENT ON TABLE COMTRADE.cfg                   IS 'A file with the configuration (*.cfg)';
COMMENT ON COLUMN COMTRADE.cfg.id               IS 'ID (Identifier)';
COMMENT ON COLUMN COMTRADE.cfg.id_app           IS 'ID Application';
COMMENT ON COLUMN COMTRADE.cfg.name             IS 'Name';
COMMENT ON COLUMN COMTRADE.cfg.file_name        IS 'File name';
COMMENT ON COLUMN COMTRADE.cfg.file_content     IS 'File contents';
COMMENT ON COLUMN COMTRADE.cfg.file_content_md5 IS 'MD5 hash of file contents';

COMMENT ON COLUMN COMTRADE.cfg.station_name     IS 'Name of the substation location';
COMMENT ON COLUMN COMTRADE.cfg.rec_dev_id       IS 'Identification number or name of the recording device';
COMMENT ON COLUMN COMTRADE.cfg.rev_year         IS 'Year of the standard revision, e.g. 1999, that identifies the COMTRADE file version';

COMMENT ON COLUMN COMTRADE.cfg.tt               IS 'Total number of channels';
COMMENT ON COLUMN COMTRADE.cfg.nn_a             IS 'Number of analog channels followed by identifier A';
COMMENT ON COLUMN COMTRADE.cfg.nn_d             IS 'Number of status channels followed by identifier D';

COMMENT ON COLUMN COMTRADE.cfg.channels_a_an        IS 'Analog channel index number';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_ch_id     IS 'Channel identifer';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_ph        IS 'Channel phase identification';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_ccbm      IS 'Circuit component being monitored';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_uu        IS 'Channel units (e.g., kV, V, kA, A)';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_а         IS 'Channel multiplier';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_b         IS 'Channel offset adder';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_skew      IS 'Channel time skew (in µs) from start of sample period';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_min       IS 'Range minimum data value (lower limit of possible data value range) for data values of this channel';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_max       IS 'Range maximum data value (upper limit of possible data value range) for data values of this channel';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_primary   IS 'Channel voltage or current transformer ratio primary factor';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_secondary IS 'Channel voltage or current transformer ratio secondary factor';
COMMENT ON COLUMN COMTRADE.cfg.channels_a_ps        IS 'Primary or secondary data scaling identifier';


COMMENT ON COLUMN COMTRADE.cfg.channels_d_dn        IS 'Status channel index number';
COMMENT ON COLUMN COMTRADE.cfg.channels_d_ch_id     IS 'Channel name';
COMMENT ON COLUMN COMTRADE.cfg.channels_d_ph        IS 'Channel phase identification';
COMMENT ON COLUMN COMTRADE.cfg.channels_d_ccbm      IS 'Circuit component being monitored';
COMMENT ON COLUMN COMTRADE.cfg.channels_d_y         IS 'Normal state of status channel (applies to status channels only), that is, the state of the input when the primary apparatus is in the steady state "in service" condition';


COMMENT ON COLUMN COMTRADE.cfg.lf                   IS 'Nominal line frequency in Hz (for example, 50, 60, 33.333)';

COMMENT ON COLUMN COMTRADE.cfg.nrates               IS 'Number of sampling rates in the data file';
COMMENT ON COLUMN COMTRADE.cfg.samp                 IS 'Sample rate in Hertz (Hz)';
COMMENT ON COLUMN COMTRADE.cfg.endsamp              IS 'Last sample number at sample rate';

COMMENT ON COLUMN COMTRADE.cfg.datetime_first       IS 'Time of the first data value in the data file';
COMMENT ON COLUMN COMTRADE.cfg.datetime_start       IS 'Time of the trigger point';

COMMENT ON COLUMN COMTRADE.cfg.ft                   IS 'File type. ASCII = TRUE или BINARY = FALSE';


COMMENT ON COLUMN COMTRADE.cfg.timemult             IS 'Multiplication factor for the time differential (timestamp) field in the data file';

/*
 * Filling data for table "COMTRADE.cfg"
 */
-- \i cfg.DATA.sql

RESET ROLE;
