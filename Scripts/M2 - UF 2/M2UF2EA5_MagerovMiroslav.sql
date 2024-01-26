/* --------------------------- Ejercicio 1 --------------------------- */
CREATE TABLE IF NOT EXISTS fitxa (
    dni INTEGER NOT NULL,
    nom VARCHAR(30) NOT NULL,
    cognoms VARCHAR(70) NOT NULL,
    adreça VARCHAR(60),
    telefon VARCHAR(11),
    provincia VARCHAR(30),
    data_naix DATE DEFAULT CURRENT_DATE
);
ALTER TABLE fitxa
ADD CONSTRAINT pk_dni PRIMARY KEY (dni);

ALTER TABLE fitxa 
ADD cp VARCHAR(5);


/* --------------------------- Ejercicio 2 --------------------------- */
DROP TABLE fitxa;
ROLLBACK;
/* VOLVER A CREAR LA TABLA FITXA SIN AÑADIR EL CP */


/* --------------------------- Ejercicio 3 --------------------------- */
ALTER TABLE fitxa 
ADD equip INTEGER;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (3421232, 'LUIS MIGUEL', 'ACEDO GOMEZ', 'GUZMÁN EL BUENO, 90', '969-23-12-56', NULL, '05/05/1970', 1),
    (4864868, 'BEATRIZ' , 'SANCHO MANRIQUE', 'ZURRIAGA, 25', '93-232-12-12', 'BCN', '06/07/1978', 2);

ALTER TABLE fitxa
ALTER COLUMN telefon TYPE VARCHAR(12);


/* --------------------------- Ejercicio 4 --------------------------- */
BEGIN;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (7868544, 'JONÁS', 'ALMENDROS RODRÍGUEZ', 'FEDERICO PUERTAS, 3', '915478947', 'MADRID', '01/01/1987', 3),
    (8324216, 'PEDRO' , 'Martín Higuero', 'VIRGEN DEL CERRO, 154', '961522344', 'SORIA', '29/04/1978', 5);

ROLLBACK;


/* --------------------------- Ejercicio 5 --------------------------- */
BEGIN;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (14948992, 'SANDRA', 'MARTÍN GONZÁLEZ', 'PABLO NERUDA, 15', '916581515', 'MADRID', '05/05/1970', 6);

COMMIT;

BEGIN;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (15756214, 'MIGUEL', 'CAMARGO ROMÁN', 'ARMADORES, 1', '949488588', NULL, '12/12/1985', 7);

SAVEPOINT intA;

COMMIT;

BEGIN;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (21158230, 'SERGIO', 'ALFARO IBIRICU', 'AVENIDA DEL EJERCITO, 76', '934895855', 'BCN', '11/11/1987', 8),
    (34225234, 'ALEJANDRO' , 'ALCOCER JARABO', 'LEONOR DE CORTINAS, 7', '935321211', 'MADRID', '05/05/1970', 9);

SAVEPOINT intB;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (38624852, 'ALVARO', 'RAMÍREZ AUDIGE', 'FUENCARRAL, 33', '912451168', 'MADRID', '10/09/1976', 10);

SAVEPOINT intC;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (45824852, 'ROCÍO', 'PÉREZ DEL OLMO', 'CERVANTES, 22', '912332138', 'MADRID', '06/12/1987', 11),
    (48488588, 'JESÚS' , 'BOBADILLA SANCHO', 'GAZTAMBIQUE, 32', '913141111', 'MADRID', '05/05/1970', 13);

SAVEPOINT intD;

DELETE FROM fitxa WHERE DNI = '45824852';

SAVEPOINT intE;

UPDATE fitxa SET equip = '11' WHERE dni = '48488588';

SAVEPOINT intF;

ROLLBACK TO intE;

UPDATE fitxa SET equip = '11' WHERE dni = '38624852';

BEGIN;

INSERT INTO fitxa (dni, nom, cognoms, adreça, telefon, provincia, data_naix, equip)
VALUES
    (98987765, 'PEDRO', 'RUIZ RUIZ', 'SOL, 43', '91-656-43-32', 'MADRID', '10/09/1976', 12);

/* CERRAR SESIÓN PARA COMPROVAR QUE SIN UN COMMIT DESPUÉS DE UN BEGIN NO SE GUARDA */
/* VOLER DESDE EL ÚLTIMO BEGIN Y ACABAR CON UN COMIT PARA GUARDARLO PERMANENTEMENETE */

COMMIT;