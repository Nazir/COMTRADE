/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security: "COMTRADE.cfg"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Table security
 */
ALTER TABLE IF EXISTS COMTRADE.cfg OWNER TO role_owner;
GRANT ALL ON COMTRADE.cfg TO role_owner;
-- GRANT SELECT, REFERENCES ON COMTRADE.cfg TO PUBLIC;
/*
 * Columns security
 */

/*
 * Sequences security
 */
ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNER TO role_owner;
-- ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNED BY NONE;
ALTER SEQUENCE IF EXISTS COMTRADE.cfg_id_seq OWNED BY COMTRADE.cfg.id;
GRANT ALL ON SEQUENCE COMTRADE.cfg_id_seq TO role_owner;

RESET ROLE;
