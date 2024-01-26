/* 1. Mostra el nom i cognom de tots els empleats. S'han de mostrar amb la primera lletra en majúscula i la resta en minúscules.*/
SELECT INITCAP(first_name), INITCAP(last_name)
FROM employees;

/* 2. Mostra els empleats que han sigut contractats durant el més de maig.*/
SELECT first_name, last_name
FROM employees
WHERE to_char(hire_date, 'mm') = '03'

/* 3. Mostra els oficis (job_title) diferents que hi ha a la base de dades.*/
SELECT job_title
FROM jobs;

/* 4. Calcula quants empleats hi ha en cada departament.*/
SELECT department_id, COUNT(employee_id)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

/* 5. Calcula quants empleats hi ha de cada tipus d'ocupació (JOB_ID).*/
SELECT j.job_title, COUNT(e.employee_id)
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY j.job_title;

/* 6. Mostra el número de països que tenen cadascun dels continents que tinguin com
identificador de regió 1,2 o 3.*/
SELECT r.region_name, COUNT(c.country_id)
FROM countries c, regions r
WHERE c.region_id IN (1, 2, 3) AND r.region_id = c.region_id
GROUP BY r.region_name;

/* 7. Mostra per cada manager el manager_id, el nombre d'empleats que té al seu carrec i la mitja dels salaris d'aquests empleats.*/
SELECT manager_id, COUNT(employee_id), AVG(salary)
FROM employees
GROUP BY manager_id;

/* 8. Mostra l’id del departament i el número d’empleats dels departaments amb més de 4 empleats.*/
SELECT department_id, COUNT(employee_id)
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 4;