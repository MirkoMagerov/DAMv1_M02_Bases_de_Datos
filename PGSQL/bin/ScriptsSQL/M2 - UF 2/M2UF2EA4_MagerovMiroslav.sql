CREATE TABLE IF NOT EXISTS fabricant (
    cod_fabricant SMALLINT NOT NULL,
    nom VARCHAR(15),
    pais VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS article (
    cod_article VARCHAR(20),
    cod_fabricant SMALLINT,
    pes SMALLINT,
    categoria VARCHAR(10),
    preu_venda FLOAT(6,2),
    preu_cost FLOAT(6,2),
    stock SMALLINT
);

ALTER TABLE fabricant
    ADD PRIMARY KEY (cod_fabricant),
    ADD CONSTRAINT chk_nom CHECK (upper(nom) = nom),
    ADD CONSTRAINT chk_pais CHECK (upper(pais) = pais);

ALTER TABLE article
    ADD PRIMARY KEY (cod_article, cod_fabricant, pes, categoria),
    ADD CONSTRAINT fk_cod_fabricant FOREIGN KEY (cod_fabricant) REFERENCES fabricant(cod_fabricant),
    ADD CONSTRAINT chk_pes CHECK (pes > 0),
    ADD CONSTRAINT chk_preu_venda CHECK (preu_venda > 0),
    ADD CONSTRAINT chk_preu_cost CHECK (preu_cost > 0),
    ADD CONSTRAINT chk_categoria CHECK (categoria IN('Primera', 'Segona', 'Tercera'));