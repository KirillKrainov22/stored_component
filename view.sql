CREATE OR REPLACE VIEW active_employees_info AS
SELECT 
    e.id,
    e.first_name || ' ' || e.last_name AS full_name,
    d.name AS department_name,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.hire_date)) AS years_of_service
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.is_active = true AND e.department_id IS NOT NULL;