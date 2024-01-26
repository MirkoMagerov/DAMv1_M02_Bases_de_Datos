/* Exercici 1. Crea un bloc anònim que ha d'imprimir el cognom de l'empleat en majúscules amb codi número 104 de la taula (EMPLOYEES), on has de declarar una variable de tipus last_name. */
do $$
    declare
        cognom EMPLOYEES.last_name%TYPE;

    begin
        SELECT last_name
        INTO cognom
        FROM employees
        WHERE employee_id = 104;
        raise notice 'El cognom és %', UPPER(cognom);
    end;
$$


/* Exercici 2. Crea un bloc anònim que ha d'imprimir el cognom de l'empleat en majúscules del id de l’empleat introdueixi per pantalla. */
do $$
    declare
        cognom EMPLOYEES.LAST_NAME%TYPE;
    begin
        SELECT last_name
        INTO cognom
        FROM employees
        WHERE employee_id = :"Id del empleado";
        raise notice 'El cognom és %', UPPER(cognom);
    end;
$$


/* Exercici 3. Crea un bloc anònim amb variables PL/SQL que mostri el salari de l'empleat amb id=120, has de declarar una variable de tipus salary. */
do $$
    declare
        salario EMPLOYEES.salary%TYPE;
    begin
        SELECT salary
        INTO salario
        FROM employees
        WHERE employee_id = 120;
        raise notice 'El salari és %', salario;
    end;
$$


/* Exercici 4. Crea un bloc anònim amb una variable PL/SQL que imprimeixi el salari més alt dels treballadors que treballen al departament 'SALES'. */
do $$
    declare
        salario EMPLOYEES.salary%TYPE;
    begin
        SELECT MAX(salary)
        INTO salario
        FROM employees, departments
        WHERE LOWER(department_name) LIKE 'sales';
        raise notice 'El salari és %', salario;
    end;
$$


/* Exercici 5. Crea un bloc anònim amb tre variables de tipus NUMBER. Aquestes variables han de tenir un valor inicial de 15, 40 i 35 respectivament. El bloc ha de sumar aquestes tres variables i mostrar per pantalla ‘LA SUMA TOTAL ÉS: (la suma de les variables)’. */
do $$
    declare
        firstNumber NUMERIC = 15;
        secondNumber NUMERIC = 40;
        thirdNumber NUMERIC = 35;
        totalSum NUMERIC;
    begin
        totalSum = firstNumber + secondNumber + thirdNumber;
        raise notice 'La suma dels tres números és: %', totalSum;
    end;
$$