CREATE OR REPLACE FUNCTION audit_data_changes_func()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_trail (table_name, record_id, old_data, new_data, operation)
        VALUES (
            TG_TABLE_NAME,
            NEW.id,
            NULL,
            row_to_json(NEW)::JSONB,
            'INSERT'
        );
        RETURN NEW;
        
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_trail (table_name, record_id, old_data, new_data, operation)
        VALUES (
            TG_TABLE_NAME,
            OLD.id,
            row_to_json(OLD)::JSONB,
            row_to_json(NEW)::JSONB,
            'UPDATE'
        );
        RETURN NEW;
        
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_trail (table_name, record_id, old_data, new_data, operation)
        VALUES (
            TG_TABLE_NAME,
            OLD.id,
            row_to_json(OLD)::JSONB,
            NULL,
            'DELETE'
        );
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER audit_data_changes
AFTER INSERT OR UPDATE OR DELETE ON important_data
FOR EACH ROW
EXECUTE FUNCTION audit_data_changes_func();