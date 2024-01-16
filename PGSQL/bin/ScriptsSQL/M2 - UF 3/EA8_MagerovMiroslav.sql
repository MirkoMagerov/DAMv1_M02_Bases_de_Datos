/* EX 1 */
DO $$
    DECLARE
        var_department_id NUMERIC;
        emp_cursor CURSOR (var_department_id NUMERIC) FOR SELECT * FROM employees WHERE employees.department_id = var_department_id;
        empleats RECORD;
    BEGIN
        OPEN emp_cursor (:dep_id);
        LOOP
            FETCH emp_cursor INTO empleats;
            EXIT WHEN NOT FOUND;
            RAISE NOTICE 'EmpID = % | Apellido = %',empleats.employee_id, empleats.last_name;
        END LOOP;
    END;$$ LANGUAGE plpgsql;


/* EX 2 */
CREATE OR REPLACE FUNCTION func_comp_dep (var_dep_id NUMERIC) RETURNS BOOLEAN
LANGUAGE plpgsql AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM departments WHERE department_id = var_dep_id) THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END;$$;

DO $$
    DECLARE
        var_department_id NUMERIC = :id;
        emp_cursor CURSOR (var_department_id NUMERIC) FOR SELECT * FROM employees WHERE employees.department_id = var_department_id;
        empleats RECORD;
    BEGIN
        IF (func_comp_dep(var_department_id)) THEN
            FOR empleats IN emp_cursor(var_department_id) LOOP
                RAISE NOTICE 'EmpID = % | Apellido = %',empleats.employee_id, empleats.last_name;
            END LOOP;
        END IF;
END;$$ LANGUAGE plpgsql;


/* EX 3 */
CREATE OR REPLACE FUNCTION func_emps_dep (var_dep_id NUMERIC) RETURNS SETOF employees
LANGUAGE plpgsql AS $$
    BEGIN
        RETURN QUERY SELECT * FROM employees WHERE department_id = var_dep_id;
END;$$;

DO $$
    DECLARE
        var_dep_id NUMERIC = :id;
    BEGIN
        SELECT * FROM func_emps_dep(var_dep_id);
    END;$$ LANGUAGE plpgsql;