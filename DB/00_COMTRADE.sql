/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Create a project environment "COMTRADE"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

DROP DATABASE IF EXISTS comtrade WITH (FORCE);
CREATE DATABASE COMTRADE WITH TEMPLATE minidb OWNER role_owner;

/*
 * Connecting to the created datbase
 * \c COMTRADE
 */
\connect comtrade

/*
 * Group roles
 */
\i 20_Role.sql

/*
 * Schemas
 */
\i 40_Schemas.sql

/*
 * Tables
 */
\i cfg.sql
\i dat.sql
\i oscillogram.sql

/*
 * Constraints
 */
\i cfg.CONSTRAINTS.sql
\i dat.CONSTRAINTS.sql
\i oscillogram.CONSTRAINTS.sql

/*
 * Indexes
 */
\i cfg.INDEXES.sql

/*
 * Triggers
 */
\i cfg.TRIGGERS.sql
\i dat.TRIGGERS.sql
\i oscillogram.TRIGGERS.sql

/*
 * Functions
 */
\i cfg.FUNCTIONS.sql
\i dat.FUNCTIONS.sql
\i oscillogram.FUNCTIONS.sql

/*
 * Full Text Search (FTS)
 */


/*
 * Views
 */
\i cfg.VIEW.sql
\i dat.VIEW.sql
\i oscillogram.VIEW.sql

/*
 * Rules for views
 */
\i cfg.VIEW.RULE.INS.sql
\i cfg.VIEW.RULE.UPD.sql
\i cfg.VIEW.RULE.DEL.sql

\i dat.VIEW.RULE.INS.sql
\i dat.VIEW.RULE.UPD.sql
\i dat.VIEW.RULE.DEL.sql

/*
 * Security
 */


/*
 * Filling data
 */
-- \i user_role.DATA.sql

\i application.DATA.sql
\i config.DATA.sql

\i cfg.DATA.sql
\i dat.DATA.sql
\i oscillogram.DATA.sql

\i section.DATA.sql
\i search.DATA.sql

RESET ROLE;
