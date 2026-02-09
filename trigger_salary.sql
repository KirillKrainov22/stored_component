CREATE OR REPLACE FUNCTION log_salary_change_func()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.salary IS DISTINCT FROM NEW.salary THEN
        INSERT INTO salary_audit_log (employee_id, old_salary, new_salary)
        VALUES (OLD.id, OLD.salary, NEW.salary);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_salary_change
BEFORE UPDATE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_salary_change_func();