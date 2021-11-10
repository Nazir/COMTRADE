/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Filling data
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

-- \i user_role.DATA.sql

\i application.DATA.sql
\i config.DATA.sql

\i group.DATA.sql
\i cfg.DATA.sql
\i dat.DATA.sql
\i oscillogram.DATA.sql

\i section.DATA.sql
\i search.DATA.sql

RESET ROLE;
