/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data for table "sys.config"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

BEGIN;

-- TRUNCATE TABLE sys.config;
-- DELETE FROM sys.config;

DO $BODY$
DECLARE
    id_app_var sys.application.id%TYPE;
BEGIN
    SELECT id FROM sys.application WHERE name LIKE 'COMTRADE' INTO id_app_var LIMIT 1;

    /*
     * Configuration: Production
     */
    INSERT INTO sys.config(
      id         -- ID (Identifier)
    , id_app     -- ID Приложения
    , debug      -- Configuration for debugging
    , name       -- Name (e.g. domain name for a website)
    , attributes -- Attributes

    , _deleted
    ) VALUES (
      DEFAULT
    , id_app_var
    , FALSE
    , 'COMTRADE'
    -- , convert_from(pg_read_binary_file('config.DATA.prod.json'), 'UTF8')::jsonb
    , '{}'
    , FALSE)
    ON CONFLICT (name) DO UPDATE SET
      id_app = EXCLUDED.id_app,
      debug = EXCLUDED.debug,
      name = EXCLUDED.name,
      attributes = EXCLUDED.attributes,
      _deleted = EXCLUDED._deleted
    ;

    -- SELECT * FROM sys.config;

END $BODY$;

COMMIT;

RESET ROLE;