/*                                             EXERCICI 1
-------------------------------------------------------------------------------------------------------
a) (1,5 punts). Escriu les sentències necessàries per crear les taules ORDERF, PRODUCT i
ORDER_DETAILS en la base de dades shop. tenint en compte les restriccions indicades en
l’estructura de la base de dades.
*/
CREATE TABLE IF NOT EXISTS orderf (
    order_id NUMERIC(12),
    order_date DATE,
    shipped_date DATE,
    ship_address VARCHAR(50) NOT NULL,
    ship_city VARCHAR(20),
    ship_region VARCHAR(20) 
);

ALTER TABLE orderf
ADD CONSTRAINT pk_order_id PRIMARY KEY (order_id),
ADD CONSTRAINT ck_ship_region CHECK (ship_region IN ('USA', 'EUROPA', 'ASIA', 'AMERICA', 'RUSIA')),
ADD CONSTRAINT ck_shipped_date CHECK (shipped_date > order_date);


CREATE TABLE IF NOT EXISTS product (
    product_id NUMERIC(12),
    product_name VARCHAR(50) NOT NULL,
    unitprice DOUBLE PRECISION NOT NULL,
    unitstock NUMERIC(3) NOT NULL,
    unitonorder NUMERIC(3) NOT NULL DEFAULT 1
);

ALTER TABLE product 
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);


CREATE TABLE IF NOT EXISTS order_details (
    order_id NUMERIC(12),
    product_id NUMERIC(12),
    quantity NUMERIC(3) NOT NULL,
    discount NUMERIC(3)
);

ALTER TABLE order_details
ADD CONSTRAINT pk_order_details PRIMARY KEY (order_id, product_id),
ADD CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES orderf(order_id),
ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES product(product_id);
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
b) (0,25 punts). Comprova que les 3 taules s'han creat correctament amb la comanda que mostra
la definició de les taules amb els camps de les taules, tipus de dades, etc.
*/
\d
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
c) (0,5 punts). Una vegada creades les taules, ens hem adonat que hi ha un error a la taula
ORDERF. Hem de modificar dos camps.
*/
ALTER TABLE orderf
ALTER COLUMN ship_city TYPE VARCHAR(40),
ALTER COLUMN ship_region TYPE VARCHAR(40);
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
d) (0,75 punts). Crea una seqüència perquè el camp product_id es pugui autoincrementar.
Que comenci per 1, que incrementi 1 i el valor màxim sigui 99999.
*/
CREATE SEQUENCE product_id_sec
    START 1
    INCREMENT 1
    MAXVALUE 99999;
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
e) (0,75 punts). Introdueix les següents dades a la taula PRODUCT. Utilitza la seqüencia
creada en l’exercici anterior i comprova que s’han inserit correctament els valors.
*/
INSERT INTO product (product_id, product_name, unitprice, unitstock, unitonorder)
VALUES
    (currval('product_id_sec'), 'nikkon ds90', 67.09, 75, 1),
    (nextval('product_id_sec'), 'canon t90', 82.82, 92, 1),
    (nextval('product_id_sec'), 'dell inspirion', 182.78, 56, 2),
    (nextval('product_id_sec'), 'ipad air', 482.83, 34, 2),
    (nextval('product_id_sec'), 'microsoft surface', 93.84, 92, 2),
    (nextval('product_id_sec'), 'nexus 6', 133.88, 16, DEFAULT),
    (nextval('product_id_sec'), 'thinkpad t365', 341.02, 22, DEFAULT);
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
f) (0,75 punts). Intenta inserir els següents registres a la taula ORDERF. La informació que
ha de contenir la taula és la següent:
*/
INSERT INTO orderf (order_id, order_date, shipped_date, ship_address, ship_city, ship_region)
VALUES
    (4001, '2016-04-04', '2016-11-06', '93 Spohn Place', 'Manggekompo', 'ASIA'),
    (4002, '2017-01-29', '2016-05-28', '46 Eliot Trail', 'Virginia', 'USA'),
    (4001, '2016-08-19', '2016-12-08', '23 Sundown Junction', 'Obodivka', 'RUSIA'),
    (4004, '2016-09-25', '2016-12-24', NULL, 'Nova Venécia', 'AMERICA'),
    (4005, '2017-03-14', '2017-03-19', '7 Ludington Court', 'Sukamaju', 'ASIA'),
    (4006, '2016-08-14', '2016-12-05', '859 Dahle Plaza', 'Manggekompo', 'ASIA'),
    (4007, '2017-01-02', '01-02-2017', '5 Fuller Center Log pri', 'Brezovici', 'EUROP');
/* ERRORES
La fila con order_id 4002 falla la restricción del check de las fechas, ya que order_date es menor que shipped_date.
También falla el 4004, ya que ship_address debe ser NOT NULL.
Y el order_id 4007 tiene la fecha en un formato incorrecto.
*/
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
g) (0,75 punts) Intenta inserir els següents registres a la taula ORDER_DETAILS. La infor-
mació que ha de contenir la taula és la següent:
*/
INSERT INTO order_details (order_id, product_id, quantity, discount)
VALUES
    (4001, 1, 5, 8.73),
    (4003, 3, 8, 4.01),
    (4005, 601, 2, 3.05),
    (4006, 2, 4, 5.78);
/* ERRORES
El campo discount es numeric, pero para aceptar los valores introducidos deberia de ser un tipo de campo que acepte decimales.
*/
ALTER TABLE order_details
ALTER COLUMN discount TYPE DOUBLE PRECISION;
-------------------------------------------------------------------------------------------------------




/*                                            EXERCICI 2
-------------------------------------------------------------------------------------------------------
a) (0,25 punts). Crea un índex per la taula ORDERF, pel camp ship_address.
*/
CREATE INDEX ship_address_idx ON orderf(ship_address);
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
b) (0,5 punts). Crea un índex únic per la taula PRODUCT, pel camp product_name.
*/
CREATE UNIQUE INDEX product_name_idx ON product(product_name);
-------------------------------------------------------------------------------------------------------




/*                                            EXERCICI 3
-------------------------------------------------------------------------------------------------------
a) (1 punt). Afegeix els següents camps a la taula ORDERF:
*/
ALTER TABLE orderf
ADD COLUMN cost_ship DOUBLE PRECISION DEFAULT 1500,
ADD COLUMN logistic_cia VARCHAR(100),
ADD COLUMN others VARCHAR(250);

/* El camp logistic_cia només pot contenir una de les següents empreses de transport:
UPS,MRW,Post_Office,Fedex,TNT,DHL,Moldtrans,SEUR. */
ALTER TABLE orderf
ADD CONSTRAINT ck_logistic_cia CHECK (logistic_cia IN ('UPS', 'MRW', 'Post_Office', 'Fedex', 'TNT', 'DHL', 'Moldtrans', 'SEUR'));
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
b) (0,5 punts). Elimina el camp others de la taula ORDERF.
*/
ALTER TABLE orderf
DROP COLUMN others;
-------------------------------------------------------------------------------------------------------




/*                                            EXERCICI 4
-------------------------------------------------------------------------------------------------------

a) (0,5 punts). Modifica els valors del camp discount de la taula ORDER_DETAILS dels
registres que la quantitat sigui més gran que 2. El nou descompte serà 7.5. Comprova que s'ha
efectuat el canvi.
*/
BEGIN

UPDATE order_details
SET discount = 7.5 WHERE quantity > 2;
-------------------------------------------------------------------------------------------------------

/*
-------------------------------------------------------------------------------------------------------
b) (0,25 punts) desfés els canvis que has fet en l'apartat anterior i comprova si s'han desfet.
*/
ROLLBACK;

/*
-------------------------------------------------------------------------------------------------------
c) (0,5 punts) Elimina els productes que tinguin un unitstock < 30 i fes que els canvis siguin
permanents.
*/
DELETE FROM product WHERE unitstock < 30;
-------------------------------------------------------------------------------------------------------

/*
d) (1,25 punt) Elimina la comanda de la taula ORDERF amb order_id = 4006. Si no la pots
eliminar explica perquè no pots, i realitza les modificacions que siguin necessàries a les tau-
les perquè la puguis eliminar. Comprova que realment s'ha eliminat la comanda.
*/
DELETE FROM order_details WHERE order_id = 4006;
-------------------------------------------------------------------------------------------------------