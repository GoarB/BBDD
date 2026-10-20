Create role provincia superuser createdb createrole inherit login replication;
ALTER user provincia with password 'provincia';
CREATE database provincia with owner provincia;
GRANT ALL PRIVILEGES ON DATABASE provincia TO provincia;

CREATE TABLE IF NOT EXISTS PROVINCIA (
CODI NUMERIC(6) NOT NULL,
NOMBRE VARCHAR(45),
COD:REGION NUMERIC(6)

CONSTRAINT PK_PROVINCIA PRIMARY KEY (CODI),
CONSTRAINT fk_prov_reg FOREIGN KEY (COD_REGION) REFERENCES REGION (COD_REGION)
);
