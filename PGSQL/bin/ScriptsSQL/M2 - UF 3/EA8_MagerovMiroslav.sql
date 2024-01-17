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


/* EX 4 */
DO $$
DECLARE
    employee_cursor CURSOR FOR SELECT * FROM employees;
    new_salary NUMERIC;
BEGIN
    FOR employee IN employee_cursor LOOP
        new_salary = ROUND(employee.salary + (employee.salary * 18 / 100), 2);
        RAISE NOTICE 'El salari antic de l`empleat % era % i el nou serà: %.', employee.employee_id, employee.salary, new_salary;
        UPDATE emp_nou_salary SET salary = new_salary WHERE emp_nou_salary.employee_id = employee.employee_id;
    END LOOP;
END;$$ LANGUAGE plpgsql;


/* EX 5 */
DO $$
DECLARE
    emp_cursor CURSOR FOR SELECT * FROM emp_nou_salary;
    employee emp_nou_salary%ROWTYPE;
    var_depID departments.department_id%TYPE = :id;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO employee;
        IF (NOT FOUND) THEN
            RAISE NOTICE 'Ya no hay más empleados en ese departamento';
        end if;
        IF (employee.department_id = var_depID) THEN
            IF (employee.commission_pct == null) THEN
                UPDATE emp_nou_salary SET commission_pct = 0 WHERE employee_id = employee.employee_id;
            ELSE
                UPDATE emp_nou_salary SET commission_pct = (commission_pct + 0.20) WHERE employee_id = employee.employee_id;
            end if;
        END IF;
    END LOOP;

    CLOSE emp_cursor;
END;$$ LANGUAGE plpgsql;