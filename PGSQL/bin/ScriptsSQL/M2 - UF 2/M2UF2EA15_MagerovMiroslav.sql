/* 1. Mostra el nom dels venedors que tinguin una quota igual o inferior al objectiu de la oficina
de vendes d'Atlanta. (Utilitza la subconsulta). */
SELECT rp.nombre
FROM repventas rp
JOIN oficinas o ON rp.oficina_rep = o.oficina
WHERE o.objetivo >=ANY (
    SELECT rp2.cuota
    FROM repventas rp2, oficinas o2
    WHERE LOWER(o2.ciudad) LIKE 'atlanta');

/* 2. Mostra Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han
fet comanda amb) Bill Adams. (Utilitza només subconsultes). */
SELECT c.num_clie, c.empresa
FROM clientes c
WHERE c.rep_clie = (
    SELECT rp.num_empl
    FROM repventas rp
    WHERE LOWER(rp.nombre) LIKE 'bill adams');


/* 3. Mostra els noms dels venedors i les seves quotes dels venedors amb quotes que siguin
iguals o superiors a l'objectiu de la seva oficina de vendes. Fes-ho primer amb una
subconsulta i després amb un JOIN. */
SELECT rp.nombre, rp.cuota
FROM repventas rp
JOIN oficinas o ON rp.oficina_rep = o.oficina
WHERE rp.cuota >= o.objetivo;

SELECT rp.nombre, rp.cuota
FROM repventas rp
WHERE rp.oficina_rep =ANY (
    SELECT o.oficina
    FROM oficinas o
    WHERE o.objetivo <= rp.cuota);

/* 4. Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu de vendes de
l'oficina excedeix la suma de quotes dels venedors d'aquella oficina. (Utilitza la subconsulta). */
SELECT o.oficina, o.ciudad
FROM oficinas o
WHERE o.objetivo > (
    SELECT SUM(rp2.cuota)
    FROM repventas rp2
    WHERE rp2.oficina_rep = o.oficina);

/* 5. Mostra l'identificador del fabricant com a "Fabricant", l'identificador del profucte com a
"codi Producte", la descripció i les existèncie dels productes del fabricant amb identificador
"aci" que les existències superen les existències del producte amb identificador de producte
"41004". (Utilitza la subconsulta). */
SELECT prod.id_fab AS "Fabricant", prod.id_producto AS "Codi Producte",
       prod.descripcion, prod.existencias
FROM productos prod
WHERE prod.id_fab IN (
    SELECT prod2.id_fab
    FROM productos prod2
    WHERE LOWER(prod2.id_fab) LIKE 'aci' AND prod2.existencias > (
        SELECT prod3.existencias
        FROM productos prod3
        WHERE prod3.id_producto = '41004'));

/* 6. Mostra l’identificador d’empleat i el nom dels venedors que han acceptat una comanda que
representa més del 10% de la seva quota. Fes-ho primer amb una subconsulta i després amb
un consluta multitaula (sense el JOIN). */
SELECT rp.num_empl, rp.nombre
FROM repventas rp
WHERE rp.num_empl IN (
    SELECT p.rep
    FROM pedidos p
    WHERE p.clie IN (
        SELECT c.num_clie
        FROM clientes c
        WHERE p.importe > (rp.cuota * 10) / 100 AND p.rep = rp.num_empl));

SELECT rp.num_empl, rp.nombre
FROM repventas rp, oficinas o, pedidos p
WHERE rp.oficina_rep = o.oficina AND p.importe > (rp.cuota * 10) / 100 AND p.rep = rp.num_empl;

/* 7. Mostra el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una
oficina. Utilitza el test d'existència. */
SELECT rp.nombre, rp.edad
FROM repventas rp
WHERE NOT EXISTS (
    SELECT rp2.director
    FROM repventas rp2
    WHERE rp.num_empl = rp2.director);