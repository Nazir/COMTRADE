/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security: "COMTRADE.group__cfg"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Table security
 */
ALTER TABLE IF EXISTS COMTRADE.group__cfg OWNER TO role_owner;
GRANT ALL ON COMTRADE.group__cfg TO role_owner;
-- GRANT SELECT, REFERENCES ON COMTRADE.group__cfg TO PUBLIC;
/*
 * Columns security
 */


RESET ROLE;
