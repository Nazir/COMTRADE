/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data for table "COMTRADE.dat"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_dev;

BEGIN;

-- TRUNCATE TABLE COMTRADE.dat;
-- DELETE FROM COMTRADE.dat;
-- ALTER SEQUENCE COMTRADE.dat_id_seq RESTART WITH 1;

DO $BODY$
DECLARE
    id_cfg_var COMTRADE.dat.id%TYPE;
BEGIN
    SELECT id FROM COMTRADE.cfg WHERE name LIKE 'test1.ascii.cfg' INTO id_cfg_var LIMIT 1;

    /*
     * dat: test.dat
     */
    INSERT INTO COMTRADE.dat(
      id           -- ID (Identifier)
    , id_cfg       -- ID Cfg
    , name         -- Name
    , file_name    -- File name
    -- , file_content -- File contents

    , _deleted     -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_cfg_var -- ID Cfg
    , 'test1.ascii.dat' -- Name
    , 'test1.ascii.dat' -- File name
    -- , pg_read_binary_file('test.dat') -- File contents

    , FALSE)
    ON CONFLICT DO NOTHING
    -- ON CONFLICT (name) DO UPDATE SET
    --   id_cfg = EXCLUDED.id_cfg,             -- ID Cfg
    --   name = EXCLUDED.name,                 -- Name
    --   file_name = EXCLUDED.file_name,       -- File name
    --   file_content = EXCLUDED.file_content, -- File contents

    --   _deleted = EXCLUDED._deleted          -- The record is deleted?
    ;

    SELECT id FROM COMTRADE.cfg WHERE name LIKE 'test1.binary.cfg' INTO id_cfg_var LIMIT 1;
    /*
     * dat: test1.binary.dat
     */
    INSERT INTO COMTRADE.dat(
      id           -- ID (Identifier)
    , id_cfg       -- ID Cfg
    , name         -- Name
    , file_name    -- File name
    -- , file_content -- File contents

    , _deleted     -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_cfg_var -- ID Cfg
    , 'test1.binary.dat' -- Name
    , 'test1.binary.dat' -- File name
    -- , pg_read_binary_file('test1.binary.dat') -- File contents

    , FALSE)
    ON CONFLICT DO NOTHING
    -- ON CONFLICT (name) DO UPDATE SET
    --   id_cfg = EXCLUDED.id_cfg,             -- ID Cfg
    --   name = EXCLUDED.name,                 -- Name
    --   file_name = EXCLUDED.file_name,       -- File name
    --   file_content = EXCLUDED.file_content, -- File contents

    --   _deleted = EXCLUDED._deleted          -- The record is deleted?
    ;

    -- SELECT * FROM COMTRADE.dat;

END $BODY$;

COMMIT;

RESET ROLE;