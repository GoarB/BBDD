Create role localidad superuser createdb createrole inherit login replication;
ALTER user localidad with password 'localidad';
CREATE database localidad with owner localidad;
GRANT ALL PRIVILEGES ON DATABASE localidad TO localidad;

CREATE TABLE IF NOT EXISTS LOCALIDAD (
CODI NUMERIC(6) NOT NULL,
NOMBRE VARCHAR(45),
COD:PROVINCIA NUMERIC(6)

CONSTRAINT PK_LOCALIDAD PRIMARY KEY (CODI),
CONSTRAINT fk_loc_prov FOREIGN KEY (COD_LOCALIDAD) REFERENCES LOCALIDAD (COD_LOCALIDAD)
);
