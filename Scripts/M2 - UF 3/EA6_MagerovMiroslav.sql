/* -------------------------------------- EX1 -------------------------------------- */
CREATE OR REPLACE FUNCTION func_compv_dept(param_dptId DEPARTMENTS.DEPARTMENT_ID%TYPE)
    RETURNS BOOLEAN LANGUAGE plpgsql AS $$
    DECLARE
        var_dptId DEPARTMENTS.DEPARTMENT_ID%TYPE;
    BEGIN
        SELECT DEPARTMENT_ID
        INTO STRICT var_dptId
        FROM DEPARTMENTS
        WHERE DEPARTMENT_ID = param_dptId;
        RETURN TRUE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN FALSE;
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR GENERAL:';
    END;$$;

CREATE OR REPLACE FUNCTION func_comprovar_mng (var_mngID NUMERIC)
    RETURNS BOOLEAN LANGUAGE plpgsql AS $$
    BEGIN
        if (var_mngID IN (SELECT manager_id FROM departments)) then
            RETURN TRUE;
        else
            RETURN FALSE;
        end if;
    END;$$;

CREATE OR REPLACE FUNCTION func_comprovar_loc (var_locID NUMERIC)
    RETURNS BOOLEAN LANGUAGE plpgsql AS $$
    BEGIN
        if (var_locID IN (SELECT location_id FROM locations)) then
            RETURN TRUE;
        else
            RETURN FALSE;
        end if;
    END;$$;

CREATE OR REPLACE PROCEDURE proc_alta_dept (var_dep departments)
    LANGUAGE plpgsql AS $$
    BEGIN
        INSERT INTO departments VALUES (var_dep.department_id, var_dep.department_name, var_dep.manager_id, var_dep.location_id);
    END;$$;

    DO $$
        DECLARE
            dep_id NUMERIC := :depId;
            dep_name VARCHAR := :depName;
            dep_man_id NUMERIC := :depMan;
            dep_loc_id NUMERIC := :depLoc;
            var_dep departments%ROWTYPE;
        BEGIN
            var_dep.department_id := dep_id;
            var_dep.department_name := dep_name;
            var_dep.manager_id := dep_man_id;
            var_dep.location_id := dep_loc_id;

            if not (func_comprovar_mng(var_dep.manager_id)) then
                RAISE NOTICE 'El id del manager no existe.';
                
            elsif not (func_comprovar_loc(var_dep.location_id)) then
                RAISE NOTICE 'El id de la localidad no existe.';
                
            elsif (func_compv_dept(var_dep.department_id)) then
                RAISE NOTICE 'Ese id ya existe en otro departamento.';
                
            else
                CALL proc_alta_dept(var_dep);
                RAISE NOTICE 'Departamento insertado con éxito en la base de datos.';
            end if;
        END;
    $$

    /* JOC DE PROVES */
    /* Inserir departament amb un department_id existent (20): ERROR */
    /* Inserir departament amb un manager_id inexistent (10): ERROR */
    /* Inserir departament amb un location_id inexistent (10): ERROR */
    /* Si no dona ERROR en cap dels altres 3 cassos: INSERIT CORRECTAMENT */


/* -------------------------------------- EX2 -------------------------------------- */
CREATE OR REPLACE FUNCTION func_nom_emp (employee_id_var NUMERIC) RETURNS VARCHAR LANGUAGE plpgsql
AS $$
    DECLARE
        employee_name VARCHAR;
    BEGIN
        SELECT first_name || ' ' || last_name INTO STRICT employee_name FROM employees WHERE employee_id = employee_id_var;

        RETURN employee_name;
    END;$$;

DO $$
    DECLARE
        employee_id_var NUMERIC := :id;
    BEGIN
        RAISE NOTICE 'El nombre del empleado con ID % es: %.', employee_id_var, func_nom_emp(employee_id_var);

    EXCEPTION
        WHEN SQLSTATE 'P0002' THEN
            RAISE EXCEPTION 'No existe un empleado con ese ID.';
    END;$$;

    /* JOC DE PROVES */
    /* Inserir ID que no existeix: ERROR (999) */
    /* Inserir ID que si existeix: RETORNA NOM I COGNOM DE L'EMPLEAT AMB AQUELL ID (100 = Steven King)*/

/* -------------------------------------- EX3 -------------------------------------- */
CREATE OR REPLACE FUNCTION func_nom_dep (dep_id NUMERIC) RETURNS VARCHAR
LANGUAGE plpgsql AS $$
    DECLARE
        dep_name VARCHAR;
    BEGIN
        SELECT department_name INTO STRICT dep_name FROM departments WHERE department_id = dep_id;

        RETURN dep_name;
    END;$$;

DO $$
    DECLARE
        var_dep_id NUMERIC := :depID;
    BEGIN
        RAISE NOTICE 'El nombre del departamento con ID % es: %.', var_dep_id, func_nom_dep(var_dep_id);
        IF (UPPER(func_nom_dep(var_dep_id)) LIKE 'A%') THEN
            RAISE NOTICE 'Comença per la lletra A.';
        ELSE
            RAISE NOTICE 'No comença per la lletra A. ';
        END IF;

    EXCEPTION
        WHEN SQLSTATE 'P0002' THEN
            RAISE EXCEPTION 'ERROR: no dades.';
        WHEN SQLSTATE 'P0003' THEN
            RAISE EXCEPTION 'ERROR: retorna més files';
        WHEN OTHERS THEN
            RAISE EXCEPTION 'ERROR: Sense definir';
    END;$$;

    /* JOC DE PROVES */
    /* Department_id = 999 | 'ERROR: no dades.'*/
    /* Department_id = 10 | 'Administration, empieza por A.' */
    /* Department_id = 20 | 'Marketing, no empieza por A.'*/


/* -------------------------------------- EX4 -------------------------------------- */
CREATE OR REPLACE PROCEDURE proc_loc_address (loc_id NUMERIC, new_street_address VARCHAR) LANGUAGE plpgsql
AS $$
    BEGIN
        UPDATE locations
        SET street_address = new_street_address
        WHERE location_id = loc_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'La actualización no afectó ninguna fila. Código de localidad inexistente.';
        END IF;
    END;$$;

CREATE OR REPLACE FUNCTION func_comprovar_loc (codi_loc NUMERIC) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
    DECLARE
        cod_loc_id NUMERIC;
    BEGIN
        SELECT location_id INTO STRICT cod_loc_id FROM locations WHERE location_id = codi_loc;
        RETURN TRUE;
    END;$$;

DO $$
    DECLARE
        var_cod_loc NUMERIC := :loc;
        var_new_street_address VARCHAR := :address;
    BEGIN
    IF (func_comprovar_loc(var_cod_loc)) THEN
        CALL proc_loc_address(var_cod_loc,var_new_street_address);
    END IF;

    EXCEPTION
        WHEN SQLSTATE 'P0002' THEN
            RAISE EXCEPTION 'ERROR: No existe código de la localidad.';
    END;$$ LANGUAGE plpgsql;

    /* JOC DE PROVES */
    /* var_cod_loc = 1 | 'ERROR: No existe código de la localidad.' */
    /* var_cod_loc = 1000, var_new_street_address = "Aiguablava 121" | Localidad actualizada */