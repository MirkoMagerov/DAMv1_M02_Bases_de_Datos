/* Exercici 1. Realitzar un programa que contingui una funció que dupliqui la quantitat rebuda com a paràmetre. La funció rebrà el nom de FUNC_DUPLICAR_QUANTITAT. S’ha de programar un bloc
principal que demani per teclat la quantitat i que cridi a la funció FUNC_DUPLICAR_QUANTITAT
passant el paràmetre corresponent. */
CREATE OR REPLACE FUNCTION FUNC_DUPLICAR_QUANTITAT(
    number IN numeric
)
    RETURNS numeric
AS
$$
    declare
    duplicate NUMERIC;
    begin
    duplicate = number * 2;
    RETURN duplicate;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        number NUMERIC;
    begin
        number = :"Escribe un número para duplicarlo: ";
        raise notice 'El duplicado del número % es: %', number, FUNC_DUPLICAR_QUANTITAT(number);
    end;
$$

/* Exercici 2. Realitzar un programa que contingui una funció que calculi el factorial d’un número que es passa com a paràmetre. La funció rebrà el nom de FUNC_FACTORIAL. S’ha de programar un bloc principal que pregunti a l’usuari pel número a calcular i cridi a la funció FUNC_FACTORIAL, passant el paràmetre corresponent. */
CREATE OR REPLACE FUNCTION FUNC_FACTORIAL(
    number IN numeric)
    RETURNS numeric
AS
$$
    declare
    factorial NUMERIC = 1;
    begin
    while number > 0
    loop
        factorial = factorial * number;
        number = number - 1;
        end loop;
    RETURN factorial;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        number NUMERIC;
    begin
        number = :"Escribe un número para duplicarlo: ";
        raise notice 'El factorial del número % es: %', number, FUNC_FACTORIAL(number);
    end;
$$

/* Exercici 3. Realitzar un procediment que s’anomeni PROC_EMP_INFO i que es passi com a paràmetre l’Id d’un empleat i mostri el seu ID, el seu nom, el seu càrrec (job_title) i el seu salari. Has de canviar els nom de les columnes perquè sigui (codi_empleat, nom_empleat, càrrec, salari). Per realitzar aquest exercici has de fer servir una variable de tipus %rowtype. S’ha de programar un bloc principal que pregunti a l’usuari pel ID de l’empleat i cridi al procediment PROC_EMP_INFO, passant el paràmetre corresponent. */
CREATE OR REPLACE FUNCTION PROC_EMP_INFO(
    id IN numeric)
    RETURNS employees
AS
$$
    declare
        emp_info employees%ROWTYPE;
    begin
        SELECT INTO emp_info *
        FROM employees e
        JOIN jobs j ON e.job_id = j.job_id
        WHERE employee_id = id;
        RETURN emp_info;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        id_employee NUMERIC;
        emp_info employees;
        carrec VARCHAR;
    begin
        id_employee := :"Escribe el id de un empleado para saber sus datos: ";
        emp_info := PROC_EMP_INFO(id_employee);
        carrec := (SELECT job_title FROM jobs WHERE job_id = emp_info.job_id);

        raise notice 'Los datos del empleado son: Codi_empleat: %, Nom_empleat: % %, Cárrec: %, Salari: %',
            emp_info.employee_id, emp_info.first_name, emp_info.last_name, carrec, emp_info.salary;
    end;
$$

/* Exercici 4. Realitzar un programa que contingui un procediment anomenat PROC_ALTA_JOB que doni d’alta un nou ofici (JOB) a la taula jobs. Totes les dades del nou ofici s’han de passat com com a paràmetre. S’ha de programar un bloc principal que pregunti a l’usuari totes les dades del nou ofici i cridi el procediment PROC_ALTA_JOB. Abans d’inserir s’ha de comprovar que el valor màxim i mínim del salari no sigui negatiu i a més, que el salari mínim sigui més petit que el salari màxim. Mostra els missatges d’error corresponents. */
CREATE OR REPLACE FUNCTION PROC_ALTA_JOB(
    job_id_p IN VARCHAR, job_title_p IN VARCHAR, job_min_salary_p IN NUMERIC, job_max_salary_p IN NUMERIC)
    RETURNS jobs
AS
$$
    declare
        created_row jobs;
    begin
        created_row.job_id := job_id_p;
        created_row.job_title := job_title_p;
        created_row.min_salary := job_min_salary_p;
        created_row.max_salary := job_max_salary_p;

        return created_row;
    end;
$$ LANGUAGE plpgsql;


do $$
    declare
        job_id_user varchar;
        job_title_user varchar;
        job_min_salary numeric;
        job_max_salary numeric;
        created_row jobs;
    begin
        job_id_user = :'Id del trabajo';
        job_title_user = :'Nombre del trabajo';
        job_min_salary = :'Salario mínimo';
        job_max_salary = :'Salario máximo';

        if (job_min_salary <= 0 OR job_max_salary <= 0) then
            raise notice 'Los salarios no pueden ser negativos o 0';
        elsif (job_min_salary > job_max_salary) then
            raise notice 'El salario mínimo no puede ser menor al máximo';
        else
            created_row := PROC_ALTA_JOB(job_id_user, job_title_user, job_min_salary, job_max_salary);
            INSERT INTO jobs (job_id, job_title, min_salary, max_salary) VALUES
            (created_row.job_id, created_row.job_title, created_row.min_salary, created_row.max_salary);
        end if;
    end;
$$