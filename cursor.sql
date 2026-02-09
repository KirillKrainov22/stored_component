CREATE OR REPLACE FUNCTION batch_salary_increase()
RETURNS TABLE(updated_id INT, old_salary DECIMAL, new_salary DECIMAL) AS $$
DECLARE
    emp_cursor CURSOR FOR 
        SELECT id, salary 
        FROM employees 
        WHERE hire_date <= CURRENT_DATE - INTERVAL '10 years'
        AND is_active = true;
    
    emp_rec RECORD;
    new_sal DECIMAL(10,2);
BEGIN
    OPEN emp_cursor;
    
    LOOP
        FETCH emp_cursor INTO emp_rec;
        EXIT WHEN NOT FOUND;
        
        new_sal := LEAST(emp_rec.salary * 1.05, emp_rec.salary + 5000);
        
        UPDATE employees 
        SET salary = new_sal 
        WHERE id = emp_rec.id;
        
        updated_id := emp_rec.id;
        old_salary := emp_rec.salary;
        new_salary := new_sal;
        RETURN NEXT;
    END LOOP;
    
    CLOSE emp_cursor;
    RETURN;
END;
$$ LANGUAGE plpgsql;