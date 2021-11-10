/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security: "COMTRADE.group"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Table security
 */
ALTER TABLE IF EXISTS COMTRADE.group OWNER TO role_owner;
GRANT ALL ON COMTRADE.group TO role_owner;
-- GRANT SELECT, REFERENCES ON COMTRADE.group TO PUBLIC;
/*
 * Columns security
 */
/*
 * Sequences security
 */
ALTER SEQUENCE IF EXISTS COMTRADE.group_id_seq OWNER TO role_owner;
-- ALTER SEQUENCE IF EXISTS COMTRADE.group_id_seq OWNED BY NONE;
ALTER SEQUENCE IF EXISTS COMTRADE.group_id_seq OWNED BY COMTRADE.group.id;
GRANT ALL ON SEQUENCE COMTRADE.group_id_seq TO role_owner;

RESET ROLE;
