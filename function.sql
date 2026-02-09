CREATE OR REPLACE FUNCTION add_product_with_movement(
    p_sku VARCHAR, 
    p_name VARCHAR, 
    p_initial_stock INT
)
RETURNS INT AS $$
DECLARE
    new_product_id INT;
BEGIN
    INSERT INTO products (sku, name, current_stock)
    VALUES (p_sku, p_name, p_initial_stock)
    RETURNING id INTO new_product_id;
    
    INSERT INTO stock_movements (product_id, change_amount, movement_type)
    VALUES (new_product_id, p_initial_stock, 'ADJUSTMENT');
    
    RETURN new_product_id;
END;
$$ LANGUAGE plpgsql;