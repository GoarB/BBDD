Create role proveidors superuser createdb createrole inherit login replication;
ALTER user proveidors with password 'proveidors';
CREATE database proveidors with owner proveidors;
GRANT ALL PRIVILEGES ON DATABASE proveidors TO proveidors;

CREATE TABLE IF NOT EXISTS fabricant (
COD_FABRICANT NUMERIC(3) not null,
NOM VARCHAR(15),
PAIS VARCHAR(15),

CONSTRAINT pk_fabricant PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS article (
COD_ARTICLE VARCHAR(20) not null,
COD_FABRICANT NUMERIC(3),
PES NUMERIC(3),
CATEGORIA VARCHAR(10),
PREU_VENDA DECIMAL(6,2),
PREU_COST DECIMAL(6,1),
STOCK NUMERIC(5),

CONSTRAINT pk_proveidors PRIMARY KEY (ID)
);
