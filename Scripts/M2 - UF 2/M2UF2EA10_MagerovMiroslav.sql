/* 1. Mostra per cada cap (manager_id), la suma dels salaris dels seus empleats, però només, per
aquells casos en els quals la mitja del salari dels seus empleats sigui més gran que 3000.*/
SELECT manager_id, AVG(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING AVG(salary) > 3000;

/* 2. Mostra per cada cap (manager_id) quants empleats tenen al seu carrec i quin és el salari
màxim, però només per aquells caps amb més de 6 empleats al seu càrrec.*/
SELECT manager_id, MAX(salary), COUNT(employee_id)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(employee_id) > 6;

/* 3. Fes al mateix que a la consulta anterior, però només per aquells caps que tinguin com a
id_manager_id 100, 121 o 122. Ordena els resultats per manager_id.*/
SELECT manager_id, MAX(salary), COUNT(employee_id)
FROM employees
WHERE manager_id IN ('100', '121', '122')
GROUP BY manager_id
HAVING COUNT(employee_id) > 6
ORDER BY manager_id;

/* 4. Calcular el nombre empleats que realitzen cada ofici a cada departament.
Les dades que es visualitzen són: codi del departament, ofici i nombre empleats.*/
SELECT d.department_id, j.job_title, COUNT(employee_id)
FROM departments d, employees e, jobs j
WHERE j.job_id = e.job_id AND d.department_id = e.department_id
GROUP BY d.department_id, j.job_title;

/* 5. Mostra el nom del departament i el número d'emplets que té cada departament.*/
SELECT d.department_name, COUNT(e.employee_id)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id;

/* 6. Mostra el número d'empleats del departamant de 'SALES'.*/
SELECT COUNT(e.employee_id)
FROM employees e, departments d
WHERE UPPER(d.department_name) LIKE 'SALES' AND e.department_id = d.department_id;

/* 7. Mostra quants departaments diferents hi ha a Seattle.*/
SELECT COUNT(d.department_id)
FROM departments d, locations l
WHERE d.location_id = l.location_id AND UPPER(l.city) LIKE 'SEATTLE';