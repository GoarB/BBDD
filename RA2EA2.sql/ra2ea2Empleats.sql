Create role empleats superuser createdb createrole inherit login replication;
ALTER user empleats with password 'empleats';
CREATE database empleats with owner empleats;
GRANT ALL PRIVILEGES ON DATABASE empleats TO empleats;

CREATE TABLE IF NOT EXISTS EMPLEAT (
ID NUMERIC(6),
DNI VARCHAR(9),
NOMBRE VARCHAR(15),
FECHA_NAC DATE,
TELEFON NUMERIC (18),
SALARIO NUMERIC (18,5),
COD:LOCALIDAD NUMERIC(10),

CONSTRAINT pk_empleat PRIMARY KEY (ID),
CONSTRAINT fk_emp_loc FOREIGN KEY (COD_LOCALIDAD) REFERENCES LOCALIDAD (COD_LOCALIDAD),
CONSTRAINT uq_dni UNIQUE (DNI)
);
