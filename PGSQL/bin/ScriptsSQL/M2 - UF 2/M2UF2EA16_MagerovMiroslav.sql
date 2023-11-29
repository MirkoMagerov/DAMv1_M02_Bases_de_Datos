/*  Exercici 1 BBDD residus
Mostra el codi de destí, la ciutat de destí, el NIF de la empresa productora, la ciutat de l’empresa productora i el
tractament que han fet servir les empreses productores que han traslladat la màxima quantitat (quantitat_trasllat)
fent servir un tractament del tipus "Segregació i lliurament". */
SELECT d.cod_desti, d.ciutat_desti, ep.nif_empresa, ep.ciutat_empresa, t.tractament
FROM desti d
JOIN empresaproductora ep ON

/* Exercici 2 BBDD residus
Quin tipus de tractament s'ha fet servir menys durant l'any 2017 (utilitzarem la data d'enviament per comptar el
tractament menys utilitzat). Utilitza només subconsultes. */


/* Exercici 3 BBDD residus
Mostra quins són els dos envasos que s'han fet servir més vegades per traslladar els residus. Mostra els envasos i
el número de vegades que s’han fet servir. Utilitza només subconsultes. */


/* Exercici 4 BBDD residus
Obtenir el nom de totes les ciutats a les que van a parar els residus que inclouen el constituent "Solucions
bàsiques o bases en forma sòlid". Mostra els resultats ordenats per ciutat destí. Utilitza només subconsultes. */


/* Exercici 5 BBDD training
Mostrar l'identificador del client i el nom de l’empresa client dels clients on el límit de crèdit sigui més petit que
la suma de tots els imports de les comandes d'aquell client. Utilitza la subconsulta i no es pot agrupar. */


/* Exercici 6 BBDD training
Mostrar tots els camps d'aquelles oficines que tots els seus venedors tinguin unes vendes superiors a la suma dels
imports de totes les comandes. Utilitza subconsultes. */


/* Exercici 7 BBDD training
Mostra el nom de l'empresa client, l'identificador i el nom del venedor assignat al client, i l’identificador i la
ciutat de l'oficina en la que treballa el venedor assignat al client en cas que aquest tingui una oficina assignada. */


/* Exercici 8 BBDD training
Revisa aquest exemple d’utilització de l’expressió condicional CASE, similar a IF/ELSE en altres llenguatges de
programació, en una consulta a la base de dades HR: */