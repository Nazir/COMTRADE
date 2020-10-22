SELECT
--  d.id
--, d.id_cfg
--, d.name
--, d.file_name
--, d.file_content
  d.row
, d.n
, d.timestamp[d.row] AS timestamp
, c.channels_a_an
, c.channels_a_ch_id
, d.channel_a[d.row][c.channels_a_an] AS channel_a
, channels_a_а * d.channel_a[d.row][c.channels_a_an] + channels_a_b AS res
, c.channels_a_uu
--, d.channel_d[d.row][c.channels_d_dn]
FROM (SELECT unnest(c.channels_a_an) AS channels_a_an, unnest(channels_a_ch_id) AS channels_a_ch_id, unnest(channels_a_uu) AS channels_a_uu, unnest(channels_a_а) AS channels_a_а, unnest(channels_a_b) AS channels_a_b FROM comtrade.cfg AS c WHERE TRUE AND c.name LIKE 'test.cfg') AS c
    INNER JOIN (SELECT row_number () over (ORDER BY unnest(d.n)) AS row, unnest(d.n) AS n, d.timestamp, d.channel_a, d.channel_d FROM comtrade.dat AS d INNER JOIN comtrade.cfg AS c ON c.id = d.id_cfg WHERE TRUE AND c.name LIKE 'test.cfg') AS d ON TRUE
WHERE TRUE
--  AND c.channels_a_an = 1
;
/*

WITH RECURSIVE temp1 (id_cfg, n, timestamp, channel_a, channel_d) AS (
  SELECT id_cfg, unnest(n) AS n, timestamp, channel_a, channel_d
  FROM comtrade.cfg AS t2
    INNER JOIN temp1 ON temp1.n = t2.n
)
SELECT *
FROM temp1
--WHERE id = 1
ORDER BY channel_a, n
--LIMIT 100

--*/