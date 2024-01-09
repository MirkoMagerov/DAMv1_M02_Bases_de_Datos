/* -------------- EX6 -------------- */
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
            RAISE NOTICE 'Mánager con id % existente.', var_mngID;
            RETURN TRUE;
        else
            RAISE NOTICE 'No existe mánager con el id %.', var_mngID;
            RETURN FALSE;
        end if;
    END;$$;

CREATE OR REPLACE FUNCTION func_comprovar_loc (var_locID NUMERIC)
    RETURNS BOOLEAN LANGUAGE plpgsql AS $$
    BEGIN
        if (var_locID) then
            
        end if;
    END;$$;

CREATE OR REPLACE PROCEDURE proc_alta_dept (var_dep departments%ROWTYPE)
    LANGUAGE plpgsql AS $$
    BEGIN
        INSERT INTO departments VALUES (var_dep.department_id, var_dep.department_name, var_dep.manager_id, var_dep.location_id);
    END;$$;

    DO $$
        DECLARE

        BEGIN

        END;
    $$