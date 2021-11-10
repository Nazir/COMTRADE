/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Schema: "COMTRADE"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

CREATE SCHEMA IF NOT EXISTS COMTRADE AUTHORIZATION role_owner;
COMMENT ON SCHEMA COMTRADE IS 'COMTRADE';

/*
 * Security
 */

/*
 * Grants in schema COMTRADE to PUBLIC
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO PUBLIC;

/*
 * Grants in schema COMTRADE to role_owner
 */
-- GRANT ALL ON SCHEMA COMTRADE TO role_owner;
-- GRANT ALL ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_owner;
-- GRANT ALL ON ALL TABLES IN SCHEMA COMTRADE TO role_owner;

/*
 * Grants in schema COMTRADE to role_superadmin
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_superadmin;
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_superadmin;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_superadmin;

/*
 * Grants in schema COMTRADE to role_admin
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_admin;
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_admin;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_admin;

/*
 * Grants in schema COMTRADE to role_user
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_user; 
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_user;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_user;

/*
 * Grants in schema COMTRADE to role_read
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_read; 
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_read;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_read;

/*
 * Grants in schema COMTRADE to role_supervisor
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_supervisor; 
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_supervisor;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_supervisor;

/*
 * Grants in schema COMTRADE to role_moderator
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_moderator; 
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_moderator;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_moderator;

/*
 * Grants in schema COMTRADE to role_expert
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_expert;
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_expert;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_expert;

/*
 * Grants in schema COMTRADE to role_storekeeper
 */
-- GRANT USAGE ON SCHEMA COMTRADE TO role_storekeeper;
-- GRANT SELECT ON ALL SEQUENCES IN SCHEMA COMTRADE TO role_storekeeper;
-- GRANT SELECT ON ALL TABLES IN SCHEMA COMTRADE TO role_storekeeper;

RESET ROLE;
