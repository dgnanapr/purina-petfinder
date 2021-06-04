--  Step 3.2 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
DECLARE payload TEXT;
CALL construct_animals_rds_cdc(NEW.id, payload);
CALL rds_lambda_cdc('animals', NEW.id,'i'  ,payload);
END
;;
DELIMITER ; 