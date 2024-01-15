/* EX 1*/
/* Fetch*/
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