/*
 * This file is part of the "ModuleSystem" project.
 *
 * (c) Nazir Khusnutdinov <nazir@nazir.pro>
 *
 * Triggers for table "COMTRADE.dat"
 * Data file (*.dat)
 */

SET CLIENT_ENCODING TO 'UTF8';

SET SESSION ROLE role_owner;

/*
 * Function trigger: "fc_tr_biu_dat"
 */
-- DROP FUNCTION IF EXISTS COMTRADE.fc_tr_biu_dat()
CREATE OR REPLACE FUNCTION COMTRADE.fc_tr_biu_dat()
  RETURNS TRIGGER AS $BODY$
DECLARE
  get_var boolean;
  file_content_var text;
  line_var text;
  values_var text[];
  value_var text;
  int_tt_var int;
  int_tt_var2 int;
  int_a_var int;
  int_d_var int;
  nrates_var int;
  samp_var int[];
  channel_a_var int[][];
  channel_d_var int[][];
  endsamp_var int[];
--  rev_year_var int;

  temp_a_var text;
  temp_d_var text;
  temp2_a_var text;
  temp2_d_var text;

  nrates_first_var int;
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

        SELECT tt, nn_a, nn_d, nrates, samp, endsamp FROM comtrade.cfg WHERE id = NEW.id_cfg
        INTO int_tt_var, int_a_var, int_d_var, nrates_var, samp_var, endsamp_var;

        NEW.n = NULL;
        NEW.timestamp = NULL;
        NEW.channel_a = NULL;
        NEW.channel_d = NULL;

        nrates_first_var = 1;

        WHILE NOT nrates_var = 0 LOOP
            WHILE NOT endsamp_var[nrates_var] = nrates_first_var LOOP
                line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

                values_var = string_to_array(line_var, ',', '');

                value_var = values_var[1];
                IF COALESCE(value_var, '') = '' THEN
                    value_var = '0' || trim(value_var);
                END IF;
                NEW.n = array_append(NEW.n::int[], value_var::int);

                value_var = values_var[2];
                IF COALESCE(value_var, '') = '' THEN
                    value_var = '0' || trim(value_var);
                END IF;
                NEW.timestamp = array_append(NEW.timestamp::int[], value_var::int);

                int_tt_var2 := 1;
                -- channel_a_var = NULL;
                -- channel_d_var = NULL;
                temp_a_var = NULL;
                temp_d_var = NULL;
                WHILE int_tt_var2 <= int_tt_var LOOP
                    value_var = values_var[int_tt_var2 + 2];
                    IF COALESCE(value_var, '') = '' THEN
                        value_var = '0' || trim(value_var);
                    END IF;

                    IF int_tt_var2 > int_a_var THEN
                        temp_d_var = concat_ws(',', temp_d_var, value_var);
                        -- channel_d_var = array_append(channel_d_var::int[], value_var::int);
                        -- NEW.channel_d = array_append(NEW.channel_d::int[], value_var::int);
                    ELSE
                        temp_a_var = concat_ws(',', temp_a_var, value_var);
                        -- channel_a_var = array_append(channel_a_var::int[], value_var::int);
                        -- NEW.channel_a = array_append(NEW.channel_a::int[], value_var::int);
                    END IF;
                    -- IF int_tt_var2 = 37 THEN
                    --     RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; int_a_var="%", int_d_var="%", int_tt_var="%".', line_var, values_var, value_var, int_a_var, int_d_var, int_tt_var;
                    -- END IF;

                    int_tt_var2 := int_tt_var2 + 1;
                END LOOP;
                temp_a_var = '{' || temp_a_var || '}';
                temp2_a_var = concat_ws(',', temp2_a_var, temp_a_var);
                temp_d_var = '{' || temp_d_var || '}';
                temp2_d_var = concat_ws(',', temp2_d_var, temp_d_var);
    --            NEW.channel_a = CAST(temp_a_var AS int[]);
                -- RAISE EXCEPTION 'channel_a_var="%". channel_d_var="%"', channel_a_var, channel_d_var;
    --            NEW.channel_a = CAST(channel_a AS int[][]) || channel_a_var::int[];
                --NEW.channel_a = ARRAY[[51,-183,131,1], [104,-189,82,2]];
                --SELECT unnest(channel_a) FROM comtrade.dat;
                -- NEW.channel_a = ARRAY(SELECT unnest(channel_a[nrates_var]));
                --NEW.channel_a[nrates_var] = channel_a[nrates_var] || channel_a_var;

                file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

                endsamp_var[nrates_var] := endsamp_var[nrates_var] - 1;
            END LOOP;
            temp2_a_var = '{' || temp2_a_var || '}';
            temp2_d_var = '{' || temp2_d_var || '}';
            NEW.channel_a = CAST(temp2_a_var AS real[][]);
            NEW.channel_d = CAST(temp2_d_var AS int[][]);
            -- RAISE EXCEPTION 'temp2_var="%".', temp2_var;
            nrates_var := nrates_var - 1;
        END LOOP;

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
ALTER FUNCTION COMTRADE.fc_tr_biu_dat() OWNER TO role_owner;

/*
 * Trigger: "tr_biu"
 */
DROP TRIGGER IF EXISTS tr_biu ON COMTRADE.dat;
CREATE TRIGGER tr_biu
  BEFORE INSERT OR UPDATE OF file_content
  ON COMTRADE.dat
  FOR EACH ROW
  EXECUTE PROCEDURE COMTRADE.fc_tr_biu_dat();

-- /*
--  * Trigger: "tr_biud"
--  */
-- DROP TRIGGER IF EXISTS tr_biud ON COMTRADE.dat;
-- CREATE TRIGGER tr_biud
--   BEFORE INSERT OR DELETE OR UPDATE OF id_app, name, file_name, file_content, _date_create, _user_create, _date_update, _user_update, _uuid, _version, _deleted
--   ON COMTRADE.dat
--   FOR EACH ROW
--   EXECUTE PROCEDURE sys.fc_tr_biud(id, id_app, name);

-- /*
--  * Trigger: "tr_data_history"
--  */
-- DROP TRIGGER IF EXISTS tr_data_history ON COMTRADE.dat;
-- CREATE TRIGGER tr_data_history
--   BEFORE INSERT OR DELETE OR UPDATE OF id_app, name, file_name, file_content, _date_create, _user_create, _date_update, _user_update, _uuid, _version, _deleted
--   ON COMTRADE.dat
--   FOR EACH ROW
--   EXECUTE PROCEDURE sys.fc_tr_data_history();

RESET ROLE;
