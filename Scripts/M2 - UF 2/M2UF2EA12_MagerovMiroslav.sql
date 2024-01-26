/* 1. Mostra els noms dels oficis (job_title) dels empleats que treballen al departament 80.*/
SELECT job_title
FROM jobs
WHERE job_id IN (
    SELECT job_id
    FROM employees
    WHERE department_id = 80
);

/* 2. Mostra els noms de departaments que tinguin empleats.*/
SELECT department_name
FROM departments
WHERE department_id IN (
    SELECT employee_id
    FROM employees
    WHERE department_id IS NOT NULL
)

/* 3. Mostra els cognoms els empleats que tenen un salari inferior al salari mitjà dels empleats
que són representants de vendes (job_id=’SA_MAN’).*/
SELECT last_name
FROM employees
WHERE salary < (
    SELECT AVG(e.salary)
    FROM employees e, jobs j
    WHERE UPPER(j.job_id) LIKE 'SA_MAN'
)

/* 4. Mostra els noms països que estan al mateix continent que Argentina.*/
SELECT country_name
FROM countries
WHERE region_id IN (
    SELECT region_id
    FROM countries
    WHERE UPPER(country_name) LIKE 'ARGENTINA'
);

/* 5. Mostra el noms i els cognoms de tots els empleats amb el mateix ofici que David Austin.*/
SELECT first_name, last_name
FROM employees
WHERE job_id IN (
    SELECT job_id
    FROM employees
    WHERE UPPER(first_name) LIKE 'DAVID' AND UPPER(last_name) LIKE 'AUSTIN'
)

/* 6. Mostra els noms dels països d'Àsia o Europa.*/
SELECT country_name
FROM countries
WHERE region_id IN (
    SELECT region_id
    FROM regions
    WHERE UPPER(region_name) IN ('ASIA', 'EUROPE')
);

/* 7. Mostra els cognoms dels empleats que el seu nom comença per H i el seu salari
és més gran que algun empleat del departament 100.*/
SELECT last_name
FROM employees
WHERE last_name LIKE 'H%' AND salary > ANY (
    SELECT salary
    FROM employees
    WHERE department_id = 100
);

/* 8. Mostra els cognoms d'aquells empleats que no treballen al departament de Marketing ni al
de vendes.*/
SELECT e.last_name
FROM employees e
WHERE department_id NOT IN (
    SELECT d.department_id
    FROM departments d
    WHERE UPPER(d.department_name) IN ('MARKETING', 'SALES')
);