/* 1. Mostra totes les dades dels empleats que el seu lloc de feina sigui Sales Manager.*/
SELECT e.*, j.job_title
FROM employees e, jobs j
WHERE j.job_title LIKE 'Sales Manager';

/* 2. Mostra els departaments que tinguin empleats que hagin finalitzat el seu contracte a l'any 1998.*/
SELECT d.department_name
FROM departments d, job_history jh
WHERE TO_CHAR(jh.end_date, 'YYYY') = '1998'
GROUP BY d.department_name;

/* 3. Mostra els noms dels departaments en els que hi treballin empleats amb noms que
comencen per la lletra A.*/
SELECT d.department_name
FROM departments d, employees e
WHERE LOWER(e.first_name) LIKE 'a%'
GROUP BY d.department_name;

/* 4. Mostra el nom del departament, el nom i el cognom dels empleats que el seu departament
no sigui IT.*/
SELECT d.department_name, e.first_name, e.last_name
FROM departments d, employees e
WHERE d.department_name NOT LIKE 'it';

/* 5. Mostra totes les dades dels departaments que es troben a Seattle.*/
SELECT d.*, l.city
FROM departments d, locations l
WHERE LOWER(l.city) LIKE 'seattle';

/* 6. Mostra el nom, el cognom i el nom del departament dels empleats que treballen a Seattle.*/
SELECT e.first_name, e.last_name, d.department_name
FROM employees e, departments d, locations l
WHERE LOWER(l.city) LIKE 'seattle';

/* 7. Mostra el nom del departament i totes les dades dels empleats que no treballen en el
departament de Marketing ni el de vendes (Sales).*/
SELECT d.department_name, e.*
FROM departments d, employees e
WHERE (LOWER(department_name) NOT IN ('marketing', 'sales'));

/* 8. Mostra els noms de tots els departaments i la ciutat i país on estiguin ubicats.*/
SELECT d.department_name, c.country_name, l.city
FROM departments d, countries c, locations l
WHERE l.country_id = c.country_id;

/* 9. Mostra els noms dels països (country_name) i el nom del continent (region_name) d'Àsia i Europa.*/
SELECT c.country_name, r.region_name
FROM countries c, regions r
WHERE c.region_id = r.region_id AND (LOWER(r.region_name) IN ('asia', 'europe'));

/* 10. Mostra el cognom i el job_id dels empleats que tinguin el mateix ofici que el seu cap i mostra el nom del cap.*/
SELECT e.last_name, e.job_id, m.job_id, m.manager_id, m.last_name
FROM employees e, employees m
WHERE e.manager_id = m.employee_id AND e.job_id = m.job_id;

/* 11. Mostra el cognom dels empleats que tinguin el mateix ofici que el seu cap, el nom del cap i mostra també el nom de l'ofici (job_title).*/
SELECT e.last_name, m.last_name, j.job_title
FROM employees e, employees m, jobs j
WHERE e.manager_id = m.employee_id AND e.job_id = m.job_id AND m.job_id = j.job_id;