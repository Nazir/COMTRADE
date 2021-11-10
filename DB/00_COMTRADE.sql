/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Create a project environment "COMTRADE"
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

DROP DATABASE IF EXISTS COMTRADE WITH (FORCE);
CREATE DATABASE COMTRADE WITH TEMPLATE minidb OWNER role_owner;

/*
 * Connecting to the created datbase
 * \c COMTRADE
 */
\connect COMTRADE

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
\i group.sql
\i cfg.sql
\i dat.sql
\i oscillogram.sql

\i group__cfg.sql

/*
 * Constraints
 */
\i group.CONSTRAINTS.sql
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
\i group.TRIGGERS.sql
\i cfg.TRIGGERS.sql
\i dat.TRIGGERS.sql
\i oscillogram.TRIGGERS.sql

/*
 * Functions
 */
\i group.FUNCTIONS.sql
\i cfg.FUNCTIONS.sql
\i dat.FUNCTIONS.sql
\i oscillogram.FUNCTIONS.sql

/*
 * Full Text Search (FTS)
 */


/*
 * Views
 */
\i group.VIEW.sql
\i cfg.VIEW.sql
\i dat.VIEW.sql
\i oscillogram.VIEW.sql

/*
 * Rules for views
 */
\i group.VIEW.RULE.INS.sql
\i group.VIEW.RULE.UPD.sql
\i group.VIEW.RULE.DEL.sql

\i cfg.VIEW.RULE.INS.sql
\i cfg.VIEW.RULE.UPD.sql
\i cfg.VIEW.RULE.DEL.sql

\i dat.VIEW.RULE.INS.sql
\i dat.VIEW.RULE.UPD.sql
\i dat.VIEW.RULE.DEL.sql

/*
 * Security
 */
\i 91_Security.sql

/*
 * Filling data
 */
\i 99_Data.sql

RESET ROLE;
