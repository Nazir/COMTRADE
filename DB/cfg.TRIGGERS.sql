/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Triggers for table "COMTRADE.cfg"
 * A file with the configuration (*.cfg)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Function trigger: "fc_tr_biu_cfg"
 */
-- DROP FUNCTION IF EXISTS COMTRADE.fc_tr_biu_cfg()
CREATE OR REPLACE FUNCTION COMTRADE.fc_tr_biu_cfg()
  RETURNS TRIGGER AS $BODY$
DECLARE
  get_var boolean;
  file_content_var text;
  line_var text;
  values_var text[];
  value_var text;
  int_a_var int;
  int_d_var int;
  nrates_var int;
  rev_year_var int;
BEGIN
  IF TG_OP IN ('INSERT', 'UPDATE') THEN
    -- RAISE EXCEPTION 'Тест NEW.rec_dev_id="%".', NEW.rec_dev_id;
    get_var = TRUE;
    IF NEW.file_content IS NULL THEN
      get_var = FALSE;
    ELSIF TG_OP = 'UPDATE' THEN
        IF NEW.file_content = OLD.file_content THEN
            get_var = FALSE;
        END IF;
    END IF;
    IF get_var THEN
        NEW.file_content_md5 = md5(NEW.file_content);

        file_content_var = NEW.file_content;

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        values_var = string_to_array(line_var, ',', '');

        -- SELECT unnest(values_var);
        -- FOREACH value_var IN ARRAY values_var LOOP
        --     RAISE NOTICE '%', value_var;
        -- END LOOP;
        -- FOR i IN 1..10 LOOP
        --     -- i will take on the values 1,2,3,4,5,6,7,8,9,10 within the loop
        -- END LOOP;
        NEW.station_name = trim(values_var[1])::text;
        NEW.rec_dev_id = values_var[2]::text;
        NEW.rev_year = NULL;
        rev_year_var = 1991;
        IF array_length(values_var, 1) = 3 THEN
            rev_year_var = values_var[3]::int;
        END IF;
        NEW.rev_year = rev_year_var;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        -- values_var = line_var;
        -- value_var = trim(substring(values_var from 1 for position(',' in values_var) - 1));
        -- NEW.tt = value_var::int;

        values_var = string_to_array(line_var, ',', '');
        NEW.tt = values_var[1]::int;
        int_a_var = rtrim(values_var[2], 'A')::int;
        NEW.nn_a = int_a_var;
        int_d_var = rtrim(values_var[3], 'D')::int;
        NEW.nn_d = int_d_var;

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        NEW.channels_a_an = NULL;
        NEW.channels_a_ch_id = NULL;
        NEW.channels_a_ph = NULL;
        NEW.channels_a_ccbm = NULL;
        NEW.channels_a_uu = NULL;
        NEW.channels_a_а = NULL;
        NEW.channels_a_b = NULL;
        NEW.channels_a_skew = NULL;
        NEW.channels_a_min = NULL;
        NEW.channels_a_max = NULL;
        NEW.channels_a_primary = NULL;
        NEW.channels_a_secondary = NULL;
        NEW.channels_a_ps = NULL;
        -- NEW.channels_a_an = array_append(NEW.channels_a_an::int[], 0::int);

        WHILE NOT int_a_var = 0 LOOP
            line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

            values_var = string_to_array(line_var, ',', '');

            value_var = values_var[1]; 
            IF COALESCE(value_var, '') = '' THEN
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_an = array_append(NEW.channels_a_an::int[], value_var::int);

            value_var = trim(values_var[2]); 
            NEW.channels_a_ch_id = array_append(NEW.channels_a_ch_id::text[], value_var::text);

            value_var = trim(values_var[3]); 
            NEW.channels_a_ph = array_append(NEW.channels_a_ph::text[], value_var::text);

            value_var = trim(values_var[4]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_ccbm = array_append(NEW.channels_a_ccbm::int[], value_var::int);

            value_var = trim(values_var[5]); 
            NEW.channels_a_uu = array_append(NEW.channels_a_uu::text[], value_var::text);

            value_var = trim(values_var[6]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_а = array_append(NEW.channels_a_а::float[], value_var::float);

            value_var = trim(values_var[7]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_b = array_append(NEW.channels_a_b::float[], value_var::float);

            value_var = trim(values_var[8]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_skew = array_append(NEW.channels_a_skew::float[], value_var::float);

            value_var = trim(values_var[9]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_min = array_append(NEW.channels_a_min::int[], value_var::int);

            value_var = trim(values_var[10]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_a_max = array_append(NEW.channels_a_max::int[], value_var::int);

            IF rev_year_var IN (1999) THEN
                value_var = trim(values_var[11]); 
                IF COALESCE(value_var, '') = '' THEN 
                    value_var = '0' || trim(value_var);
                END IF;
                NEW.channels_a_primary = array_append(NEW.channels_a_primary::float[], value_var::float);
                value_var = trim(values_var[12]); 
                IF COALESCE(value_var, '') = '' THEN 
                    value_var = '0' || trim(value_var);
                END IF;
                NEW.channels_a_secondary = array_append(NEW.channels_a_secondary::float[], value_var::float);
                value_var = trim(values_var[13]); 
                IF COALESCE(value_var, '') = '' THEN 
                    value_var = '0' || trim(value_var);
                END IF;
                NEW.channels_a_ps = array_append(NEW.channels_a_ps::text[], value_var::text);
            END IF;

            file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

            int_a_var := int_a_var - 1;
        END LOOP;

        NEW.channels_d_dn = NULL;
        NEW.channels_d_ch_id = NULL;
        NEW.channels_d_ph = NULL;
        NEW.channels_d_ccbm = NULL;
        NEW.channels_d_y = NULL;

        WHILE NOT int_d_var = 0 LOOP
            line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

            values_var = string_to_array(line_var, ',', '');

            value_var = trim(values_var[1]); 
            IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
            END IF;
            NEW.channels_d_dn = array_append(NEW.channels_d_dn::int[], value_var::int);

            value_var = trim(values_var[2]); 
            NEW.channels_d_ch_id = array_append(NEW.channels_d_ch_id::text[], value_var::text);

            IF rev_year_var IN (1991) THEN
                value_var = trim(values_var[3]); 
                NEW.channels_d_y = array_append(NEW.channels_d_y::int[], value_var::int);
            END IF;

            IF rev_year_var IN (1999) THEN
                value_var = trim(values_var[3]); 
                NEW.channels_d_ph = array_append(NEW.channels_d_ph::text[], value_var::text);
                value_var = trim(values_var[4]); 
                NEW.channels_d_ccbm = array_append(NEW.channels_d_ccbm::text[], value_var::text);
                value_var = trim(values_var[7]); 
                NEW.channels_d_y = array_append(NEW.channels_d_y::int[], value_var::int);
            END IF;

            file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

            int_d_var := int_d_var - 1;

        END LOOP;

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        values_var = string_to_array(line_var, ',', '');

        value_var = trim(values_var[1]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        NEW.lf = value_var::float;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        values_var = string_to_array(line_var, ',', '');

        value_var = trim(values_var[1]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        nrates_var = value_var::int;
        NEW.nrates = value_var::int;

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        NEW.samp = NULL;
        NEW.endsamp = NULL;

        WHILE NOT nrates_var = 0 LOOP
            line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
            values_var = string_to_array(line_var, ',', '');

            value_var = trim(values_var[1]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || value_var;
            END IF;
            NEW.samp = array_append(NEW.samp::float[], value_var::float);

            value_var = trim(values_var[2]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.endsamp = array_append(NEW.endsamp::int[], value_var::int);

            file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

            nrates_var := nrates_var - 1;
        END LOOP;

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        -- values_var = string_to_array(line_var, ',', '');

        -- SELECT TO_TIMESTAMP('01/01/07,00:45:13.457000','DD/MM/YY,HH24:MI:SS.US');
        -- value_var = trim(values_var[1]); 
        value_var = line_var; 
        SELECT TO_TIMESTAMP(value_var,'DD/MM/YY,HH24:MI:SS.US') INTO value_var;
        NEW.datetime_first = value_var::timestamp;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        -- values_var = string_to_array(line_var, ',', '');
        -- value_var = trim(values_var[2]); 
        value_var = line_var; 
        SELECT TO_TIMESTAMP(value_var,'DD/MM/YY,HH24:MI:SS.US') INTO value_var;
        NEW.datetime_start = value_var::timestamp;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        values_var = string_to_array(line_var, ',', '');
        value_var = trim(values_var[1]); 
        value_var = upper(trim(COALESCE(value_var, '')));
        NEW.ft = CASE WHEN value_var = 'ASCII' THEN TRUE WHEN value_var = 'BINARY' THEN FALSE ELSE NULL END;

        IF rev_year_var IN (1999) THEN
            file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

            line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
            values_var = string_to_array(line_var, ',', '');

            value_var = trim(values_var[1]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            NEW.timemult = value_var::float;
        END IF;

        -- RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; int_a_var="%", int_d_var="%".', line_var, values_var, value_var, int_a_var, int_d_var;
        -- RAISE EXCEPTION 'file_content_var="%".', file_content_var;
        -- */

    END IF;
  END IF;

  IF TG_OP = 'INSERT' THEN
    RETURN NEW;
  ELSIF TG_OP = 'UPDATE' THEN
    RETURN NEW;
  ELSIF TG_OP = 'DELETE' THEN
    RETURN OLD;
  END IF;
END; $BODY$ LANGUAGE plpgsql;
ALTER FUNCTION COMTRADE.fc_tr_biu_cfg() OWNER TO role_owner;

/*
 * Trigger: "tr_biu"
 */
DROP TRIGGER IF EXISTS tr_biu ON COMTRADE.cfg;
CREATE TRIGGER tr_biu
  BEFORE INSERT OR UPDATE OF file_content
  ON COMTRADE.cfg
  FOR EACH ROW
  EXECUTE PROCEDURE COMTRADE.fc_tr_biu_cfg();

-- /*
--  * Trigger: "tr_biud"
--  */
-- DROP TRIGGER IF EXISTS tr_biud ON COMTRADE.cfg;
-- CREATE TRIGGER tr_biud
--   BEFORE INSERT OR DELETE OR UPDATE OF id_app, name, file_name, file_content, _date_create, _user_create, _date_update, _user_update, _uuid, _version, _deleted
--   ON COMTRADE.cfg
--   FOR EACH ROW
--   EXECUTE PROCEDURE sys.fc_tr_biud(id, id_app, name);

-- /*
--  * Trigger: "tr_data_history"
--  */
-- DROP TRIGGER IF EXISTS tr_data_history ON COMTRADE.cfg;
-- CREATE TRIGGER tr_data_history
--   BEFORE INSERT OR DELETE OR UPDATE OF id_app, name, file_name, file_content, _date_create, _user_create, _date_update, _user_update, _uuid, _version, _deleted
--   ON COMTRADE.cfg
--   FOR EACH ROW
--   EXECUTE PROCEDURE sys.fc_tr_data_history();

RESET ROLE;
