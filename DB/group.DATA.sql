/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data for table "COMTRADE.group"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_dev;

BEGIN;

-- TRUNCATE TABLE COMTRADE.group;
-- DELETE FROM COMTRADE.group;
-- ALTER SEQUENCE COMTRADE.group_id_seq RESTART WITH 1;

DO $BODY$
DECLARE
    id_app_var sys.application.id%TYPE;
BEGIN
    SELECT id FROM sys.application WHERE name LIKE 'COMTRADE' INTO id_app_var LIMIT 1;

    /*
     * group: test
     */
    INSERT INTO COMTRADE.group(
      id     -- ID (Identifier)
    , id_app -- ID Application
    , name   -- Name

    , _deleted -- The record is deleted?
    ) VALUES (
      DEFAULT    -- ID (Identifier)
    , id_app_var -- ID Application
    , 'test' -- Name

    , FALSE -- The record is deleted?
    ) ON CONFLICT DO NOTHING;

    -- SELECT * FROM COMTRADE.group;
END $BODY$;

COMMIT;

RESET ROLE;