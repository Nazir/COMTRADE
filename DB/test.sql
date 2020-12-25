/*
  TRUNCATE TABLE comtrade.cfg CASCADE;
  ALTER SEQUENCE comtrade.cfg_id_seq RESTART WITH 1;
  ALTER SEQUENCE comtrade.dat_id_seq RESTART WITH 1;
  ALTER SEQUENCE comtrade.oscillogram_id_seq RESTART WITH 1;
--*/

DO $BODY$
DECLARE
  name_var text;

  n_var int;

  id_dat_var mini.dm_id;
  num_var mini.dm_integer;
  time_var mini.dm_integer;

  analogue_signal_var float;

  ids_dat_var mini.dm_id[];
  nums_var mini.dm_integer[];
  times_var mini.dm_integer[];
  --analogue_signal_var float[];

  temp_var text;

BEGIN

    --name_var = 'test1.cfg';

    CREATE TEMPORARY TABLE _c ON COMMIT DROP AS
    SELECT
      c.id AS id_cfg
    , unnest(c.channels_a_an) AS channel_a_an
    , unnest(c.channels_a_ch_id) AS channels_a_ch_id
    , unnest(c.channels_a_uu) AS channels_a_uu
    , unnest(c.channels_a_а) AS channels_a_а
    , unnest(c.channels_a_b) AS channels_a_b
    FROM comtrade.cfg AS c
    WHERE TRUE
        --AND c.name LIKE 'test1.cfg'
        --AND c.id = t1.id_cfg
        --AND c.channel_a_an = 1
    ORDER BY
        c.id
      , channel_a_an
    --LIMIT 100
    ;


    CREATE TEMPORARY TABLE _d ON COMMIT DROP AS
    SELECT
        row_number () OVER (ORDER BY 1) AS row
        , d.*
        FROM (SELECT
                  d.id_cfg AS id_cfg
                , d.id AS id_dat
                , unnest(d.n) AS n
                , d.timestamp AS timestamp
                , d.channel_a AS channel_a
                , d.channel_d AS channel_d
            FROM comtrade.dat AS d
            WHERE TRUE
                --AND c.name LIKE 'test1.cfg'
                --AND c.id = t1.id_cfg
                --AND c.channel_a_an = 1
            ORDER BY
                id_cfg
              , id_dat
              , n
            --LIMIT 100
            ) AS d
    ;

    CREATE TEMPORARY TABLE _osc ON COMMIT DROP AS
    SELECT
      d.id_dat AS id_dat
    , c.channel_a_an
    , d.n AS num
    , d.timestamp[d.n] AS time
    , c.channels_a_а * d.channel_a[d.n][c.channel_a_an] + c.channels_a_b AS analogue_signal

    --, c.channels_a_а * d.channel_a[d.row][c.channel_a_an] + c.channels_a_b AS analogue_signal
    --, d.channel_d[d.row][c.channels_d_dn] AS discrete_signals
    FROM _c AS c
        INNER JOIN _d AS d ON d.id_cfg = c.id_cfg
    WHERE TRUE
        --AND c.channel_a_an = 1
        --AND c.id_cfg = t1.id_cfg
    --LIMIT 100
    ;

--*/

/*
    CREATE TEMPORARY TABLE _osc ON COMMIT DROP AS
    SELECT
      d.id AS id_dat
    , c.channel_a_an
    , d.n AS num
    , d.timestamp[d.row] AS time
    , c.channels_a_а * d.channel_a[d.row][c.channel_a_an] + c.channels_a_b AS analogue_signal
--    , d.channel_d[d.row][c.channels_d_dn] AS discrete_signals
    FROM (SELECT unnest(c.channels_a_an) AS channel_a_an, unnest(channels_a_ch_id) AS channels_a_ch_id, unnest(channels_a_uu) AS channels_a_uu, unnest(channels_a_а) AS channels_a_а, unnest(channels_a_b) AS channels_a_b FROM comtrade.cfg AS c
            WHERE TRUE
                AND c.name LIKE 'test1.cfg'
                --AND c.id = t1.id_cfg
            ) AS c
        INNER JOIN (SELECT row_number () OVER (ORDER BY unnest(d.n)) AS row, d.id AS id, unnest(d.n) AS n, d.timestamp, d.channel_a, d.channel_d FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg
            WHERE TRUE
                AND c.name LIKE 'test1.cfg'
                --AND c.id = t1.id_cfg
        ) AS d ON TRUE
    WHERE TRUE
      -- AND c.channel_a_an = 1
    --LIMIT 100
    ;
--*/




    --TRUNCATE TABLE comtrade.oscillogram;
    --ALTER SEQUENCE comtrade.oscillogram_id_seq RESTART WITH 1;
    --INSERT INTO comtrade.oscillogram(id_dat, channel_a_an, num, time, analogue_signal)
    CREATE TEMPORARY TABLE _osc2 ON COMMIT DROP AS
    WITH RECURSIVE temp1 (id_dat, channel_a_an, num) AS (
        SELECT
          _o.id_dat
        , _o.channel_a_an
        , _o.num
        --, _o.time
        FROM _osc AS _o
        WHERE TRUE
        GROUP BY
          _o.id_dat
        , _o.channel_a_an
        , _o.num
        ORDER BY
          _o.id_dat
        , _o.channel_a_an
        , _o.num
        --LIMIT 10
    )
    SELECT
      t1.id_dat
    , _o.channel_a_an
    , t1.num
    , _o.time
    --, ARRAY((SELECT analogue_signal FROM _osc AS _o2 WHERE t1.id_dat = _o2.id_dat AND t1.channel_a_an = _o2.channel_a_an AND t1.num = _o2.num)) AS analogue_signals
    , analogue_signal
    FROM temp1 AS t1
        INNER JOIN _osc AS _o ON t1.id_dat = _o.id_dat AND t1.channel_a_an = _o.channel_a_an AND t1.num = _o.num
    WHERE TRUE
      --AND id = 1
    ORDER BY
      t1.id_dat
    , _o.channel_a_an
    , t1.num
    --LIMIT 100
    ;
--*/


    CREATE TEMPORARY TABLE _max ON COMMIT DROP AS
    SELECT
      _o3.id_dat
    , array_agg(_o3.res_max) AS maxs
    FROM (
    SELECT
      _o.id_dat
    , _o.channel_a_an
    --, ARRAY((SELECT max(analogue_signal) FROM _osc2 AS _o2 WHERE _o.id_dat = _o2.id_dat AND _o.channel_a_an = _o2.channel_a_an)) AS res_max
    , max(analogue_signal) AS res_max
    FROM _osc2 AS _o
    WHERE TRUE
      --AND id = 1
    GROUP BY
      _o.id_dat
    , _o.channel_a_an
    ORDER BY
      _o.id_dat
    , _o.channel_a_an
    ) AS _o3
    GROUP BY
      _o3.id_dat
    ;
--*/

    CREATE TEMPORARY TABLE _min ON COMMIT DROP AS
    SELECT
      _o3.id_dat
    , array_agg(_o3.res_min) AS mins
    FROM (
    SELECT
      _o.id_dat
    , _o.channel_a_an
    --, ARRAY((SELECT min(analogue_signal) FROM _osc2 AS _o2 WHERE _o.id_dat = _o2.id_dat AND _o.channel_a_an = _o2.channel_a_an)) AS res_min
    , min(analogue_signal) AS res_min
    FROM _osc2 AS _o
    WHERE TRUE
      --AND id = 1
    GROUP BY
      _o.id_dat
    , _o.channel_a_an
    ORDER BY
      _o.id_dat
    , _o.channel_a_an
    ) AS _o3
    GROUP BY
      _o3.id_dat
    ;
--*/

/*    SELECT count(num)
    FROM _osc
    INTO
    n_var;


    temp_var = '';
    WHILE NOT n_var = 0 LOOP

        SELECT
          id_dat
        , array(SELECT analogue_signal FROM _osc AS _o WHERE TRUE)
        INTO
          id_dat_var
        , analogue_signal_var
        ;

        temp_var = concat_ws(',', temp_var, analogue_signal_var);
        temp_var = '{' || temp_var || '}';

        n_var := n_var - 1;
    END LOOP;

  CREATE TEMPORARY TABLE _x ON COMMIT DROP
  AS
    SELECT
    --  d.id
    --, d.id_cfg
    --, d.name
    --, d.file_name
    --, d.file_content

    --  d.row
    --, d.n
    --, d.timestamp[d.row] AS timestamp
    --, c.channels_a_an
    --, c.channels_a_ch_id
    --, d.channel_a[d.row][c.channels_a_an] AS channel_a
      min(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res_min
    , max(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res_max
    --, c.channels_a_uu
    --, d.channel_d[d.row][c.channels_d_dn]
    FROM (SELECT unnest(c.channels_a_an) AS channels_a_an, unnest(channels_a_ch_id) AS channels_a_ch_id, unnest(channels_a_uu) AS channels_a_uu, unnest(channels_a_а) AS channels_a_а, unnest(channels_a_b) AS channels_a_b FROM comtrade.cfg AS c WHERE TRUE AND c.name LIKE 'test1.cfg') AS c
        INNER JOIN (SELECT row_number () over (ORDER BY unnest(d.n)) AS row, unnest(d.n) AS n, d.timestamp, d.channel_a, d.channel_d FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg WHERE TRUE AND c.name LIKE 'test1.cfg') AS d ON TRUE
    WHERE TRUE
      AND c.channels_a_an = 4

    UNION ALL

    SELECT
      min(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res2_min
    , max(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res2_max
    FROM (SELECT unnest(c.channels_a_an) AS channels_a_an, unnest(channels_a_ch_id) AS channels_a_ch_id, unnest(channels_a_uu) AS channels_a_uu, unnest(channels_a_а) AS channels_a_а, unnest(channels_a_b) AS channels_a_b FROM comtrade.cfg AS c WHERE TRUE AND c.name LIKE 'test2.cfg') AS c
        INNER JOIN (SELECT row_number () over (ORDER BY unnest(d.n)) AS row, unnest(d.n) AS n, d.timestamp, d.channel_a, d.channel_d FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg WHERE TRUE AND c.name LIKE 'test2.cfg') AS d ON TRUE
    WHERE TRUE
      AND c.channels_a_an = 4

    UNION ALL

    SELECT
      min(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res3_min
    , max(channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b) AS res3_max
    FROM (SELECT unnest(c.channels_a_an) AS channels_a_an, unnest(channels_a_ch_id) AS channels_a_ch_id, unnest(channels_a_uu) AS channels_a_uu, unnest(channels_a_а) AS channels_a_а, unnest(channels_a_b) AS channels_a_b FROM comtrade.cfg AS c WHERE TRUE AND c.name LIKE 'test3.cfg') AS c
        INNER JOIN (SELECT row_number () over (ORDER BY unnest(d.n)) AS row, unnest(d.n) AS n, d.timestamp, d.channel_a, d.channel_d FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg WHERE TRUE AND c.name LIKE 'test3.cfg') AS d ON TRUE
    WHERE TRUE
      AND c.channels_a_an = 4

;
--*/

  /*
  CREATE TEMPORARY TABLE _x2 ON COMMIT DROP
  AS
    WITH RECURSIVE t1 (res_max, res_min) AS (
      SELECT
        WHEN abs(t2.res_max) > abs(t2.res_min)
      FROM _x AS t2
        INNER JOIN temp1 ON t1.n = t2.n
    )
    SELECT *
    FROM t1
    --WHERE id = 1
    ORDER BY channel_a, n
    --LIMIT 100
  --*/

END $BODY$;


SELECT
      t.maxs
    , t.mins
    , CASE
        WHEN abs(t.maxs[1][4]) > abs(t.mins[1][4]) AND abs(t.maxs[2][4]) < abs(t.mins[2][4]) AND abs(t.maxs[3][4]) < abs(t.mins[3][4]) AND t.maxs[1][4] > t.maxs[2][4] AND t.maxs[1][4] > t.maxs[3][4] THEN 1
        WHEN abs(t.maxs[1][4]) < abs(t.mins[1][4]) AND abs(t.maxs[2][4]) > abs(t.mins[2][4]) AND abs(t.maxs[1][4]) > abs(t.mins[3][4]) AND t.mins[1][4] < t.mins[2][4] AND t.mins[1][4] < t.mins[3][4] THEN 1

        WHEN abs(t.maxs[2][4]) > abs(t.mins[2][4]) AND abs(t.maxs[1][4]) < abs(t.mins[1][4]) AND abs(t.maxs[3][4]) < abs(t.mins[3][4]) AND t.maxs[2][4] > t.maxs[1][4] AND t.maxs[2][4] > t.maxs[3][4] THEN 2
        WHEN abs(t.maxs[2][4]) < abs(t.mins[2][4]) AND abs(t.maxs[1][4]) > abs(t.mins[1][4]) AND abs(t.maxs[3][4]) > abs(t.mins[3][4]) AND t.mins[2][4] < t.mins[1][4] AND t.mins[2][4] < t.mins[3][4] THEN 2

        WHEN abs(t.maxs[3][4]) > abs(t.mins[3][4]) AND abs(t.maxs[1][4]) < abs(t.mins[1][4]) AND abs(t.maxs[2][4]) < abs(t.mins[2][4]) AND t.maxs[3][4] > t.maxs[1][4] AND t.maxs[3][4] > t.maxs[2][4] THEN 3
        WHEN abs(t.maxs[3][4]) < abs(t.mins[3][4]) AND abs(t.maxs[1][4]) > abs(t.mins[1][4]) AND abs(t.maxs[2][4]) > abs(t.mins[2][4]) AND t.mins[3][4] < t.mins[1][4] AND t.mins[3][4] < t.mins[2][4] THEN 3
        ELSE 0
      END AS "Fault"

    FROM (
        SELECT
          array_agg(_mx.maxs) AS maxs
        , array_agg(_mn.mins) AS mins
        FROM _max AS _mx
            INNER JOIN _min AS _mn ON _mn.id_dat = _mx.id_dat
        ) AS t
        ;
--*/
/*
    SELECT
        *
    FROM comtrade.oscillogram
    ;
--*/
/*
    SELECT
      array(SELECT analogue_signal FROM _osc AS _o WHERE TRUE)
    ;
--*/
/*
SELECT
  *
--  x.res[0][0]
,  CASE
    WHEN abs(res_max) > abs(res_min)
--AND abs(I02max) < abs(I02min) AND abs(I03max)<abs(I03min) AND I01max>I02max AND I01max>I03max
    THEN 1
  END
--FROM (SELECT ARRAY(SELECT ROW(res_max,res_min)) AS res FROM _x) AS x;
FROM _x;

--*/

/*

if abs(I01max)>abs(I01min), abs(I02max)<abs(I02min), abs(I03max)<abs(I03min), I01max>I02max, I01max>I03max
Fault=1
end
if abs(I01max)<abs(I01min), abs(I02max)>abs(I02min), abs(I03max)>abs(I03min), I01min<I02min, I01min<I03min
    Fault=1
end

if abs(I02max)>abs(I02min), abs(I01max)<abs(I01min), abs(I03max)<abs(I03min), I02max>I01max, I02max>I03max
Fault=2
end
if abs(I02max)<abs(I02min), abs(I01max)>abs(I01min), abs(I03max)>abs(I03min), I02min<I01min, I02min<I03min
    Fault=2
end

if abs(I03max)>abs(I03min), abs(I01max)<abs(I01min), abs(I02max)<abs(I02min), I03max>I01max, I03max>I02max
Fault=3
end
if abs(I03max)<abs(I03min), abs(I01max)>abs(I01min), abs(I02max)>abs(I02min), I03min<I01min, I03min<I02min
    Fault=3
end
*/
