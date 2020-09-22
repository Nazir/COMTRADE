/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Group roles
 * Создание групповых ролей
 */

-- SET CLIENT_ENCODING TO 'UTF8';

-- SET SESSION ROLE role_dev;

-- /*
--  * Group role "role_lab"
--  * Кладовщик. Сотрудник лаборатории
--  * Inherits: "role_superadmin", "role_api"
--  */
-- DO $$
-- BEGIN
--    -- DROP ROLE IF EXISTS role_lab;
--    IF NOT EXISTS (SELECT * FROM pg_catalog.pg_roles WHERE rolname = 'role_lab') THEN
--       CREATE ROLE role_lab NOLOGIN;
--    END IF;
-- END $$;
-- ALTER ROLE role_lab RESET ALL;
-- ALTER ROLE role_lab NOLOGIN;
-- ALTER ROLE role_lab CONNECTION LIMIT 10000000;
-- GRANT role_user TO role_lab;
-- COMMENT ON ROLE role_lab IS 'Сотрудник лаборатории';

-- RESET ROLE;
