/* ********** EX - 1 ********** */
DO $$
    DECLARE
        firstNum NUMERIC;
        secondNum NUMERIC;
        result NUMERIC;
    BEGIN
        firstNum = :num1;
        secondNum = :num2;

        if (firstNum < 0 OR secondNum < 0) then
            raise notice 'Los números deben ser positivos.';
        else
            result = firstNum * secondNum;
            raise notice 'La multiplicación de % * % es %.', firstNum, secondNum, result;
        end if;
    END;
$$


/* ********** EX - 2 ********** */
CREATE OR REPLACE FUNCTION func_checkP (radi NUMERIC)
    RETURNS NUMERIC AS
$$
    DECLARE
    BEGIN
        if (radi < 0) then
            return -1;
        else
            return radi;
        end if;
    END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION func_calculArea (radi NUMERIC)
    RETURNS NUMERIC AS
$$
    DECLARE
        piNumber NUMERIC = 3.14;
        area NUMERIC;
    BEGIN
        if (func_checkP(radi) != -1) then
            area = (radi * radi) * piNumber;
            return area;
        else
            return 0;
        end if;
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
        radi NUMERIC;
    BEGIN
        radi = :r;
        if (func_calculArea(radi) != 0) then
            raise notice 'Àrea de la circumferència de radi % és %', radi, func_calculArea(radi);
        else
            raise notice 'El radio no puede ser negativo';
        end if;
    END;
$$


/* ********** EX - 3 ********** */
CREATE OR REPLACE FUNCTION func_nom_manager (dep departments)
    RETURNS VARCHAR AS
$$
    DECLARE
        managerName departments;
    BEGIN
        managerName.manager_id = (SELECT manager_id FROM departments d WHERE d.department_id = dep.department_id);
        return (SELECT e.first_name, e.last_name FROM employees e
                JOIN departments d ON d.department_id = e.department_id
                WHERE managerName.manager_id = e.manager_id);
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
        department departments;
        dep_id NUMERIC;
    BEGIN
        dep_id = :d_id;
        department = (SELECT * FROM departments WHERE dep_id = departments.department_id);
        raise notice 'El nombre del manager del departamento % es "%".', dep_id, func_nom_manager(department);
    END;
$$


/* ********** EX - 4 ********** */
CREATE OR REPLACE PROCEDURE proc_dades_empl (id_emp NUMERIC)
AS
$$
    DECLARE
        employee_row employees%ROWTYPE;
        dep_name VARCHAR;
        loc_name VARCHAR;
    BEGIN
        employee_row.first_name = (SELECT first_name FROM employees WHERE employee_id = id_emp);
        employee_row.last_name = (SELECT last_name FROM employees WHERE employee_id = id_emp);
        employee_row.department_id = (SELECT department_id FROM employees WHERE employee_id = id_emp);

        dep_name = (SELECT d.department_name FROM departments d
                    WHERE d.department_id = employee_row.department_id);

        loc_name = (SELECT l.location_id FROM locations l, departments d
                    WHERE l.location_id = d.location_id AND d.department_id = employee_row.department_id);

        raise notice '  NOM   |  COGNOM   |  NOM DEPARTAMENT  |  CODI LOCALITAT';
        raise notice '  %  |  %  |  %  |  %  ', employee_row.first_name, employee_row.last_name, dep_name, loc_name;
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
        emp_id NUMERIC;
    BEGIN
        emp_id = :id;
        CALL proc_dades_empl(emp_id);
    END;
$$


/* ********** EX - 5 ********** */
CREATE OR REPLACE PROCEDURE proc_alta_pais (pais countries, region VARCHAR)
AS
$$
    DECLARE
        regionID NUMERIC;
    BEGIN
        regionID = (SELECT region_id FROM regions WHERE region_name = region);

        INSERT INTO countries (country_id, country_name, region_id) VALUES
        (pais.country_id, pais.country_name, regionID);

        raise notice 'Pais: %', (SELECT country_name FROM countries WHERE country_id = pais.country_id);
    END;
$$ LANGUAGE plpgsql;


DO $$
    DECLARE
        country_user_id VARCHAR;
        country_user_name VARCHAR;
        region_user_name VARCHAR;
        country_user countries;
    BEGIN
        country_user_id = :id;
        country_user_name = :c_name;
        region_user_name = :r_name;
        country_user.country_id = country_user_id;
        country_user.country_name = country_user_name;
        CALL proc_alta_pais(country_user, region_user_name);
    END;
$$