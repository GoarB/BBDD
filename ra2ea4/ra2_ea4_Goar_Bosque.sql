CREATE ROLE cadastre LOGIN PASSWORD 'cadastre';
CREATE DATABASE cadastre WITH OWNER cadastre;
GRANT ALL PRIVILEGES ON DATABASE cadastre TO cadastre;

CREATE TABLE IF NOT EXISTS ZonaUrbana (
    nom_zona VARCHAR(60) NOT NULL,

    CONSTRAINT pk_zonaurbana
        PRIMARY KEY (nom_zona),

    CONSTRAINT ck_zonaurbana_nom
        CHECK (nom_zona = UPPER(nom_zona))
);

CREATE TABLE IF NOT EXISTS Vivenda (
    tipus_vivenda VARCHAR(1),
    codi_postal NUMERIC(5) DEFAULT 00001,
    metres NUMERIC(5),
    nom_zona VARCHAR(60),
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,

    CONSTRAINT pk_vivenda
        PRIMARY KEY (carrer, nombre),

    CONSTRAINT fk_vivenda_zona
        FOREIGN KEY (nom_zona)
        REFERENCES ZonaUrbana (nom_zona),

    CONSTRAINT ck_vivenda_carrer
        CHECK (
            carrer = UPPER(LEFT(carrer, 1))
            || LOWER(SUBSTRING(carrer FROM 2))
        ),

    CONSTRAINT ck_vivenda_nombre
        CHECK (nombre > 0),

    CONSTRAINT ck_vivenda_tipus
        CHECK (tipus_vivenda IN ('C', 'B'))
);

CREATE TABLE IF NOT EXISTS Persona (
    nom_persona VARCHAR(20),
    cognoms_persona VARCHAR(40),
    dni_c VARCHAR(12),
    carrer VARCHAR(80),
    nombre NUMERIC(4),
    dni VARCHAR(12) NOT NULL,

    CONSTRAINT pk_persona
        PRIMARY KEY (dni),

    CONSTRAINT fk_persona_vivenda
        FOREIGN KEY (carrer, nombre)
        REFERENCES Vivenda (carrer, nombre),

    CONSTRAINT fk_persona_persona
        FOREIGN KEY (dni_c)
        REFERENCES Persona (dni)
);


CREATE TABLE IF NOT EXISTS BlocCases (
    metres_b NUMERIC(4),
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,

    CONSTRAINT pk_bloccases
        PRIMARY KEY (carrer, nombre),

    CONSTRAINT fk_bloccases_vivenda
        FOREIGN KEY (carrer, nombre)
        REFERENCES Vivenda (carrer, nombre)
        ON DELETE CASCADE,

    CONSTRAINT ck_bloccases_metres
        CHECK (metres_b > 0)
);

CREATE TABLE IF NOT EXISTS CasaParticular (
    metres_c NUMERIC(4),
    dni_cp VARCHAR(12),
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,

    CONSTRAINT pk_casaparticular
        PRIMARY KEY (carrer, nombre),

    CONSTRAINT fk_casaparticular_persona
        FOREIGN KEY (dni_cp)
        REFERENCES Persona (dni),

    CONSTRAINT fk_casaparticular_vivenda
        FOREIGN KEY (carrer, nombre)
        REFERENCES Vivenda (carrer, nombre)
        ON DELETE CASCADE,

    CONSTRAINT ck_casaparticular_metres
        CHECK (metres_c > 0)
);

CREATE TABLE IF NOT EXISTS Pis (
    metres_p NUMERIC(4),
    dni_p VARCHAR(12),
    carrer VARCHAR(80) NOT NULL,
    nombre NUMERIC(4) NOT NULL,
    escala VARCHAR(1) NOT NULL,
    planta NUMERIC(2) NOT NULL,
    porta VARCHAR(2) NOT NULL,

    CONSTRAINT pk_pis
        PRIMARY KEY (
            carrer,
            nombre,
            escala,
            planta,
            porta
        ),

    CONSTRAINT fk_pis_bloccases
        FOREIGN KEY (carrer, nombre)
        REFERENCES BlocCases (carrer, nombre)
        ON DELETE CASCADE,

    CONSTRAINT fk_pis_persona
        FOREIGN KEY (dni_p)
        REFERENCES Persona (dni)
        ON DELETE CASCADE,

    CONSTRAINT ck_pis_metres
        CHECK (metres_p > 0)
);

CREATE TABLE IF NOT EXISTS HabitaPis (
    carrer VARCHAR(80),
    nombre NUMERIC(4),
    escala VARCHAR(1),
    planta NUMERIC(2),
    porta VARCHAR(2),
    dni VARCHAR(12) NOT NULL,

    CONSTRAINT pk_habitapis
        PRIMARY KEY (dni),

    CONSTRAINT fk_habitapis_persona
        FOREIGN KEY (dni)
        REFERENCES Persona (dni),

    CONSTRAINT fk_habitapis_pis
        FOREIGN KEY (
            carrer,
            nombre,
            escala,
            planta,
            porta
        )
        REFERENCES Pis (
            carrer,
            nombre,
            escala,
            planta,
            porta
        )
        ON DELETE CASCADE
);