CREATE OR REPLACE FUNCTION func_registrar_canvis_loc() RETURNS TRIGGER
LANGUAGE plpgsql AS $$
    BEGIN
        IF (new.city NOT LIKE old.city) THEN
            INSERT INTO canvis_locations
            VALUES (DEFAULT, new.location_id, new.city_old, new.city_new, new.changed_on);
        END IF;
        RETURN NEW;
    end;$$;

CREATE OR REPLACE TRIGGER trig_registrar_canvis_loc
    BEFORE UPDATE
    ON canvis_locations
    FOR EACH STATEMENT
    EXECUTE FUNCTION func_registrar_canvis_loc();

CREATE OR REPLACE FUNCTION func_registrar_canvis() RETURNS TRIGGER
LANGUAGE plpgsql AS $$
    BEGIN

    end;$$;

CREATE OR REPLACE TRIGGER trig_gravar_operacions
    AFTER UPDATE
    ON locations
    FOR EACH ROW
    EXECUTE FUNCTION func_registrar_canvis();

/* ---------------------------------------------------- */

CREATE OR REPLACE procedure proc_mostrar_emp_dept(departments.department_name%TYPE)
LANGUAGE plpgsql AS $$
    DECLARE
        empleat dades_emp_type;
    BEGIN
        IF NOT (func_comprv_dep($1)) THEN
            empleat = func_emp_mes_antic($1);

            RAISE NOTICE 'ID: % | Nom: % | Cognom: %', empleat.id, empleat.nom, empleat.cognom;
        ELSE
            RAISE EXCEPTION 'NO EXISTE DEPARTAMENTO CON EL NOMBRE "%"', $1;
        END IF;

    end;$$;

CREATE OR REPLACE FUNCTION func_emp_mes_antic(departments.department_name%TYPE) RETURNS dades_emp_type
LANGUAGE plpgsql AS $$
    DECLARE
        empleat dades_emp_type;
    BEGIN
        SELECT employee_id, first_name, last_name INTO empleat
        FROM employees e, departments d
        WHERE e.department_id = d.department_id AND d.department_name = $1
        ORDER BY hire_date
        LIMIT 1;

        RETURN empleat;

    END;$$;

CREATE OR REPLACE FUNCTION func_comprv_dep(departments.department_name%TYPE) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
    DECLARE
        depID NUMERIC;
    BEGIN
        SELECT department_id INTO STRICT depID FROM departments WHERE department_name LIKE $1;
        RETURN TRUE;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
    END;$$;

CALL proc_mostrar_emp_dept('Management');