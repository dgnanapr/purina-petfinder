DROP PROCEDURE IF EXISTS rds_dynamo_batch_animals;

DELIMITER ;;
CREATE  PROCEDURE `rds_dynamo_batch_animals`(IN s3url VARCHAR(2000), IN  START_ID BIGINT, IN  END_ID BIGINT )
BEGIN
     SET @S3_URL = CONCAT(s3url, "animals","/",START_ID,"-",END_ID);
		SELECT CONCAT("
        Select id,
        status,
		created_by,
		created_by_client_id,
		created_by_user_id,
		created_at,
		updated_at,
		updated_by,
		updated_by_client_id,
		updated_by_user_id,
		arrival_date,
		adoption_date,
		birth_date,
		description,
		extended_description,
		internal_notes,
		special_needs_notes,
		marked_for_deletion,
		mixed_breed,
		unknown_breed,
		name,
		organization_animal_identifier,
		(SELECT NAME FROM animal_ages WHERE ID = animal_age_id) animal_age_id,
		(SELECT NAME FROM animal_types WHERE ID=  animal_type_id) animal_type_id,
		organization_contact_id,
		organization_location_id,
		(SELECT NAME FROM animal_breeds WHERE ID =  animal_primary_breed_id) animal_primary_breed_id,
		(SELECT NAME FROM animal_colors WHERE ID =  animal_primary_color_id AND animal_type_id = animal_type_id) animal_primary_color_id,
		primary_photo_id,
		(SELECT NAME FROM animal_breeds WHERE ID =  animal_secondary_breed_id) animal_secondary_breed_id,
		(SELECT NAME FROM animal_colors WHERE ID =   animal_secondary_color_id AND animal_type_id= animal_type_id) animal_secondary_color_id,
		(SELECT NAME FROM animal_colors WHERE ID =   animal_tertiary_color_id AND animal_type_id= animal_type_id) animal_tertiary_color_id,
		(SELECT NAME FROM animal_sexes WHERE ID =   animal_sex_id) animal_sex_id,
		(SELECT NAME FROM animal_sizes WHERE ID =   animal_size_id)animal_size_id,
		(SELECT NAME FROM animal_species WHERE ID =   animal_species_id AND animal_type_id= animal_type_id) animal_species_id,
		(SELECT NAME FROM animal_adoption_statuses WHERE ID = animal_adoption_status_id)  animal_adoption_status_id,
		(SELECT NAME FROM animal_coat_lengths WHERE ID =   animal_coat_length_id) animal_coat_length_id,
		(SELECT NAME FROM animal_arrival_options WHERE ID =    animal_arrival_option_id) animal_arrival_option_id,
		adopter_adoption_inquiry_id,
		organization_id,
		adoption_status_change_date,
		published_date,
		transferred_date,
		transferred_from_shelterid,
		transferred_from_organization_id,
		tags,
		adoption_fee,
		adoption_fee_waived,
		display_adoption_fee,
		import_updates_enabled,
		import_deletes_enabled,
		good_with_children,
		good_with_dogs,
		good_with_cats,
		good_with_other_animals,
		other_animals
		from animals 
		where id between ",  START_ID, " and ", END_ID, " 
		INTO OUTFILE S3 '", @S3_URL, 
		"' FIELDS TERMINATED BY ',' ",
		" LINES TERMINATED BY '\n' OVERWRITE ON") INTO @SQL;
        PREPARE stmt1 FROM @SQL;
        EXECUTE stmt1 ;
        DEALLOCATE PREPARE stmt1; 
  END
  ;;
DELIMITER ;
 