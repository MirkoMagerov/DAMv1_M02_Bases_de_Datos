/*  Exercici 1 BBDD residus
Mostra el codi de destí, la ciutat de destí, el NIF de la empresa productora, la ciutat de l’empresa productora i el
tractament que han fet servir les empreses productores que han traslladat la màxima quantitat (quantitat_trasllat)
fent servir un tractament del tipus "Segregació i lliurament". */
/* NO VA */
SELECT d.cod_desti, d.ciutat_desti, ep.nif_empresa, ep.ciutat_empresa, t.tractament
FROM desti d
JOIN trasllat t USING (cod_desti)
JOIN empresaproductora ep USING (nif_empresa)
WHERE LOWER(t.tractament) LIKE 'segregacio i lliurament';

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
bàsiques o bases en forma sòlid". Mostra els resultats ordenats per ciutat destí. Utilitza només subconsultes. */
 /* NO VA */
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
            WHERE LOWER(c.nom_constituent) LIKE 'solucions bàsiques o bases en forma sòlid'
        )
    )
)
ORDER BY d.ciutat_desti;

/* Exercici 5 BBDD training
Mostrar l'identificador del client i el nom de l’empresa client dels clients on el límit de crèdit sigui més petit que
la suma de tots els imports de les comandes d'aquell client. Utilitza la subconsulta i no es pot agrupar. */
/* NO VA */
SELECT c.num_clie, c.empresa
FROM clientes c
WHERE c.num_clie IN (
    SELECT p.clie
    FROM pedidos p
    WHERE c.limite_credito < p.importe);

/* Exercici 6 BBDD training
Mostrar tots els camps d'aquelles oficines que tots els seus venedors tinguin unes vendes superiors a la suma dels
imports de totes les comandes. Utilitza subconsultes. */
SELECT o.*
FROM oficinas o
JOIN repventas rv ON o.oficina = rv.oficina_rep
GROUP BY o.oficina
HAVING SUM(rv.ventas) > (
    SELECT SUM(p.importe)
    FROM pedidos p, repventas rv2
    WHERE rv2.num_empl = p.rep );

/* Exercici 7 BBDD training
Mostra el nom de l'empresa client, l'identificador i el nom del venedor assignat al client, i l’identificador i la
ciutat de l'oficina en la que treballa el venedor assignat al client en cas que aquest tingui una oficina assignada. */


/* Exercici 8 BBDD training
Revisa aquest exemple d’utilització de l’expressió condicional CASE, similar a IF/ELSE en altres llenguatges de
programació, en una consulta a la base de dades HR: */