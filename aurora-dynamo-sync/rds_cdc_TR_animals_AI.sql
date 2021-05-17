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
IF NEW.id is NOT NULL THEN
SET payload = (SELECT CONCAT('{ \'id\' : \'', NEW.id, '\','));
END IF;
IF NEW.description is NOT NULL THEN
SET payload = CONCAT(payload,'\'description\' : \'', NEW.description, '\',');
END IF;
SET payload=CONCAT(payload, '\'}');
CALL rds_lambda_cdc('animals', 'i'  ,payload);
END
;;
DELIMITER ; 