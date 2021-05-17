-- Step 2 Create rds_lambda_sync  procedure , this the stored procedure call by all table triggers to send cdc data to a common lambda function rds_lamdbda_sns
DROP PROCEDURE IF EXISTS rds_lambda_cdc;
DELIMITER ;;
CREATE DEFINER=`pfadmin`@`%` PROCEDURE `rds_lambda_cdc`(IN tableName VARCHAR(255),  IN cdc_payload TEXT, IN operation VARCHAR(255))
BEGIN
    CALL mysql.lambda_async(
         'arn:aws:lambda:us-east-1:462477274376:function:RdsCdcReceiver',
         CONCAT('{"table_name" : "', tableName,
             '", "pk" : "', cdc_payload,
             '", "operation" : "', operation,'"}')
     );
  END
  ;;
DELIMITER ;