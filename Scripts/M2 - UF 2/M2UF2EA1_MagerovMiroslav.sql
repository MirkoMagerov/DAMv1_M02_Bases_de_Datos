CREATE TABLE empleado (
    id INTEGER NOT NULL,
    dni VARCHAR (9) UNIQUE,
    nombre VARCHAR (50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    telefono INTEGER,
    salario FLOAT NOT NULL,
    cod_localidad VARCHAR(10) NOT NULL,

    CONSTRAINT pk_id PRIMARY KEY (id),
    CONSTRAINT fk_cod_localidad FOREIGN KEY (cod_localidad) REFERENCES localidad(cod_localidad)
);

CREATE TABLE localidad (
    cod_localidad VARCHAR(10) NOT NULL,
    nombre VARCHAR NOT NULL,
    cod_provincia INTEGER NOT NULL,

    CONSTRAINT pk_cod_localidad PRIMARY KEY (cod_localidad),
    CONSTRAINT fk_cod_provincia FOREIGN KEY (cod_provincia) REFERENCES provincia(cod_provincia)
);

CREATE TABLE provincia (
    cod_provincia INTEGER NOT NULL,
    nombre VARCHAR NOT NULL,
    cod_region INTEGER NOT NULL,

    CONSTRAINT pk_cod_provincia PRIMARY KEY (cod_provincia),
    CONSTRAINT fk_cod_region FOREIGN KEY (cod_region) REFERENCES region(cod_region)
);

CREATE TABLE region (
    cod_region INTEGER NOT NULL,
    nombre VARCHAR NOT NULL,

    CONSTRAINT pk_cod_region PRIMARY KEY (cod_region)
);