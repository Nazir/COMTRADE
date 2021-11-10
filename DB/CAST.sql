DROP FUNCTION IF EXISTS bit16_to_smallint CASCADE;
CREATE OR REPLACE FUNCTION bit16_to_smallint(b16 bit(16)) RETURNS smallint AS $$
    BEGIN
            RETURN (b16::bit(16))::smallint;
    END;
$$ LANGUAGE plpgsql;

CREATE CAST (bit(16) AS smallint) WITH FUNCTION bit16_to_smallint(bit(16)) AS ASSIGNMENT;