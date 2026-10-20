Create role region superuser createdb createrole inherit login replication;
ALTER user region with password 'region';
CREATE database region with owner region;
GRANT ALL PRIVILEGES ON DATABASE region TO region;

CREATE TABLE IF NOT EXISTS REGION (
CODI NUMERIC(6) NOT NULL,
NOMBRE VARCHAR(45),

CONSTRAINT PK_REGION PRIMARY KEY (CODI));

