/* EX 1*/
/* CURSOR */
DO $$
    DECLARE
        employee_cursor CURSOR FOR SELECT * FROM employees;
        employee employees%ROWTYPE;
    BEGIN
        open employee_cursor;
        loop
            FETCH employee_cursor INTO employee;
            EXIT WHEN NOT FOUND;
            IF (employee.commission_pct IS NULL) THEN
                employee.commission_pct = 0;
            END IF;
            RAISE NOTICE 'Datos: % | % | % | % | %', employee.employee_id, employee.first_name, employee.salary, employee.commission_pct, employee.hire_date;
        END LOOP;
        CLOSE employee_cursor;
    END;
$$ LANGUAGE plpgsql;

/* FOR IN*/
DO $$
    DECLARE
        employee employees%ROWTYPE;
    BEGIN
        FOR employee IN SELECT * FROM employees LOOP
            IF (employee.commission_pct IS NULL) THEN
                employee.commission_pct = 0;
            END IF;
            RAISE NOTICE 'Datos: % | % | % | % | %', employee.employee_id, employee.first_name, employee.salary, employee.commission_pct, employee.hire_date;
        END LOOP;
    END;
$$ LANGUAGE plpgsql;


/* EX 2*/
/* CURSOR */
CREATE OR REPLACE FUNCTION func_control_neg(salari NUMERIC) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
    BEGIN
        IF (salari < 0) THEN
            RAISE EXCEPTION 'ERROR: salario negativo y debe de ser positivo.';
        ELSE
            RETURN TRUE;
        END IF;
    END;$$;

DO $$
    DECLARE
        var_salary NUMERIC = :salary;
        employee employees%ROWTYPE;
        employees_cursor CURSOR FOR SELECT * FROM employees;
    BEGIN
        IF (func_control_neg(var_salary)) THEN
            OPEN employees_cursor;
            LOOP
                FETCH employees_cursor INTO employee;
                EXIT WHEN NOT FOUND;
                IF (employee.salary > var_salary) THEN
                    RAISE NOTICE 'ID: % | NOM: % | SALARI: %', employee.employee_id, employee.first_name, employee.salary;
                end if;
            END LOOP;
        END IF;
    END;$$;

/* FOR IN */
CREATE OR REPLACE FUNCTION func_control_neg(salari NUMERIC) RETURNS BOOLEAN
    LANGUAGE plpgsql AS $$
BEGIN
    IF (salari < 0) THEN
        RAISE EXCEPTION 'ERROR: salario negativo y debe de ser positivo.';
    ELSE
        RETURN TRUE;
    END IF;
END;$$;

DO $$
    DECLARE
        var_salary NUMERIC = :salary;
        employee employees%ROWTYPE;
    BEGIN
        IF (func_control_neg(var_salary)) THEN
            FOR employee IN SELECT * FROM employees LOOP
                IF (employee.salary > var_salary) THEN
                    RAISE NOTICE 'ID: % | NOM: % | SALARI: %', employee.employee_id, employee.first_name, employee.salary;
                END IF;
                END LOOP;
        END IF;
    END;$$;


/* EX 3 */
/* CURSOR */
DO $$
    DECLARE
        var_depID departments.department_id%TYPE;
        var_depLocID departments.location_id%TYPE;
        var_depName departments.department_name%TYPE;
        var_depCity locations.city%TYPE;
        department_cursor CURSOR FOR SELECT department_id, department_name, location_id FROM departments;
    BEGIN
        OPEN department_cursor;
        LOOP
            FETCH department_cursor INTO var_depID, var_depName, var_depLocID;
            EXIT WHEN NOT FOUND;
            SELECT city INTO var_depCity FROM locations WHERE location_id = var_depLocID;
            RAISE NOTICE 'ID: % | NOM: % | LOCATION ID: % | CIUTAT: %', var_depID, var_depName, var_depLocID, var_depCity;
        END LOOP;
    END;
$$

/* FOR IN */
DO $$
    DECLARE
        var_depID departments.department_id%TYPE;
        var_depLocID departments.location_id%TYPE;
        var_depName departments.department_name%TYPE;
        var_depCity locations.city%TYPE;
    BEGIN
        FOR var_depID, var_depLocID, var_depName IN SELECT department_id, location_id, department_name FROM departments LOOP
            SELECT city INTO var_depCity FROM locations WHERE location_id = var_depLocID;
            RAISE NOTICE 'ID: % | NOM: % | LOCATION ID: % | CIUTAT: %', var_depID, var_depName, var_depLocID, var_depCity;
        END LOOP;
    END;
$$