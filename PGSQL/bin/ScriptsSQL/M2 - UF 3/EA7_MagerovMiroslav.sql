/* EX 1*/
DO $$
    DECLARE
        my_cursor refcursor;
        employee_cursor CURSOR FOR SELECT employee_id, first_name, salary, commission_pct, hire_date FROM employees;
        emp_id NUMERIC;
        emp_first_name VARCHAR;
        emp_salary NUMERIC;
        emp_commision NUMERIC;
        emp_hire_date DATE;
    BEGIN
        open employee_cursor;
        loop
            FETCH employee_cursor INTO emp_id, emp_first_name, emp_salary, emp_commision, emp_hire_date;
            IF (emp_commision IS NULL) THEN
                emp_commision = 0;
            END IF;
            RAISE NOTICE 'Datos: % | % | % | % | %', emp_id, emp_first_name, emp_salary, emp_commision, emp_hire_date;
        END LOOP;
    END;
$$ LANGUAGE plpgsql;