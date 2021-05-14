select routine_name, routine_type,definer,created,security_type,SQL_Data_Access from information_schema.routines where routine_type='PROCEDURE' and routine_schema='petfinder' ;

select * from information_schema.triggers ;

SELECT table_name FROM information_schema.tables WHERE table_schema = 'petfinder';

desc  information_schema.triggers;

SELECT User, Host FROM mysql.user;

show GRANTS for pfadmin;

select distinct updated_by from animal_templates;
 
 /**
 lambda_async (
  lambda_function_ARN,
  JSON_payload
)
 **/
SELECT lambda_sync(
    'arn:aws:lambda:us-east-1:462477274376:function:Location-RDS-Dynamoinvoke_lambda_funcinvoke_lambda_funcinvoke_lambda_func',
    '{"operation": "ping"}');

SELECT lambda_async(
    'arn:aws:lambda:us-east-1:462477274376:function:Location-RDS-Dynamoinvoke_lambda_funcinvoke_lambda_funcinvoke_lambda_func',
    '{"operation": "ping"}');

-- Step 1 grant this privilege to a user, connect to the DB instance as the master user, and run the following statement.
 GRANT INVOKE LAMBDA ON *.* TO 'pfadmin@%';
  
 REVOKE INVOKE LAMBDA ON *.* FROM 'pfadmin@%';

-- Step 2 Create rds_lambda_sync  procedure , this the stored procedure call by all table triggers to send cdc data to a common lambda function rds_lamdbda_sns
DROP PROCEDURE IF EXISTS rds_lambda_cdc;
DELIMITER ;;
  CREATE  DEFINER=`pfadmin`@`%`  PROCEDURE rds_lambda_cdc(IN tableName VARCHAR(255),IN pk VARCHAR(255), IN operation VARCHAR(255), IN cdc_payload TEXT) LANGUAGE SQL
  BEGIN
    CALL mysql.lambda_async(
         'arn:aws:lambda:us-east-1:462477274376:function:Location-RDS-Dynamoinvoke_lambda_funcinvoke_lambda_funcinvoke_lambda_func',
         CONCAT('{"table_name" : "', tableName,
             '", "pk" : "', pk,
             '", "operation" : "', operation,
             '", "cdc_payload" : "', cdc_payload,'"}')
     );
  END
  ;;
DELIMITER ;

-- Step 3 Create rds_lambda_sync  procedure , this the stored procedure call by all table triggers to send cdc data to a common lambda function rds_lamdbda_sns
DELIMITER ;;
CREATE TRIGGER TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
   SELECT NEW.id,'INSERT',  NEW.* INTO @pk, @operation, @cdc_payload;
  CALL rds_lambda_cdc('animals', @pk, @operation, @cdc_payload);
END
;;
DELIMITER ;
