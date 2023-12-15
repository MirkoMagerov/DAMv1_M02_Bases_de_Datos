/* ********************** EXERCICI 1 ********************** */
/* BORRA TODOS LOS REGISTROS */ 
CREATE OR REPLACE PROCEDURE proc_baixa_emp(id IN NUMERIC)
AS
$$
    DECLARE
        emp employees;
    BEGIN
        SELECT * INTO emp FROM employees WHERE id = employee_id;
        if (EXISTS(SELECT employee_id FROM employees WHERE id = employee_id)) then
            INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
            VALUES
                (id, emp.hire_date, current_date, emp.job_id, emp.department_id);

            DELETE FROM employees WHERE employee_id = id;

            raise notice 'Empleado borrado exitosamente';
        else
            raise notice 'No existe un empleado con ese ID.';
        end if;
    END;

$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        id_empleat NUMERIC;
    BEGIN
        id_empleat := :'Id del empleado';

        CALL PROC_BAIXA_EMP(id_empleat);
    END;
$$


/* ********************** EXERCICI 2 ********************** */
CREATE OR REPLACE FUNCTION func_num_emp (id IN NUMERIC)
    RETURNS NUMERIC
AS
$$
    DECLARE
        num_empleats NUMERIC;
    BEGIN
        num_empleats = (SELECT COUNT(employee_id)
                        FROM employees
                        WHERE department_id = id);
        return num_empleats;
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        user_dpt_id NUMERIC;
    BEGIN
        user_dpt_id := :dp_id;
        if (user_dpt_id IN (SELECT department_id FROM employees)) then
            raise notice 'Hay % empleados en el departamento con ID %.',
                func_num_emp(user_dpt_id), user_dpt_id;
        else
            raise notice 'No existe un departamento con ID = %.', user_dpt_id;
        end if;
    END;
$$


/* ********************** EXERCICI 3 ********************** */
CREATE OR REPLACE FUNCTION func_cost_dep (id IN NUMERIC)
    RETURNS NUMERIC
AS
$$
    DECLARE
        salarySum NUMERIC;
    BEGIN
        salarySum = (SELECT SUM(salary)
                    FROM employees
                    WHERE department_id = id);
        return salarySum;
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        user_dpt_id NUMERIC;
    BEGIN
        user_dpt_id := :dp_id;
        if (user_dpt_id IN (SELECT department_id FROM employees)) then
            raise notice 'La suma de salarios del departamento % es: %.',
                user_dpt_id, func_cost_dep(user_dpt_id);
        else
            raise notice 'No existe un departamento con ID = %.', user_dpt_id;
        end if;
    END;
$$ LANGUAGE plpgsql;


/* ********************** EXERCICI 4 ********************** */
CREATE OR REPLACE PROCEDURE proc_mod_com (id IN NUMERIC)
AS
$$
    DECLARE
        actual_salary NUMERIC;
    BEGIN
        actual_salary = (SELECT salary FROM employees WHERE employee_id = id);

        if (actual_salary < 300) then
            UPDATE employees
            SET commission_pct = 0.1
            WHERE employee_id = id;
        elsif (actual_salary BETWEEN 3000 AND 7000) then
            UPDATE employees
            SET commission_pct = 0.15
            WHERE employee_id = id;
        else
            UPDATE employees
            SET commission_pct = 0.2
            WHERE employee_id = id;
        end if;
    END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        user_emp_id NUMERIC;
    BEGIN
        user_emp_id := :'user_id';
        
        if (user_emp_id IN (SELECT employee_id FROM employees)) then
            CALL proc_mod_com(user_emp_id);
            raise notice 'Comissió del empleat amb ID = % actualitzada correctament.', user_emp_id;
        else
            raise notice 'No existe el empleado con ID = %', user_emp_id;
        end if;
    END;
$$ LANGUAGE plpgsql;