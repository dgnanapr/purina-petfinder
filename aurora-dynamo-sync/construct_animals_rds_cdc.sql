
DROP PROCEDURE IF EXISTS construct_animals_rds_cdc;
DELIMITER ;;
CREATE PROCEDURE construct_animals_rds_cdc(IN animal_id INT, INOUT payload TEXT)
BEGIN
declare v_id	int(11) unsigned;
declare v_status	varchar(50);
declare v_created_by	varchar(255);
declare v_created_by_client_id	varchar(50);
declare v_created_by_user_id	int(10) unsigned;
declare v_created_at	datetime;
declare v_updated_at	datetime;
declare v_updated_by	varchar(255);
declare v_updated_by_client_id	varchar(50);
declare v_updated_by_user_id	int(10) unsigned;
declare v_arrival_date	date;
declare v_adoption_date	date;
declare v_birth_date	date;
declare v_description	text;
declare v_extended_description	varchar(300);
declare v_internal_notes	varchar(800);
declare v_special_needs_notes	text;
declare v_marked_for_deletion	tinyint(1) unsigned;
declare v_mixed_breed	tinyint(1) unsigned;
declare v_unknown_breed	tinyint(1) unsigned;
declare v_name	varchar(255);
declare v_organization_animal_identifier	varchar(255);
declare v_animal_age_id	int(10) unsigned;
declare v_animal_type_id	int(10) unsigned;
declare v_organization_contact_id	int(10) unsigned;
declare v_organization_location_id	int(10) unsigned;
declare v_animal_primary_breed_id	int(10) unsigned;
declare v_animal_primary_color_id	int(10) unsigned;
declare v_primary_photo_id	int(11) unsigned;
declare v_animal_secondary_breed_id	int(10) unsigned;
declare v_animal_secondary_color_id	int(10) unsigned;
declare v_animal_tertiary_color_id	int(10) unsigned;
declare v_animal_sex_id	int(10) unsigned;
declare v_animal_size_id	int(10) unsigned;
declare v_animal_species_id	int(10) unsigned;
declare v_animal_adoption_status_id	int(10) unsigned;
declare v_animal_coat_length_id	int(10) unsigned;
declare v_animal_arrival_option_id	int(10) unsigned;
declare v_adopter_adoption_inquiry_id	int(11) unsigned;
declare v_organization_id	int(11) unsigned;
declare v_adoption_status_change_date	datetime;
declare v_published_date	datetime;
declare v_transferred_date	datetime;
declare v_transferred_from_shelterid	varchar(255);
declare v_transferred_from_organization_id	int(11) unsigned;
declare v_tags	longtext;
declare v_adoption_fee	decimal(10,2) unsigned;
declare v_adoption_fee_waived	tinyint(1) unsigned;
declare v_display_adoption_fee	tinyint(1) unsigned;
declare v_import_updates_enabled	tinyint(1) unsigned;
declare v_import_deletes_enabled	tinyint(1) unsigned;
declare v_good_with_children	tinyint(1) unsigned;
declare v_good_with_dogs	tinyint(1) unsigned;
declare v_good_with_cats	tinyint(1) unsigned;
declare v_good_with_other_animals	tinyint(1) unsigned;
declare v_other_animals	varchar(255); 

DECLARE trigger_cursor CURSOR FOR (SELECT id,status,created_by,created_by_client_id,created_by_user_id,created_at,updated_at,updated_by,updated_by_client_id,updated_by_user_id,arrival_date,adoption_date,birth_date,description,extended_description,internal_notes,special_needs_notes,marked_for_deletion,mixed_breed,unknown_breed,name,organization_animal_identifier,animal_age_id,animal_type_id,organization_contact_id,organization_location_id,animal_primary_breed_id,animal_primary_color_id,primary_photo_id,animal_secondary_breed_id,animal_secondary_color_id,animal_tertiary_color_id,animal_sex_id,animal_size_id,animal_species_id,animal_adoption_status_id,animal_coat_length_id,animal_arrival_option_id,adopter_adoption_inquiry_id,organization_id,adoption_status_change_date,published_date,transferred_date,transferred_from_shelterid,transferred_from_organization_id,tags,adoption_fee,adoption_fee_waived,display_adoption_fee,import_updates_enabled,import_deletes_enabled,good_with_children,good_with_dogs,good_with_cats,good_with_other_animals,other_animals FROM animals WHERE id=animal_id);
-- SET payload = concat(@payload, " Hellooooooo");
OPEN trigger_cursor; 

FETCH trigger_cursor INTO v_id,v_status,v_created_by,v_created_by_client_id,v_created_by_user_id,v_created_at,v_updated_at,v_updated_by,v_updated_by_client_id,v_updated_by_user_id,v_arrival_date,v_adoption_date,v_birth_date,v_description,v_extended_description,v_internal_notes,v_special_needs_notes,v_marked_for_deletion,v_mixed_breed,v_unknown_breed,v_name,v_organization_animal_identifier,v_animal_age_id,v_animal_type_id,v_organization_contact_id,v_organization_location_id,v_animal_primary_breed_id,v_animal_primary_color_id,v_primary_photo_id,v_animal_secondary_breed_id,v_animal_secondary_color_id,v_animal_tertiary_color_id,v_animal_sex_id,v_animal_size_id,v_animal_species_id,v_animal_adoption_status_id,v_animal_coat_length_id,v_animal_arrival_option_id,v_adopter_adoption_inquiry_id,v_organization_id,v_adoption_status_change_date,v_published_date,v_transferred_date,v_transferred_from_shelterid,v_transferred_from_organization_id,v_tags,v_adoption_fee,v_adoption_fee_waived,v_display_adoption_fee,v_import_updates_enabled,v_import_deletes_enabled,v_good_with_children,v_good_with_dogs,v_good_with_cats,v_good_with_other_animals,v_other_animals ; 

SET payload = (SELECT CONCAT('{ \'id\' : \'', v_id, '\','));
IF v_status is NOT NULL THEN
    SET payload = CONCAT(payload,'\'status\' : \'', v_status, '\',');
END IF;
IF v_created_by is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by\' : \'', v_created_by, '\','); 
END IF;
IF v_created_by_client_id is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by_client_id\' : \'', v_created_by_client_id, '\','); 
END IF;
IF v_created_by_user_id is NOT NULL THEN
    SET payload = CONCAT(payload,'\'created_by_user_id\' : \'', v_created_by_user_id, '\','); 
END IF;
IF v_created_at is NOT NULL THEN
	SET payload = CONCAT(payload,'\'created_at\' : \'', v_created_at, '\',');
END IF;
IF v_updated_at is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_at\' : \'', v_updated_at, '\',');
END IF;
IF v_updated_by is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by\' : \'', v_updated_by, '\',');
END IF;
IF v_updated_by_client_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by_client_id\' : \'', v_updated_by_client_id, '\',');
END IF;
IF v_updated_by_user_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'updated_by_user_id\' : \'', v_updated_by_user_id, '\',');
END IF;
IF v_arrival_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'arrival_date\' : \'', v_arrival_date, '\',');
END IF;
IF v_adoption_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_date\' : \'', v_adoption_date, '\',');
END IF;
IF v_birth_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'birth_date\' : \'', v_birth_date, '\',');
END IF;
IF v_description is NOT NULL THEN
	SET payload = CONCAT(payload,'\'description\' : \'', v_description, '\',');
END IF;

IF v_extended_description is NOT NULL THEN
	SET payload = CONCAT(payload,'\'extended_description\' : \'', v_extended_description, '\',');
END IF;
IF v_internal_notes is NOT NULL THEN
	SET payload = CONCAT(payload,'\'internal_notes\' : \'', v_internal_notes, '\',');
END IF;
IF v_special_needs_notes is NOT NULL THEN
	SET payload = CONCAT(payload,'\'special_needs_notes\' : \'', v_special_needs_notes, '\',');
END IF;
IF v_marked_for_deletion is NOT NULL THEN
	SET payload = CONCAT(payload,'\'marked_for_deletion\' : \'', v_marked_for_deletion, '\',');
END IF;

IF v_mixed_breed is NOT NULL THEN
	SET payload = CONCAT(payload,'\'mixed_breed\' : \'', v_mixed_breed, '\',');
END IF;
IF v_unknown_breed is NOT NULL THEN
	SET payload = CONCAT(payload,'\'unknown_breed\' : \'', v_unknown_breed, '\',');
END IF;
IF v_name is NOT NULL THEN
	SET payload = CONCAT(payload,'\'name\' : \'', v_name, '\',');
END IF;
IF v_organization_animal_identifier is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_animal_identifier\' : \'', v_organization_animal_identifier, '\',');
END IF;

IF v_animal_age_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_age_id\' : \'',  (SELECT NAME FROM animal_ages WHERE ID= v_animal_age_id), '\',');
END IF;
IF v_animal_type_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_type_id\' : \'', (SELECT NAME FROM animal_types WHERE ID= v_animal_type_id), '\',');
END IF;
IF v_organization_contact_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_contact_id\' : \'', v_organization_contact_id, '\',');
END IF;
IF v_organization_location_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_location_id\' : \'', v_organization_location_id, '\',');
END IF;

IF v_animal_primary_breed_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_primary_breed_id\' : \'', (SELECT NAME FROM animal_breeds WHERE ID = v_animal_primary_breed_id), '\',');
END IF;
IF v_animal_primary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_primary_color_id\' : \'', (SELECT NAME FROM animal_colors WHERE ID = v_animal_primary_color_id AND animal_type_id=v_animal_type_id), '\',');
END IF;
IF v_primary_photo_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'primary_photo_id\' : \'', v_primary_photo_id, '\',');
END IF;
IF v_animal_secondary_breed_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_secondary_breed_id\' : \'',  (SELECT NAME FROM animal_breeds WHERE ID = v_animal_secondary_breed_id), '\',');
END IF;

IF v_animal_secondary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_secondary_color_id\' : \'',(SELECT NAME FROM animal_colors WHERE ID =  v_animal_secondary_color_id AND animal_type_id=v_animal_type_id), '\',');
END IF;
IF v_animal_tertiary_color_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_tertiary_color_id\' : \'', (SELECT NAME FROM animal_colors WHERE ID =  v_animal_tertiary_color_id AND animal_type_id=v_animal_type_id), '\',');
END IF;
IF v_animal_sex_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_sex_id\' : \'',(SELECT NAME FROM animal_sexes WHERE ID =  v_animal_sex_id), '\',');
END IF;
IF v_animal_size_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_size_id\' : \'',(SELECT NAME FROM animal_sizes WHERE ID =  v_animal_size_id), '\',');
END IF;

IF v_animal_species_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_species_id\' : \'', (SELECT NAME FROM animal_species WHERE ID =  v_animal_species_id AND animal_type_id=v_animal_type_id), '\',');
END IF;
IF v_animal_adoption_status_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_adoption_status_id\' : \'', (SELECT NAME FROM animal_adoption_statuses WHERE ID =  v_animal_adoption_status_id), '\',');
END IF;
IF v_animal_coat_length_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_coat_length_id\' : \'', (SELECT NAME FROM animal_coat_lengths WHERE ID =   v_animal_coat_length_id), '\',');
END IF;
IF v_animal_arrival_option_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'animal_arrival_option_id\' : \'', (SELECT NAME FROM animal_arrival_options WHERE ID =   v_animal_arrival_option_id), '\',');
END IF;
IF v_adopter_adoption_inquiry_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adopter_adoption_inquiry_id\' : \'', v_adopter_adoption_inquiry_id, '\',');
END IF;
IF v_organization_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'organization_id\' : \'', v_organization_id, '\',');
END IF;
IF v_adoption_status_change_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_status_change_date\' : \'', v_adoption_status_change_date, '\',');
END IF;
IF v_published_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'published_date\' : \'', v_published_date, '\',');
END IF;
IF v_transferred_date is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_date\' : \'', v_transferred_date, '\',');
END IF;
IF v_transferred_from_shelterid is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_from_shelterid\' : \'', v_transferred_from_shelterid, '\',');
END IF;
IF v_transferred_from_organization_id is NOT NULL THEN
	SET payload = CONCAT(payload,'\'transferred_from_organization_id\' : \'', v_transferred_from_organization_id, '\',');
END IF;
IF v_tags is NOT NULL THEN
	SET payload = CONCAT(payload,'\'tags\' : \'', v_tags, '\',');
END IF;
IF v_adoption_fee is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_fee\' : \'', v_adoption_fee, '\',');
END IF;
IF v_adoption_fee_waived is NOT NULL THEN
	SET payload = CONCAT(payload,'\'adoption_fee_waived\' : \'', v_adoption_fee_waived, '\',');
END IF;
IF v_display_adoption_fee is NOT NULL THEN
	SET payload = CONCAT(payload,'\'display_adoption_fee\' : \'', v_display_adoption_fee, '\',');
END IF;
IF v_import_updates_enabled is NOT NULL THEN
	SET payload = CONCAT(payload,'\'import_updates_enabled\' : \'', v_import_updates_enabled, '\',');
END IF;
IF v_import_deletes_enabled is NOT NULL THEN
	SET payload = CONCAT(payload,'\'import_deletes_enabled\' : \'', v_import_deletes_enabled, '\',');
END IF;
IF v_good_with_children is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_children\' : \'', v_good_with_children, '\',');
END IF;
IF v_good_with_dogs is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_dogs\' : \'', v_good_with_dogs, '\',');
END IF;
IF v_good_with_cats is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_cats\' : \'', v_good_with_cats, '\',');
END IF;
IF v_good_with_other_animals is NOT NULL THEN
	SET payload = CONCAT(payload,'\'good_with_other_animals\' : \'', v_good_with_other_animals, '\',');
END IF;
IF v_other_animals is NOT NULL THEN
	SET payload = CONCAT(payload,'\'other_animals\' : \'', v_other_animals, '\',');
END IF;
	SET payload = CONCAT(payload,'\'NOT_FROM_TABLE\' : \'', 'NOT-FROM-TABLE', '\'');
	SET payload=CONCAT(payload, '}');
 
CLOSE trigger_cursor; 
    
END 
;;
DELIMITER ;