/* 1. Mostra el nom de l’empleat, el nom del departament on treballa i l'id del seu cap. Fes servir
primer JOIN i USING i després o resols amb JOIN ON.*/
SELECT e.first_name, d.department_name, e.manager_id
FROM employees e
JOIN departments d USING (department_id);

SELECT e.first_name, d.department_name, e.manager_id
FROM employees e
JOIN departments d ON d.department_id = e.department_id;

/* 2. Mostra la ciutat i el nom del departament de la localització 1400 (LOCATION_ID=1400).
Primer ho resols fent servir JOIN ON i després fent servir JOIN USING.*/
SELECT l.city, d.department_name
FROM departments d
JOIN locations l USING (location_id)
WHERE l.location_id = 1400;

SELECT l.city, d.department_name
FROM departments d
JOIN locations l ON l.location_id = d.location_id AND l.location_id = 1400;

/* 3. Mostra el cognom i la data de contractació de qualsevol empleat contractat després de
l’empleat Davies. Fes servir JOIN.*/
SELECT e.last_name, e.hire_date
FROM employees e
JOIN employees d ON d.hire_date < e.hire_date AND LOWER(d.last_name) LIKE 'davies';

/* 4. Mostra el nom i cognom dels empleats, el nom del departament on treballen i el nom de la
ciutat on es troba el departament. Fes servir primer JOIN i USING i després o resols amb
JOIN ON.*/
SELECT e.first_name, e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d ON d.department_id = e.department_id JOIN locations l ON d.location_id = l.location_id;

SELECT e.first_name, e.last_name, d.department_name, l.city
FROM employees e
JOIN departments d USING(department_id) JOIN locations l USING(location_id);

/* 5. Mostra l'id del departament i el cognom de l’empleat de tots els empleats que treballin al
mateix departament que un empleat donat. Assignar a cada columna una etiqueta adequada.
Fes servir JOIN.*/
SELECT e.department_id, e.last_name
FROM employees e
JOIN employees d ON e.department_id = d.department_id AND LOWER(d.last_name) LIKE 'kochhar';