-- Step 3 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
-- DROP TRIGGER rds_cdc_TR_animals_AI;
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
-- NEW.id,'INSERT' INTO  @cdc_payload , @operation;
  -- CALL rds_lambda_cdc('animals', @cdc_payload , @operation);
 -- CALL rds_lambda_cdc('animals', 'PAYLOAD' , 'INSERT');
-- CALL rds_lambda_cdc('animals', JSON_OBJECT("id", NEW.id,"description", NEW.description), 'INSERT');
SELECT CONCAT('{ \'id\' : \'', NEW.id, '\',  \'name\' : \'', NEW.description, '\'}'), 'i' INTO @id, @flag;
-- SELECT New.id,  New.description INTO @id, @flag;
CALL rds_lambda_cdc('animals', @id  , @flag);
END
;;
DELIMITER ; 