/* EX 1 */
CREATE OR REPLACE FUNCTION verificar_nombre_dep() RETURNS TRIGGER
AS $$
BEGIN
    IF NEW.department_name IS NULL THEN
        RAISE 'El nom del departament no pot ser null.';
    END IF;
    RETURN NEW;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trig_nom_departament_notnull
    BEFORE INSERT
    ON departments
    FOR EACH ROW
    EXECUTE FUNCTION verificar_nombre_dep();

-- Joc de proves
INSERT INTO departments
VALUES
    (2, null, 200, 1700); -- "El nom del departament no pot ser null"


/* EX 2 */
CREATE OR REPLACE FUNCTION comp_salari_negatiu() RETURNS TRIGGER
AS $$
BEGIN
    IF (new.salary < 0) THEN
        RAISE 'El salari no pot ser negatiu';
    END IF;
    IF (new.salary < old.salary OR old.commission_pct IS NULL) THEN
        RAISE 'El salari no pot ser menor que l`antic salari o la comissió es negativa.';
    END IF;
END;$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trig_restriccions_emp
    BEFORE INSERT OR UPDATE
    ON employees
    FOR EACH ROW
    EXECUTE FUNCTION comp_salari_negatiu();

-- Joc de proves
UPDATE employees SET salary = salary - 1 WHERE employee_id = 101; -- "El salari no pot ser menor que l`antic salari o la comissió es negativa.";

INSERT INTO employees
VALUES
    (999, 'Karen', 'Fisher', 'KFISHER', '515.233.3224', '1997-11-12', 'ST_MAN', -20, 0, 114, 30); -- "El salari no pot ser negatiu";