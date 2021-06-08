--  Step 3.2 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AD
  AFTER DELETE ON animals
  FOR EACH ROW
BEGIN
	DECLARE payload TEXT;
    
	 SET payload = CONCAT('{ \'id\' :', OLD.id, '}');
	-- IF (NEW.updated_by_client_id != 'rX8h7ckxfdWctFq5eXgmNw8OfFLjBB2pLiEeOFW7W8IIGxd1AS') THEN
		-- CALL construct_animals_rds_cdc(OLD.id, payload);
	CALL rds_lambda_cdc('animals', OLD.id,'d'  ,payload);
	-- END IF;
END
;;
DELIMITER ; 