/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security: "COMTRADE.oscillogram"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Table security
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

RESET ROLE;
