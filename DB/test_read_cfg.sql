DO $BODY$
DECLARE
  name_var text;
  file_content_var text;
  line_var text;
  values_var text[];
  value_var text;
  int_a_var int;
  int_d_var int;
  nrates_var int;
  rev_year_var int;
BEGIN
    name_var = 'test.cfg';
    
    SELECT file_content FROM comtrade.cfg WHERE name=name_var
    INTO file_content_var; 

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
    values_var = string_to_array(line_var, ',', '');
    -- SELECT unnest(values_var);
    -- FOREACH value_var IN ARRAY values_var LOOP
    --     RAISE NOTICE '%', value_var;
    -- END LOOP;
    -- FOR i IN 1..10 LOOP
    --     -- i will take on the values 1,2,3,4,5,6,7,8,9,10 within the loop
    -- END LOOP;
    UPDATE comtrade.cfg SET station_name = trim(values_var[1])::text WHERE name=name_var;
    UPDATE comtrade.cfg SET rec_dev_id = values_var[2]::int WHERE name=name_var;
    UPDATE comtrade.cfg SET rev_year = NULL WHERE name=name_var;
    rev_year_var = 1991;
    IF array_length(values_var, 1) = 3 THEN
        rev_year_var = values_var[3]::int;
    END IF;
    UPDATE comtrade.cfg SET rev_year = rev_year_var WHERE name=name_var;

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

    -- values_var = line_var;
    -- value_var = trim(substring(values_var from 1 for position(',' in values_var) - 1));
    -- UPDATE comtrade.cfg SET tt = value_var::int WHERE name=name_var;

    values_var = string_to_array(line_var, ',', '');
    UPDATE comtrade.cfg SET tt = values_var[1]::int WHERE name=name_var;
    int_a_var = rtrim(values_var[2], 'A')::int;
    UPDATE comtrade.cfg SET nn_a = int_a_var WHERE name=name_var;
    int_d_var = rtrim(values_var[3], 'D')::int;
    UPDATE comtrade.cfg SET nn_d = int_d_var WHERE name=name_var;

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    UPDATE comtrade.cfg SET channels_a_an = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_ch_id = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_ph = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_ccbm = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_uu = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_а = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_b = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_skew = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_min = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_max = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_primary = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_secondary = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_a_ps = NULL WHERE name=name_var;
    -- UPDATE comtrade.cfg SET channels_a_an = array_append(channels_a_an::int[], 0::int) WHERE name=name_var;

    WHILE NOT int_a_var = 0 LOOP
        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        values_var = string_to_array(line_var, ',', '');

        value_var = values_var[1]; 
        IF COALESCE(value_var, '') = '' THEN
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_an = array_append(channels_a_an::int[], value_var::int) WHERE name=name_var;

        value_var = trim(values_var[2]); 
        UPDATE comtrade.cfg SET channels_a_ch_id = array_append(channels_a_ch_id::text[], value_var::text) WHERE name=name_var;

        value_var = trim(values_var[3]); 
        UPDATE comtrade.cfg SET channels_a_ph = array_append(channels_a_ph::text[], value_var::text) WHERE name=name_var;

        value_var = trim(values_var[4]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_ccbm = array_append(channels_a_ccbm::int[], value_var::int) WHERE name=name_var;

        value_var = trim(values_var[5]); 
        UPDATE comtrade.cfg SET channels_a_uu = array_append(channels_a_uu::text[], value_var::text) WHERE name=name_var;

        value_var = trim(values_var[6]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_а = array_append(channels_a_а::float[], value_var::float) WHERE name=name_var;

        value_var = trim(values_var[7]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_b = array_append(channels_a_b::float[], value_var::float) WHERE name=name_var;

        value_var = trim(values_var[8]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_skew = array_append(channels_a_skew::float[], value_var::float) WHERE name=name_var;

        value_var = trim(values_var[9]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_min = array_append(channels_a_min::int[], value_var::int) WHERE name=name_var;

        value_var = trim(values_var[10]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_a_max = array_append(channels_a_max::int[], value_var::int) WHERE name=name_var;

        IF rev_year_var IN (1999) THEN
            value_var = trim(values_var[11]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            UPDATE comtrade.cfg SET channels_a_primary = array_append(channels_a_primary::float[], value_var::float) WHERE name=name_var;
            value_var = trim(values_var[12]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            UPDATE comtrade.cfg SET channels_a_secondary = array_append(channels_a_secondary::float[], value_var::float) WHERE name=name_var;
            value_var = trim(values_var[13]); 
            IF COALESCE(value_var, '') = '' THEN 
                value_var = '0' || trim(value_var);
            END IF;
            UPDATE comtrade.cfg SET channels_a_ps = array_append(channels_a_ps::text[], value_var::text) WHERE name=name_var;
        END IF;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        int_a_var := int_a_var - 1;
    END LOOP;

    UPDATE comtrade.cfg SET channels_d_dn = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_d_ch_id = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_d_ph = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_d_ccbm = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET channels_d_y = NULL WHERE name=name_var;

    WHILE NOT int_d_var = 0 LOOP
        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

        values_var = string_to_array(line_var, ',', '');

        value_var = trim(values_var[1]); 
        IF COALESCE(value_var, '') = '' THEN 
        value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET channels_d_dn = array_append(channels_d_dn::int[], value_var::int) WHERE name=name_var;

        value_var = trim(values_var[2]); 
        UPDATE comtrade.cfg SET channels_d_ch_id = array_append(channels_d_ch_id::text[], value_var::text) WHERE name=name_var;

        IF rev_year_var IN (1991) THEN
            value_var = trim(values_var[3]); 
            UPDATE comtrade.cfg SET channels_d_y = array_append(channels_d_y::int[], value_var::int) WHERE name=name_var;
        END IF;

        IF rev_year_var IN (1999) THEN
            value_var = trim(values_var[3]); 
            UPDATE comtrade.cfg SET channels_d_ph = array_append(channels_d_ph::text[], value_var::text) WHERE name=name_var;
            value_var = trim(values_var[4]); 
            UPDATE comtrade.cfg SET channels_d_ccbm = array_append(channels_d_ccbm::text[], value_var::text) WHERE name=name_var;
            value_var = trim(values_var[7]); 
            UPDATE comtrade.cfg SET channels_d_y = array_append(channels_d_y::int[], value_var::int) WHERE name=name_var;
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
    UPDATE comtrade.cfg SET lf = value_var::float WHERE name=name_var;

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
    values_var = string_to_array(line_var, ',', '');

    value_var = trim(values_var[1]); 
    IF COALESCE(value_var, '') = '' THEN 
        value_var = '0' || trim(value_var);
    END IF;
    nrates_var = value_var::int;
    UPDATE comtrade.cfg SET nrates = value_var::int WHERE name=name_var;

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    UPDATE comtrade.cfg SET samp = NULL WHERE name=name_var;
    UPDATE comtrade.cfg SET endsamp = NULL WHERE name=name_var;

    WHILE NOT nrates_var = 0 LOOP
        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        values_var = string_to_array(line_var, ',', '');

        value_var = trim(values_var[1]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || value_var;
        END IF;
        UPDATE comtrade.cfg SET samp = array_append(samp::int[], value_var::int) WHERE name=name_var;

        value_var = trim(values_var[2]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET endsamp = array_append(endsamp::int[], value_var::int) WHERE name=name_var;

        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        nrates_var := nrates_var - 1;
    END LOOP;

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
    -- values_var = string_to_array(line_var, ',', '');

    -- SELECT TO_TIMESTAMP('01/01/07,00:45:13.457000','DD/MM/YY,HH24:MI:SS.US');
    -- value_var = trim(values_var[1]); 
    value_var = line_var; 
    SELECT TO_TIMESTAMP(value_var,'DD/MM/YY,HH24:MI:SS.US') INTO value_var;
    UPDATE comtrade.cfg SET datetime_first = value_var::timestamp WHERE name=name_var;

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
    -- values_var = string_to_array(line_var, ',', '');
    -- value_var = trim(values_var[2]); 
    value_var = line_var; 
    SELECT TO_TIMESTAMP(value_var,'DD/MM/YY,HH24:MI:SS.US') INTO value_var;
    UPDATE comtrade.cfg SET datetime_start = value_var::timestamp WHERE name=name_var;

    file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

    line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);

    values_var = string_to_array(line_var, ',', '');
    value_var = trim(values_var[1]); 
    value_var = upper(COALESCE(value_var, ''));
    UPDATE comtrade.cfg SET ft = CASE WHEN value_var = 'ASCII' THEN TRUE WHEN value_var = 'BINARY' THEN FALSE ELSE NULL END WHERE name=name_var;

    IF rev_year_var IN (1999) THEN
        file_content_var = right(file_content_var, char_length(file_content_var) - position(Chr(13) || Chr(10) in file_content_var) - 1);

        line_var = substring(file_content_var from 1 for position(Chr(13) || Chr(10) in file_content_var) - 1);
        values_var = string_to_array(line_var, ',', '');

        value_var = trim(values_var[1]); 
        IF COALESCE(value_var, '') = '' THEN 
            value_var = '0' || trim(value_var);
        END IF;
        UPDATE comtrade.cfg SET timemult = value_var::float WHERE name=name_var;
    END IF;

    -- RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; int_a_var="%", int_d_var="%".', line_var, values_var, value_var, int_a_var, int_d_var;
    -- RAISE EXCEPTION 'file_content_var="%".', file_content_var;
    -- */
END $BODY$;


