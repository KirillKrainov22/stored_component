CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2),
    hire_date DATE,
    is_active BOOLEAN DEFAULT true
);

CREATE TABLE departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT REFERENCES employees(id)
);

CREATE TABLE salary_audit_log(
    id SERIAL PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_by VARCHAR(100) DEFAULT CURRENT_USER,
    change_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    sku VARCHAR(20) UNIQUE,
    name VARCHAR(100),
    current_stock INT DEFAULT 0
);

CREATE TABLE stock_movements(
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    change_amount INT,
    movement_type VARCHAR(10),
    movement_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE important_data(
    id SERIAL PRIMARY KEY,
    data JSONB,
    modified_at TIMESTAMP,
    modified_by TEXT
);

CREATE TABLE audit_trail(
    id SERIAL PRIMARY KEY,
    table_name TEXT,
    record_id INT,
    old_data JSONB,
    new_data JSONB,
    operation TEXT,
    change_time TIMESTAMP DEFAULT NOW()
);