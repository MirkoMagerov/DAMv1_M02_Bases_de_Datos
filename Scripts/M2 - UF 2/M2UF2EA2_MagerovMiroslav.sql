CREATE TABLE persona (
    dni VARCHAR (9),
    nom VARCHAR (15) NOT NULL,
    primer_cognom VARCHAR (15) NOT NULL,
    segon_cognom VARCHAR (15),
    adreça VARCHAR (20) NOT NULL,
    telefon INTEGER,

    CONSTRAINT pk_dni PRIMARY KEY (dni),
);

CREATE TABLE professor (
    dni VARCHAR (9),
    especialitat VARCHAR (20),

    CONSTRAINT pk_dni_prof PRIMARY KEY (dni),
    CONSTRAINT fk_dni_prof FOREIGN KEY (dni) REFERENCES persona(dni)
);

CREATE TABLE alumne (
    dni VARCHAR (9),
    data_naixement DATE NOT NULL,
    dni_delegat VARCHAR (9),

    CONSTRAINT pk_dni_al PRIMARY KEY (dni),
    CONSTRAINT fk_dni_al FOREIGN KEY (dni) REFERENCES alumne(dni),
    CONSTRAINT fk_dni_delegat FOREIGN KEY (dni_delegat) REFERENCES alumne(dni)
);

CREATE TABLE modul (
    codi_modul SMALLINT,
    nom VARCHAR (25) NOT NULL,
    numero_aula SMALLINT NOT NULL,

    CONSTRAINT pk_codi_modul PRIMARY KEY (codi_modul),
    CONSTRAINT fk_numero_aula FOREIGN KEY (numero_aula) REFERENCES aula(numero_aula)
);

CREATE TABLE assignatura (
    codi_assignatura SMALLINT,
    nom VARCHAR (25) NOT NULL,

    CONSTRAINT pk_codi_assignatura PRIMARY KEY (codi_assignatura)
);

CREATE TABLE aula (
    numero_aula SMALLINT,
    m2 FLOAT NOT NULL,

    CONSTRAINT pk_numero_aula PRIMARY KEY (numero_aula)
);

CREATE TABLE pertany (
    codi_modul SMALLINT,
    codi_assignatura SMALLINT,

    CONSTRAINT pk_codi_modul PRIMARY KEY (codi_modul, codi_assignatura),

    CONSTRAINT fk_codi_assignatura FOREIGN KEY (codi_assignatura) REFERENCES assignatura(codi_assignatura),
    CONSTRAINT fk_codi_modul FOREIGN KEY (codi_modul) REFERENCES modul(codi_modul)
);

CREATE TABLE ensenya (
    dni_professor VARCHAR (9),
    codi_assignatura SMALLINT,

    CONSTRAINT pk_ensenya PRIMARY KEY (dni_professor, codi_assignatura),

    CONSTRAINT fk_codi_assignatura FOREIGN KEY (codi_assignatura) REFERENCES assignatura(codi_assignatura),
    CONSTRAINT fk_dni_professor FOREIGN KEY (dni_professor) REFERENCES professor(dni)
);

CREATE TABLE matricula (
    dni_alumne VARCHAR (9),
    codi_assignatura SMALLINT,

    CONSTRAINT pk_matricula PRIMARY KEY (dni_alumne,codi_assignatura),

    CONSTRAINT fk_dni_alumne FOREIGN KEY (dni_alumne) REFERENCES alumne(dni),
    CONSTRAINT fk_codi_assignatura FOREIGN KEY (codi_assignatura) REFERENCES assignatura(codi_assignatura)
);