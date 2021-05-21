--  Step 3.2 Create rds_cdc_TR_animals_AI  TRIGGER , this triggers calls the rds_lambda_cdc to send cdc data to a common lambda function rds_lamdbda_sns
DELIMITER ;;
CREATE TRIGGER rds_cdc_TR_animals_AI
  AFTER INSERT ON animals
  FOR EACH ROW
BEGIN
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
IF NEW.created_by_user_id is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by_user_id\' : \'', NEW.created_by_user_id, '\','); 
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

IF NEW.extended_description is NOT NULL THEN
	SET payload = CONCAT(payload,'\'extended_description\' : \'', NEW.extended_description, '\',');
END IF;
IF NEW.internal_notes is NOT NULL THEN
	SET payload = CONCAT(payload,'\'internal_notes\' : \'', NEW.internal_notes, '\',');
END IF;
IF NEW.special_needs_notes is NOT NULL THEN
	SET payload = CONCAT(payload,'\'special_needs_notes\' : \'', NEW.special_needs_notes, '\',');
END IF;
IF NEW.marked_for_deletion is NOT NULL THEN
	SET payload = CONCAT(payload,'\'marked_for_deletion\' : \'', NEW.marked_for_deletion, '\',');
END IF;

IF NEW.mixed_breed is NOT NULL THEN
	SET payload = CONCAT(payload,'\'mixed_breed\' : \'', NEW.mixed_breed, '\',');
END IF;
IF NEW.unknown_breed is NOT NULL THEN
	SET payload = CONCAT(payload,'\'unknown_breed\' : \'', NEW.unknown_breed, '\',');
END IF;
IF NEW.name is NOT NULL THEN
	SET payload = CONCAT(payload,'\'name\' : \'', NEW.name, '\',');
END IF;
IF NEW.organization_animal_identifier is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_animal_identifier\' : \'', NEW.organization_animal_identifier, '\',');
END IF;

IF NEW.animal_age_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_age_id\' : \'', NEW.animal_age_id, '\',');
END IF;
IF NEW.animal_type_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_type_id\' : \'', NEW.animal_type_id, '\',');
END IF;
IF NEW.organization_contact_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_contact_id\' : \'', NEW.organization_contact_id, '\',');
END IF;
IF NEW.organization_location_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_location_id\' : \'', NEW.organization_location_id, '\',');
END IF;

IF NEW.animal_primary_breed_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_primary_breed_id\' : \'', NEW.animal_primary_breed_id, '\',');
END IF;
IF NEW.animal_primary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_primary_color_id\' : \'', NEW.animal_primary_color_id, '\',');
END IF;
IF NEW.primary_photo_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'primary_photo_id\' : \'', NEW.primary_photo_id, '\',');
END IF;
IF NEW.animal_secondary_breed_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_secondary_breed_id\' : \'', NEW.animal_secondary_breed_id, '\',');
END IF;

IF NEW.animal_secondary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_secondary_color_id\' : \'', NEW.animal_secondary_color_id, '\',');
END IF;
IF NEW.animal_tertiary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_tertiary_color_id\' : \'', NEW.animal_tertiary_color_id, '\',');
END IF;
IF NEW.animal_sex_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_sex_id\' : \'', NEW.animal_sex_id, '\',');
END IF;
IF NEW.animal_size_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_size_id\' : \'', NEW.animal_size_id, '\',');
END IF;

IF NEW.animal_species_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_species_id\' : \'', NEW.animal_species_id, '\',');
END IF;
IF NEW.animal_adoption_status_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_adoption_status_id\' : \'', NEW.animal_adoption_status_id, '\',');
END IF;
IF NEW.animal_coat_length_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_coat_length_id\' : \'', NEW.animal_coat_length_id, '\',');
END IF;
IF NEW.animal_arrival_option_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_arrival_option_id\' : \'', NEW.animal_arrival_option_id, '\',');
END IF;
IF NEW.adopter_adoption_inquiry_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adopter_adoption_inquiry_id\' : \'', NEW.adopter_adoption_inquiry_id, '\',');
END IF;
IF NEW.organization_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_id\' : \'', NEW.organization_id, '\',');
END IF;
IF NEW.adoption_status_change_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_status_change_date\' : \'', NEW.adoption_status_change_date, '\',');
END IF;
IF NEW.published_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'published_date\' : \'', NEW.published_date, '\',');
END IF;
IF NEW.transferred_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_date\' : \'', NEW.transferred_date, '\',');
END IF;
IF NEW.transferred_from_shelterid is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_from_shelterid\' : \'', NEW.transferred_from_shelterid, '\',');
END IF;
IF NEW.transferred_from_organization_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_from_organization_id\' : \'', NEW.transferred_from_organization_id, '\',');
END IF;
IF NEW.tags is NOT NULL THEN
	SET payload = CONCAT(payload,'\'tags\' : \'', NEW.tags, '\',');
END IF;
IF NEW.adoption_fee is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_fee\' : \'', NEW.adoption_fee, '\',');
END IF;
IF NEW.adoption_fee_waived is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_fee_waived\' : \'', NEW.adoption_fee_waived, '\',');
END IF;
IF NEW.display_adoption_fee is NOT NULL THEN
	SET payload = CONCAT(payload,'\'display_adoption_fee\' : \'', NEW.display_adoption_fee, '\',');
END IF;
IF NEW.import_updates_enabled is NOT NULL THEN
	SET payload = CONCAT(payload,'\'import_updates_enabled\' : \'', NEW.import_updates_enabled, '\',');
END IF;
IF NEW.import_deletes_enabled is NOT NULL THEN
	SET payload = CONCAT(payload,'\'import_deletes_enabled\' : \'', NEW.import_deletes_enabled, '\',');
END IF;
IF NEW.good_with_children is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_children\' : \'', NEW.good_with_children, '\',');
END IF;
IF NEW.good_with_dogs is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_dogs\' : \'', NEW.good_with_dogs, '\',');
END IF;
IF NEW.good_with_cats is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_cats\' : \'', NEW.good_with_cats, '\',');
END IF;
IF NEW.good_with_other_animals is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_other_animals\' : \'', NEW.good_with_other_animals, '\',');
END IF;
IF NEW.other_animals is NOT NULL THEN
	SET payload = CONCAT(payload,'\'other_animals\' : \'', NEW.other_animals, '\',');
END IF;
	SET payload = CONCAT(payload,'\'NOT_FROM_TABLE\' : \'', 'NOT_FROM_TABLE', '\'');
	SET payload=CONCAT(payload, '}');
CALL rds_lambda_cdc('animals', 'i'  ,payload);
END
;;
DELIMITER ; 