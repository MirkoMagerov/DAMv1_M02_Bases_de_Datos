/*  Exercici 1 BBDD residus
Mostra el codi de destí, la ciutat de destí, el NIF de la empresa productora, la ciutat de l’empresa productora i el
tractament que han fet servir les empreses productores que han traslladat la màxima quantitat (quantitat_trasllat)
fent servir un tractament del tipus "Segregació i lliurament". */
SELECT d.cod_desti, d.ciutat_desti, ep.nif_empresa, ep.ciutat_empresa, t.tractament
FROM desti d
JOIN trasllat t ON d.cod_desti = t.cod_desti
JOIN empresaproductora ep ON t.nif_empresa = ep.nif_empresa
WHERE t.nif_empresa IN (
    SELECT ep2.nif_empresa
    FROM empresaproductora ep2
    WHERE t.quantitat_trasllat >= ALL (
        SELECT MAX(t2.quantitat_trasllat)
        FROM trasllat t2));

/* Exercici 2 BBDD residus
Quin tipus de tractament s'ha fet servir menys durant l'any 2017 (utilitzarem la data d'enviament per comptar el
tractament menys utilitzat). Utilitza només subconsultes. */
SELECT tractament
FROM trasllat t
GROUP BY tractament
HAVING COUNT(data_enviament) <= ALL (
    SELECT COUNT(t2.data_enviament)
    FROM trasllat t2
    WHERE EXTRACT(YEAR FROM t2.data_enviament) = 2017);

/* Exercici 3 BBDD residus
Mostra quins són els dos envasos que s'han fet servir més vegades per traslladar els residus. Mostra els envasos i
el número de vegades que s’han fet servir. Utilitza només subconsultes. */
SELECT envas, COUNT(envas)
FROM trasllat t
WHERE t.nif_empresa IN (
    SELECT t2.nif_empresa
    FROM trasllat t2
    GROUP BY t2.nif_empresa
    HAVING COUNT(t2.envas) >= ALL (
        SELECT COUNT(t3.envas)
        FROM trasllat t3
        WHERE t3.nif_empresa = t2.nif_empresa))
GROUP BY envas
ORDER BY COUNT(envas) DESC
LIMIT 2;

/* Exercici 4 BBDD residus
Obtenir el nom de totes les ciutats a les que van a parar els residus que inclouen el constituent "Solucions
bàsiques o bases en forma sòlida". Mostra els resultats ordenats per ciutat destí. Utilitza només subconsultes. */
SELECT d.ciutat_desti
FROM desti d
WHERE d.cod_desti IN (
    SELECT t.cod_desti
    FROM trasllat t
    WHERE t.nif_empresa IN (
        SELECT rc.nif_empresa
        FROM residu_constituent rc
        WHERE rc.cod_constituent IN (
            SELECT c.cod_constituent
            FROM constituent c
            WHERE LOWER(c.nom_constituent) LIKE 'solucions bàsiques o bases en forma sòlida'
        )
    )
)
ORDER BY d.ciutat_desti;

/* Exercici 5 BBDD training
Mostrar l'identificador del client i el nom de l’empresa client dels clients on el límit de crèdit sigui més petit que
la suma de tots els imports de les comandes d'aquell client. Utilitza la subconsulta i no es pot agrupar. */
SELECT c.num_clie, c.empresa
FROM clientes c
WHERE c.limite_credito < (
    SELECT SUM(p.importe)
    FROM pedidos p
    WHERE p.clie = c.num_clie
    );

/* Exercici 6 BBDD training
Mostrar tots els camps d'aquelles oficines que tots els seus venedors tinguin unes vendes superiors a la suma dels
imports de totes les comandes. Utilitza subconsultes. */
SELECT o.*
FROM oficinas o, pedidos p
GROUP BY o.oficina
HAVING SUM(p.importe) <ALL (
    SELECT ventas
    FROM repventas rp
    WHERE o.oficina = rp.oficina_rep);

/* Exercici 7 BBDD training
Mostra el nom de l'empresa client, l'identificador i el nom del venedor assignat al client, i l’identificador i la
ciutat de l'oficina en la que treballa el venedor assignat al client en cas que aquest tingui una oficina assignada. */
SELECT c.empresa, c.num_clie, rp.nombre, rp.num_empl, o.ciudad
FROM clientes c
JOIN repventas rp ON c.rep_clie = rp.num_empl
JOIN oficinas o ON rp.oficina_rep = o.oficina;

/* Exercici 8 BBDD training
Revisa aquest exemple d’utilització de l’expressió condicional CASE, similar a IF/ELSE en altres llenguatges de
programació, en una consulta a la base de dades HR: */
SELECT COUNT(p.num_pedido),
CASE 
    WHEN COUNT(p.num_pedido) > THEN 'Gran Client'
    WHEN COUNT(p.num_pedido) >= 5 AND COUNT(p.num_pedido) <= 10 THEN 'Client mitja'
    ELSE 'Petit Client'
END
FROM pedidos p
WHERE p.clie = (
    SELECT c.num_clie
    FROM clientes c
    WHERE LOWER(c.empresa) LIKE 'zetacorp');