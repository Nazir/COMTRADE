/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Group roles
 */

-- SET CLIENT_ENCODING TO 'UTF8';

-- SET SESSION ROLE role_dev;

-- /*
--  * Group role "role_engineer"
--  * Engineer
--  * Inherits: "role_superadmin", "role_api"
--  */
-- DO $$
-- BEGIN
--    -- DROP ROLE IF EXISTS role_engineer;
--    IF NOT EXISTS (SELECT * FROM pg_catalog.pg_roles WHERE rolname = 'role_engineer') THEN
--       CREATE ROLE role_engineer NOLOGIN;
--    END IF;
-- END $$;
-- ALTER ROLE role_engineer RESET ALL;
-- ALTER ROLE role_engineer NOLOGIN;
-- ALTER ROLE role_engineer CONNECTION LIMIT 10000000;
-- GRANT role_user TO role_engineer;
-- COMMENT ON ROLE role_engineer IS 'Engineer';

-- RESET ROLE;
