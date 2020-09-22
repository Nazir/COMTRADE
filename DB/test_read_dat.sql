DO $BODY$
DECLARE
  id_var mini.dm_id;
  name_var text;
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
BEGIN
    name_var = 'test.cfg';
    
    SELECT d.id, c.tt, c.nn_a, c.nn_d, c.nrates, c.samp, c.endsamp, d.file_content FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg WHERE c.name=name_var
    INTO id_var, int_tt_var, int_a_var, int_d_var, nrates_var, samp_var, endsamp_var, file_content_var; 

    UPDATE comtrade.dat SET n = NULL WHERE id=id_var;
    UPDATE comtrade.dat SET timestamp = NULL WHERE id=id_var;
    UPDATE comtrade.dat SET channel_a = NULL WHERE id=id_var;
    UPDATE comtrade.dat SET channel_d = NULL WHERE id=id_var;

    WHILE NOT nrates_var = 0 LOOP
        WHILE NOT endsamp_var[nrates_var] = 0 LOOP
            line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

            values_var = string_to_array(line_var, ',', '');

            value_var = values_var[1]; 
            IF COALESCE(value_var, '') = '' THEN
                value_var = '0' || trim(value_var);
            END IF;
            UPDATE comtrade.dat SET n = array_append(n::int[], value_var::int) WHERE id=id_var;
    
            value_var = values_var[2]; 
            IF COALESCE(value_var, '') = '' THEN
                value_var = '0' || trim(value_var);
            END IF;
            UPDATE comtrade.dat SET timestamp = array_append(timestamp::int[], value_var::int) WHERE id=id_var;

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
                    -- UPDATE comtrade.dat SET channel_d = array_append(channel_d::int[], value_var::int) WHERE id=id_var;
                ELSE
                    temp_a_var = concat_ws(',', temp_a_var, value_var);
                    -- channel_a_var = array_append(channel_a_var::int[], value_var::int);
                    -- UPDATE comtrade.dat SET channel_a = array_append(channel_a::int[], value_var::int) WHERE id=id_var;
                END IF;
                -- IF int_tt_var2 = 37 THEN
                --     RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; int_a_var="%", int_d_var="%", int_tt_var="%".', line_var, values_var, value_var, int_a_var, int_d_var, int_tt_var;
                -- END IF;

                int_tt_var2 := int_tt_var2 + 1;
            END LOOP;
            temp_a_var = '{' || temp_a_var || '}';
            temp2_a_var = concat_ws(',', temp2_a_var, temp_a_var);
            temp_d_var = '{' || temp_d_var || '}';
            temp2_d_var = concat_ws(',', temp2_d_var, temp_a_var);
--            UPDATE comtrade.dat SET channel_a = CAST(temp_a_var AS int[]) WHERE id=id_var;
            -- RAISE EXCEPTION 'channel_a_var="%". channel_d_var="%"', channel_a_var, channel_d_var;
--            UPDATE comtrade.dat SET channel_a = CAST(channel_a AS int[][]) || channel_a_var::int[] WHERE id=id_var;
            --UPDATE comtrade.dat SET channel_a = ARRAY[[51,-183,131,1], [104,-189,82,2]] WHERE id=id_var;
            --SELECT unnest(channel_a) FROM comtrade.dat WHERE id=id_var;
            -- UPDATE comtrade.dat SET channel_a = ARRAY(SELECT unnest(channel_a[nrates_var])) WHERE id=id_var;
            --UPDATE comtrade.dat SET channel_a[nrates_var] = channel_a[nrates_var] || channel_a_var WHERE id=id_var;

            file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

            endsamp_var[nrates_var] := endsamp_var[nrates_var] - 1;
        END LOOP;
        temp2_a_var = '{' || temp2_a_var || '}';
        temp2_d_var = '{' || temp2_d_var || '}';
        UPDATE comtrade.dat SET channel_a = CAST(temp2_a_var AS int[][]) WHERE id=id_var;
        UPDATE comtrade.dat SET channel_d = CAST(temp2_d_var AS int[][]) WHERE id=id_var;
        -- RAISE EXCEPTION 'temp2_var="%".', temp2_var;
        nrates_var := nrates_var - 1;
    END LOOP;

    -- RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; int_a_var="%", int_d_var="%", int_tt_var="%".', line_var, values_var, value_var, int_a_var, int_d_var, int_tt_var;
    -- RAISE EXCEPTION 'file_content_var="%".', file_content_var;
    -- */
END $BODY$;

-- SELECT channel_a FROM comtrade.dat;
