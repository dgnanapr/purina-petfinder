DROP TRIGGER animals_AFTER_INSERT;
DELIMITER ;;
CREATE TRIGGER animals_AFTER_INSERT
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
 SELECT New.id, 'i' INTO @id, @flag;
   CALL insert_animal_record(@id, @flag); 
 END
;;
DELIMITER ;
