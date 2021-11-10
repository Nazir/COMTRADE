/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security: "COMTRADE.dat"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Table security
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

RESET ROLE;
