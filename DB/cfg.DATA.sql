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
     * cfg: test1.ascii.cfg
     */
    INSERT INTO COMTRADE.cfg(
      id           -- ID (Identifier)
    , id_app       -- ID Application
    , name         -- Name
    , file_name    -- File name
    -- , file_content -- File contents

    , _deleted     -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_app_var -- ID Application
    , 'test1.ascii.cfg' -- Name
    , 'test1.ascii.cfg' -- File name
    -- , convert_from(pg_read_binary_file('test1.ascii.cfg'), 'CP1251')::text -- File contents

    , FALSE)
    ON CONFLICT DO NOTHING
    -- ON CONFLICT (name) DO UPDATE SET
    --   id_app = EXCLUDED.id_app,             -- ID Application
    --   name = EXCLUDED.name,                 -- Name
    --   file_name = EXCLUDED.file_name,       -- File name
    --   file_content = EXCLUDED.file_content, -- File contents

    --   _deleted = EXCLUDED._deleted          -- The record is deleted?
    ;

    /*
     * cfg: test1.binary.cfg
     */
    INSERT INTO COMTRADE.cfg(
      id           -- ID (Identifier)
    , id_app       -- ID Application
    , name         -- Name
    , file_name    -- File name
    -- , file_content -- File contents

    , _deleted     -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_app_var -- ID Application
    , 'test1.binary.cfg' -- Name
    , 'test1.binary.cfg' -- File name
    -- , convert_from(pg_read_binary_file('test1.binary.cfg'), 'UTF8')::text -- File contents

    , FALSE)
    ON CONFLICT DO NOTHING
    -- ON CONFLICT (name) DO UPDATE SET
    --   id_app = EXCLUDED.id_app,             -- ID Application
    --   name = EXCLUDED.name,                 -- Name
    --   file_name = EXCLUDED.file_name,       -- File name
    --   file_content = EXCLUDED.file_content, -- File contents

    --   _deleted = EXCLUDED._deleted          -- The record is deleted?
    ;

    -- SELECT * FROM COMTRADE.cfg;
END $BODY$;

COMMIT;

RESET ROLE;