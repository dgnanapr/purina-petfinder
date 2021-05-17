--  Step 3 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
--  DROP TRIGGER rds_cdc_TR_animals_AI;
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
-- NEW.id,'INSERT' INTO  @cdc_payload , @operation;
  -- CALL rds_lambda_cdc('animals', @cdc_payload , @operation);
 -- CALL rds_lambda_cdc('animals', 'PAYLOAD' , 'INSERT');
-- CALL rds_lambda_cdc('animals', JSON_OBJECT("id", NEW.id,"description", NEW.description), 'INSERT');
-- SELECT CONCAT('{ \'id\' : \'', NEW.id, '\',  \'name\' : \'', NEW.description, '\'}'), 'i' INTO @id, @flag;
 -- SELECT CONCAT('{ \'id\' : \'', NEW.id, '\', \'status\' : \'', NEW.status, '\',  \'created_by\' : \'', NEW.created_by, '\',  \'created_by\' : \'',NEW.created_by, '\',  \'description\' : \'',NEW.description,  '\'}'), 'i' INTO @id, @flag;
-- SELECT New.id,  New.description INTO @id, @flag;
DECLARE payload TEXT;
SET payload = (SELECT CONCAT('{ \'id\' : \'', NEW.id, '\','));
IF NEW.status is NOT NULL THEN
    SET payload = CONCAT(payload,'\'status\' : \'', NEW.status, '\',');
END IF;
IF NEW.created_by is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by\' : \'', NEW.created_by, '\','); 
END IF;
IF NEW.created_by_client_id is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by_client_id\' : \'', NEW.created_by_client_id, '\','); 
END IF;
IF NEW.created_at is NOT NULL THEN
	SET payload = CONCAT(payload,'\'created_at\' : \'', NEW.created_at, '\',');
END IF;
IF NEW.updated_at is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_at\' : \'', NEW.updated_at, '\',');
END IF;
IF NEW.updated_by is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by\' : \'', NEW.updated_by, '\',');
END IF;
IF NEW.updated_by_client_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by_client_id\' : \'', NEW.updated_by_client_id, '\',');
END IF;
IF NEW.updated_by_user_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by_user_id\' : \'', NEW.updated_by_user_id, '\',');
END IF;
IF NEW.arrival_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'arrival_date\' : \'', NEW.arrival_date, '\',');
END IF;
IF NEW.adoption_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_date\' : \'', NEW.adoption_date, '\',');
END IF;
IF NEW.birth_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'birth_date\' : \'', NEW.birth_date, '\',');
END IF;
IF NEW.description is NOT NULL THEN
	SET payload = CONCAT(payload,'\'description\' : \'', NEW.description, '\',');
END IF;
	SET payload=CONCAT(payload, '\'}');
CALL rds_lambda_cdc('animals', 'i'  ,payload);
END
;;
DELIMITER ; 