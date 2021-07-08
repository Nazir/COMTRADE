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
  file_content_var bytea;
  file_content_text_var text;
  line_var text;
  values_var text[];
  value_var text;

  tt_var int4;
  nn_a_var int4;
  nn_d_var int4;
  nrates_var int4;
  samp_var float4[];
  -- channel_a_var int[][];
  -- channel_d_var int[][];
  endsamp_var int8[];
  ft_var varchar(8);
  -- rev_year_var int2;

  binary_bytes_var int4; -- The number of bytes required for each sample in the file will be

  temp_a_var text;
  temp_d_var text;
  temp2_a_var text;
  temp2_d_var text;

  ch_var int;
  i int;
  i2 int;
  ii int8;
  b bytea;
BEGIN
  IF TG_OP IN ('INSERT', 'UPDATE') THEN
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

        SELECT tt, nn_a, nn_d, nrates, samp, endsamp, ft FROM comtrade.cfg WHERE id = NEW.id_cfg
        INTO tt_var, nn_a_var, nn_d_var, nrates_var, samp_var, endsamp_var, ft_var;

        IF ft_var = 'ASCII' THEN
            file_content_text_var = encode(file_content_var, 'escape')::text;
        END IF;

        IF ft_var IN ('BINARY', 'BINARY32', 'FLOAT32') THEN
            binary_bytes_var = nn_a_var;
            IF ft_var IN ('BINARY') THEN
                binary_bytes_var = binary_bytes_var * 2;
            END IF;
            IF ft_var IN ('BINARY32', 'FLOAT32') THEN
                binary_bytes_var = binary_bytes_var * 4;
            END IF;
            binary_bytes_var = binary_bytes_var + (2 * (floor(nn_d_var/16))) + 4 + 4;
            -- RAISE NOTICE 'binary_bytes_var="%"', binary_bytes_var;
        END IF;

        NEW.n = NULL;
        NEW.timestamp = NULL;
        NEW.channel_a = NULL;
        NEW.channel_d = NULL;

        WHILE NOT nrates_var = 0 LOOP
            ii = 0;
            WHILE NOT endsamp_var[nrates_var] = ii LOOP
                IF ft_var = 'ASCII' THEN
                    line_var = substring(file_content_text_var from 1 for position(Chr(13) || Chr(10) in file_content_text_var) - 1);

                    values_var = string_to_array(line_var, ',', '');

                    value_var = values_var[1];
                    IF COALESCE(value_var, '') = '' THEN
                        value_var = '0' || trim(value_var);
                    END IF;
                    NEW.n = array_append(NEW.n::int8[], value_var::int8);

                    value_var = values_var[2];
                    IF COALESCE(value_var, '') = '' THEN
                        value_var = '0' || trim(value_var);
                    END IF;
                    NEW.timestamp = array_append(NEW.timestamp::int8[], value_var::int8);

                    ch_var := 1;
                    -- channel_a_var = NULL;
                    -- channel_d_var = NULL;
                    temp_a_var = NULL;
                    temp_d_var = NULL;
                    WHILE ch_var <= tt_var LOOP
                        value_var = values_var[ch_var + 2];
                        IF COALESCE(value_var, '') = '' THEN
                            value_var = '0' || trim(value_var);
                        END IF;

                        IF ch_var > nn_a_var THEN
                            temp_d_var = concat_ws(',', temp_d_var, value_var);
                            -- channel_d_var = array_append(channel_d_var::int[], value_var::int);
                            -- NEW.channel_d = array_append(NEW.channel_d::int[], value_var::int);
                        ELSE
                            temp_a_var = concat_ws(',', temp_a_var, value_var);
                            -- channel_a_var = array_append(channel_a_var::int[], value_var::int);
                            -- NEW.channel_a = array_append(NEW.channel_a::int[], value_var::int);
                        END IF;

                        ch_var = ch_var + 1;
                    END LOOP;

                    file_content_text_var = right(file_content_text_var, char_length(file_content_text_var) - position(Chr(13) || Chr(10) IN file_content_text_var) - 1);
                END IF;

                IF ft_var IN ('BINARY', 'BINARY32', 'FLOAT32') THEN
                    IF ft_var IN ('BINARY', 'BINARY32') THEN
                        b = '\x';
                        FOR i IN REVERSE 4..1 LOOP
                            b = b || substr(file_content_var, (i + binary_bytes_var * ii)::int4, 1); 
                        END LOOP;
                        NEW.n = array_append(NEW.n::int8[], ('x' || encode(b, 'hex'))::bit(32)::int8);

                        b = '\x';
                        FOR i IN REVERSE 8..5 LOOP
                            b = b || substr(file_content_var, (i + binary_bytes_var * ii)::int4, 1); 
                        END LOOP;
                        NEW.timestamp = array_append(NEW.timestamp::int8[], ('x' || encode(b, 'hex'))::bit(32)::int8);
                    END IF;

                    ch_var := 1;
                    temp_a_var = NULL;
                    WHILE ch_var <= nn_a_var LOOP
                        value_var = NULL;
                        IF ft_var IN ('BINARY') THEN
                            b = '\x';
                            -- RAISE EXCEPTION 'STOP TESTING! "%"', (ch_var * 2 + 8);
                            FOR i IN REVERSE (ch_var * 2 + 8)..(ch_var * 2 + 8 - 1) LOOP
                                b = b || substr(file_content_var, (i + binary_bytes_var * ii)::int4, 1); 
                            END LOOP;

                            -- value_var = ('x' || encode(b, 'hex'))::bit(16)::int::text;
                            value_var = (((('X' || encode(b, 'hex'))::bit(16))::bit(32)::int4) >> 16)::int2;
                            -- RAISE NOTICE '%. b="%", length="%", value_var="%"', ii, b::text, length(b), value_var;
                        END IF;
                        temp_a_var = concat_ws(',', temp_a_var, value_var);

                        ch_var = ch_var + 1;
                    END LOOP;

                    temp_d_var = NULL;
                    value_var = '';
                    IF ft_var IN ('BINARY') THEN
                        b = '\x';
                        -- RAISE EXCEPTION 'STOP TESTING! %', (binary_bytes_var - floor(nn_d_var/16));
                        -- FOR i IN REVERSE binary_bytes_var..(binary_bytes_var - floor(nn_d_var/16) - 1) LOOP
                        FOR i IN (binary_bytes_var - floor(nn_d_var/16) - 1)..binary_bytes_var LOOP
                            b = substr(file_content_var, (i + binary_bytes_var * ii)::int4, 1) || b;
                            -- RAISE NOTICE 'b="%"" bit_length(b)="%" i="%" i_="%" ', b::TEXT, bit_length(b), i, (i + 1) % 2;
                            IF (i + 1) % 2 > 0 THEN
                                FOR i2 IN 0..bit_length(b) - 1 LOOP
                                    temp_d_var = concat_ws(',', temp_d_var, get_bit(b, i2));
                                    -- RAISE NOTICE 'i2="%", get_bit(b, i2)="%" ', i2, get_bit(b, i2);
                                END LOOP;
                                b = '\x';
                            END IF;
                            IF (i + 1) % 2 = 0 THEN
                                FOR i2 IN REVERSE bit_length(b) - 1..0 LOOP
                                    temp_d_var = concat_ws(',', temp_d_var, get_bit(b, i2));
                                    -- RAISE NOTICE 'i2="%", get_bit(b, i2)="%" ', i2, get_bit(b, i2);
                                END LOOP;
                                b = '\x';
                            END IF;
                        END LOOP;
                        -- value_var = encode(b, 'hex') || value_var;
                    END IF;
                    -- value_var = ('X' || value_var)::bit(32);
                    -- RAISE EXCEPTION 'STOP TESTING! %', ('\x' || value_var)::bytea;
                    -- FOR i IN REVERSE bit_length(('\x' || value_var)::bytea) - 1..0 LOOP
                    --     temp_d_var = concat_ws(',', temp_d_var, get_bit(('\x' || value_var)::bytea, i));
                    -- END LOOP;
                    -- RAISE NOTICE '%. [%] b="%", length="%", value_var="%", temp_d_var="%"', ii, ch_var, b::text, length(b), value_var, temp_d_var;
                END IF;

                temp_a_var = '{' || temp_a_var || '}';
                temp2_a_var = concat_ws(',', temp2_a_var, temp_a_var);
                temp_d_var = '{' || temp_d_var || '}';
                temp2_d_var = concat_ws(',', temp2_d_var, temp_d_var);
                -- NEW.channel_a = CAST(temp_a_var AS int[]);
                -- RAISE EXCEPTION 'channel_a_var="%". channel_d_var="%"', channel_a_var, channel_d_var;
                -- NEW.channel_a = CAST(channel_a AS int[][]) || channel_a_var::int[];
                -- NEW.channel_a = ARRAY[[51,-183,131,1], [104,-189,82,2]];
                -- SELECT unnest(channel_a) FROM comtrade.dat;
                -- NEW.channel_a = ARRAY(SELECT unnest(channel_a[nrates_var]));
                -- NEW.channel_a[nrates_var] = channel_a[nrates_var] || channel_a_var;

                ii = ii + 1;
                -- IF ii = 5 THEN RAISE EXCEPTION 'STOP TESTING!'; EXIT; END IF;
            END LOOP;

            temp2_a_var = '{' || temp2_a_var || '}';
            -- RAISE NOTICE '%. temp2_a_var="%"', ii, temp2_a_var;
            temp2_d_var = '{' || temp2_d_var || '}';
            NEW.channel_a = CAST(temp2_a_var AS float8[][]);
            NEW.channel_d = CAST(temp2_d_var AS int2[][]);
            -- RAISE EXCEPTION 'temp2_var="%".', temp2_var;

            nrates_var = nrates_var - 1;

            -- IF nrates_var = 0 THEN RAISE EXCEPTION 'STOP TESTING!'; EXIT; END IF;
        END LOOP;

        -- RAISE EXCEPTION 'line_var="%"; values_var="%"; value_var="%"; nn_a_var="%", nn_d_var="%".', line_var, values_var, value_var, nn_a_var, nn_d_var;
        -- RAISE EXCEPTION 'file_content_var="%".', file_content_var;
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

RESET ROLE;
