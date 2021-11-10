/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Security
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- https://www.postgresql.org/docs/current/sql-reassign-owned.html
-- REASSIGN OWNED BY postgres TO dev;

-- GRANT ALL ON DATABASE COMTRADE TO dev WITH GRANT OPTION;

/*
 * Access DB
 */
-- REVOKE CONNECT ON DATABASE COMTRADE FROM PUBLIC;
GRANT CONNECT ON DATABASE COMTRADE TO role_guest;

/*
 * Access schema
 */
-- REVOKE ALL ON SCHEMA public FROM PUBLIC;
-- GRANT USAGE ON SCHEMA public TO role_guest;

/*
 * Access tables
 */
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
-- GRANT ALL ON ALL TABLES IN SCHEMA public TO role_;
-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO role_guest;
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO role_;

/*
 * Group roles
 */


/*
 * User
 */


/*
 * Tables
 */
\i group.SEC.sql
\i cfg.SEC.sql
\i dat.SEC.sql
\i oscillogram.SEC.sql

\i group__cfg.SEC.sql

/*
 * Views
 */


/*
 * Functions
 */


/*
 * Sequences
 */


RESET ROLE;
