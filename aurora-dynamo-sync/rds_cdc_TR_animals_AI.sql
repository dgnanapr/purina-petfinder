-- Step 3 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
   SELECT NEW.id,'INSERT',  NEW.* INTO @pk, @operation, @cdc_payload;
  CALL rds_lambda_cdc('animals', @pk, @operation, @cdc_payload);
END
;;
DELIMITER ;