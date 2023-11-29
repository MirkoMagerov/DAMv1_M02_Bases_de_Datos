/* 1. Mostra els departaments que el salari mitja dels seus reballadors és major o igual que la mitja de tots els salaris.*/
SELECT d.department_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) >= (
    SELECT AVG(c.salary)
    FROM employees c
);

/* 2. Mostra el nom del departament que gasta més diners en les nòmines dels seus empleats i quants són aquests diners.*/
SELECT d.department_name, SUM(e.salary * e.commission_pct) AS Nomina
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id
HAVING SUM(e.salary * e.commission_pct) >= (
    SELECT SUM(c.salary * c.commission_pct)
    FROM employees c
    WHERE d.department_id = c.department_id
);

/* 3. Mostra els noms i cognoms dels empleats més antics de cada departament.*/
SELECT e.first_name, e.last_name
FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE NOT EXISTS (
    SELECT e2.hire_date
    FROM employees e2
    WHERE e2.department_id = d.department_id
    AND e2.hire_date < e.hire_date);

/* 4. Mostra totes les dades d'aquells departaments que tinguin empleats que hagin finalitzat el seu contracte entre el gener de l'any 1992 i el desembre de l'any 2001.*/
SELECT d.*
FROM departments d
JOIN job_history j ON d.department_id = j.department_id
WHERE j.end_date BETWEEN ('1992-1-1', '2001-12-1');