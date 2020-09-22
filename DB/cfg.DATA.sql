/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data for table "COMTRADE.cfg"
 * cfg
 * Файл с конфигурацией (*.cfg)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_dev;

BEGIN;

-- TRUNCATE TABLE COMTRADE.cfg;
-- DELETE FROM COMTRADE.cfg;

DO $BODY$
DECLARE
    id_app_var sys.application.id%TYPE;
BEGIN
    SELECT id FROM sys.application WHERE name LIKE 'COMTRADE' INTO id_app_var LIMIT 1;

    /*
     * cfg: test
     */
    INSERT INTO COMTRADE.cfg(
      id           -- ID (Identifier)
    , id_app       -- ID Application
    , name         -- Наименование
    , file_name    -- Имя файла
    -- , file_content -- Содержимое файла

    , _deleted     -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_app_var -- ID Application
    , 'test.cfg' -- Наименование
    , 'test.cfg' -- Имя файла
    -- , convert_from(pg_read_binary_file('test.cfg'), 'WIN866')::text -- Содержимое файла

    , FALSE)
    ON CONFLICT DO NOTHING
    -- ON CONFLICT (name) DO UPDATE SET
    --   id_app = EXCLUDED.id_app,             -- ID Application
    --   name = EXCLUDED.name,                 -- Наименование
    --   file_name = EXCLUDED.file_name,       -- Имя файла
    --   file_content = EXCLUDED.file_content, -- Содержимое файла

    --   _deleted = EXCLUDED._deleted          -- The record is deleted?
    ;

    -- SELECT * FROM COMTRADE.cfg;

END $BODY$;

COMMIT;

RESET ROLE;