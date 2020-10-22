/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data for table "sys.application"
 * Application
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

BEGIN;

-- TRUNCATE TABLE sys.application;
-- DELETE FROM sys.application;
DO $BODY$
DECLARE
  -- id_user_var sys.user.id%TYPE;
  id_parent_var mini.dm_id;
  id_application_type_var sys.application.id_application_type%TYPE;
  id_publication_status_var sys.publication_status.id%TYPE;
BEGIN
  SELECT id FROM sys.application WHERE name LIKE 'App' INTO id_parent_var LIMIT 1;
  -- SELECT id FROM sys.user WHERE username LIKE 'dev' INTO id_user_var LIMIT 1;
  SELECT id FROM sys.application_type WHERE name LIKE 'Web service' INTO id_application_type_var LIMIT 1;
  SELECT id FROM sys.publication_status WHERE id = 1 INTO id_publication_status_var LIMIT 1;

  INSERT INTO sys.application(id, id_parent, id_application_type, id_publication_status, name, title, note, _deleted) VALUES
  (DEFAULT, id_parent_var, id_application_type_var, id_publication_status_var, 'COMTRADE', 'COMTRADE', NULL, FALSE)
  ON CONFLICT (name) DO UPDATE SET
    name = EXCLUDED.name,
    title = EXCLUDED.title,
    note = EXCLUDED.note,
    _deleted = EXCLUDED._deleted
;
END $BODY$;

COMMIT;

RESET ROLE;
