SET AUTOCOMMIT=0;

SET UNIQUE_CHECKS=0;

SET FOREIGN_KEY_CHECKS=0;

# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 10.99.42.100 (MySQL 5.6.25)
# Database: petfinder
# Generation Time: 2016-04-15 15:39:38 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS petfinder /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE petfinder;

# Table: address
# ------------------------------------------------------------
DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `address_type` VARCHAR(31) NOT NULL,
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(255) DEFAULT NULL,
  `geo_info_accuracy` INT(11) DEFAULT NULL,
  `is_private_street` TINYINT(1) NOT NULL DEFAULT '0',
  `latitude` VARCHAR(255) DEFAULT NULL,
  `longitude` VARCHAR(255) DEFAULT NULL,
  `postal_code` VARCHAR(255) DEFAULT NULL,
  `street` VARCHAR(255) DEFAULT NULL,
  `street2` VARCHAR(255) DEFAULT NULL,
  `country_id` int(10) unsigned DEFAULT NULL,
  `state_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBB979BF497F2392B` (`country_id`),
  KEY `FKBB979BF43ED83E3E` (`state_id`),
  CONSTRAINT `fk_addresses_countries_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`),
  CONSTRAINT `fk_addresses_states_state_id` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: adoption_inquiries
# ------------------------------------------------------------
DROP TABLE IF EXISTS `adoption_inquiries`;

CREATE TABLE `adoption_inquiries` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) unsigned DEFAULT NULL,
  `animal_id` int(11) unsigned DEFAULT NULL,
  `type_id` int(10) unsigned NOT NULL,
  `primary_breed_id` int(10) unsigned DEFAULT NULL,
  `secondary_breed_id` int(10) unsigned DEFAULT NULL,
  `size_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `guest_id` int(11) DEFAULT NULL,
  `animal_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `comments` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `sent_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_53837E3D9A4AA658` (`guest_id`),
  KEY `IDX_B122C7A0A76ED395` (`user_id`),
  KEY `idx_adoption_inquiries_pet_id` (`animal_id`,`created_at`),
  KEY `idx_adoption_inquiries_shelter_id` (`organization_id`),
  KEY `idx_shelter_id_created_at` (`organization_id`,`created_at`),
  CONSTRAINT `FK_53837E3D9A4AA658` FOREIGN KEY (`guest_id`) REFERENCES `guest_profiles` (`id`),
  CONSTRAINT `FK_7C8A9055C8E84CBD8918F6126D92BDD6` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_AC199DA15EA6F7C8705AF25FC05D25D6` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE SET NULL,
  CONSTRAINT `FK_B122C7A0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: alert
# ------------------------------------------------------------
DROP TABLE IF EXISTS `alert`;

CREATE TABLE `alert` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by_client_id` VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `message` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link_text` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `start_date` DATETIME DEFAULT NULL,
  `end_date` DATETIME DEFAULT NULL,
  `created_by` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by` VARCHAR(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_created_by_client_id` (`created_by_client_id`),
  INDEX `idx_updated_by_client_id` (`updated_by_client_id`),
  INDEX `idx_created_by_user_id` (`created_by_user_id`),
  INDEX `idx_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `fk_452fcd0091b5b03676bc00a21d3418eb` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_a2c3401c3f9c48ffff85705cbdfbbe58` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_84b5a6245e725b377538ec17cc585322` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_7ac6687f84b75af6dbd40c0d1b5b2430` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: animal_ages
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_ages`;

CREATE TABLE `animal_ages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


# Table: animal_animal_attributes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_animal_attributes`;

CREATE TABLE `animal_animal_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_id` int(10) unsigned NOT NULL,
  `animal_attribute_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `animal_id_fk` (`animal_id`,`animal_attribute_id`),
  KEY `FK12431ED710D3A7E8` (`animal_attribute_id`),
  KEY `FK12431ED770FDD958` (`animal_id`),
  CONSTRAINT `FK12431ED710D3A7E8` FOREIGN KEY (`animal_attribute_id`) REFERENCES `animal_attributes` (`id`),
  CONSTRAINT `FK12431ED770FDD958` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


# Table: animal_arrival_options
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_arrival_options`;

CREATE TABLE `animal_arrival_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;


# Table: animal_attributes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_attributes`;

CREATE TABLE `animal_attributes` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `refCode` varchar(255) DEFAULT NULL,
  `standard` tinyint(1) UNSIGNED NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `std_idx` (`standard`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;


# Table: animal_breeds
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_breeds`;

CREATE TABLE `animal_breeds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `animal_species_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`animal_type_id`,`animal_species_id`) USING BTREE,
  KEY `FK59A597474D8504D` (`animal_type_id`),
  KEY `FK59A597426CDB7F7` (`animal_species_id`)
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=latin1;


# Table: animal_coat_length
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_coat_lengths`;

CREATE TABLE `animal_coat_lengths` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;


# Table: animal_colors
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_colors`;

CREATE TABLE `animal_colors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`animal_type_id`) USING BTREE,
  KEY `FK5A72F6374D8504D` (`animal_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=latin1;


# Table: animal_histories
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_histories`;

CREATE TABLE `animal_histories` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_by_client_id` varchar(50) DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by_client_id` varchar(50) DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `animal_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `metadata` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_animal_id` (`animal_id`),
  KEY `idx_contact_id` (`contact_id`),
  KEY `fk_c8a783fed277a10c405c33aa23fafda8` (`created_by_client_id`),
  KEY `fk_d23cb1ab7d8fefed88e816fbe26d5543` (`updated_by_client_id`),
  KEY `fk_eb6273f55ec7033f1cd2fcea0797d222` (`created_by_user_id`),
  KEY `fk_b4309b4a147c70c8e9880469f471d73c` (`updated_by_user_id`),
  CONSTRAINT `fk_af3cf30f9d9412ec248f892259031486` FOREIGN KEY (`contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_b4309b4a147c70c8e9880469f471d73c` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_c8a783fed277a10c405c33aa23fafda8` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_d23cb1ab7d8fefed88e816fbe26d5543` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_eb6273f55ec7033f1cd2fcea0797d222` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_f1acd675c0163002f244386449d19fd9` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: animal_identification
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_identification`;

CREATE TABLE `animal_identification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `date_applied` datetime DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `animal_id_fk` bigint(20) DEFAULT NULL,
  `specialBrand` varchar(255) DEFAULT NULL,
  `specialDescription` varchar(255) DEFAULT NULL,
  `specialId` varchar(255) DEFAULT NULL,
  `specialIdType` varchar(255) DEFAULT NULL,
  `specialLocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK854EEB1170FDD958` (`animal_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: animal_media
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_media`;


# Table: animal_photos
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_photos`;
CREATE TABLE `animal_photos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) unsigned NOT NULL,
  `media_id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `cropped_media_id` char(36) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `index` int(11) unsigned NOT NULL DEFAULT '1',
  `created_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8D95F3E170FDD958` (`animal_id`),
  KEY `updated` (`updated_at`),
  KEY `fk_12a03fdaadd3eb593ff608ae4129994f` (`created_by_client_id`),
  KEY `fk_a193d49a0d5e4c0c334f4381d4a56c52` (`updated_by_client_id`),
  KEY `fk_314b93935ff7d83c5897ab27b1bca6a1` (`created_by_user_id`),
  KEY `fk_559f47323afdae7ec53f0ec7703d3e43` (`updated_by_user_id`),
  KEY `fk_982e5637327da0db5662b701623d9064` (`cropped_media_id`),
  KEY `fk_cc1c92b33dfa61e6773a868a8777f948` (`media_id`),
  KEY `idx_animal_id_created_at` (`animal_id`,`created_at`),
  CONSTRAINT `fk_9d04ce3728f186915fcc58b061eb730c` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`),
  CONSTRAINT `fk_cc1c92b33dfa61e6773a868a8777f948` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `fk_982e5637327da0db5662b701623d9064` FOREIGN KEY (`cropped_media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `fk_12a03fdaadd3eb593ff608ae4129994f` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_a193d49a0d5e4c0c334f4381d4a56c52` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_314b93935ff7d83c5897ab27b1bca6a1` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_559f47323afdae7ec53f0ec7703d3e43` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: animal_saved_search_delivery_methods
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_saved_search_delivery_methods`;
CREATE TABLE `animal_saved_search_delivery_methods` (
  `id` char(36) NOT NULL DEFAULT '',
  `animal_saved_search_id` char(36) NOT NULL DEFAULT '',
  `method` enum('email') NOT NULL DEFAULT 'email',
  `frequency` enum('daily') NOT NULL DEFAULT 'daily',
  `trigger` enum('new') NOT NULL DEFAULT 'new',
  `last_notification_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animal_saved_search_delivery_methods_animal_saved_search` (`animal_saved_search_id`),
  CONSTRAINT `fk_animal_saved_search_delivery_methods_animal_saved_search` FOREIGN KEY (`animal_saved_search_id`) REFERENCES `animal_saved_searches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# Table: animal_saved_searches
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_saved_searches`;
CREATE TABLE `animal_saved_searches` (
  `id` char(36) NOT NULL DEFAULT '',
  `created_by_client_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `last_view_date` datetime DEFAULT NULL,
  `location_name` varchar(100) DEFAULT NULL,
  `latitude` float(10,6) DEFAULT NULL,
  `longitude` float(10,6) DEFAULT NULL,
  `within` smallint(6) unsigned DEFAULT NULL,
  `name_query` varchar(100) DEFAULT NULL,
  `animal_type_id` int(10) unsigned DEFAULT NULL,
  `animal_species_id` int(10) unsigned DEFAULT NULL,
  `adoption_status_id` int(10) unsigned DEFAULT NULL,
  `animal_breed_ids` text DEFAULT NULL,
  `animal_age_ids` varchar(100) DEFAULT NULL,
  `animal_sex_ids` varchar(100) DEFAULT NULL,
  `animal_size_ids` varchar(100) DEFAULT NULL,
  `animal_color_ids` varchar(100) DEFAULT NULL,
  `animal_coat_length_ids` varchar(100) DEFAULT NULL,
  `animal_attribute_ids` varchar(100) DEFAULT NULL,
  `good_with_children` enum('yes','no','unknown') DEFAULT NULL,
  `good_with_dogs` enum('yes','no','unknown') DEFAULT NULL,
  `good_with_cats` enum('yes','no','unknown') DEFAULT NULL,
  `good_with_other_animals` enum('yes','no','unknown') DEFAULT NULL,
  `organization_ids` varchar(100) DEFAULT NULL,
  `animal_ids` varchar(100) DEFAULT NULL,
  `published_before` smallint(4) unsigned DEFAULT NULL,
  `published_after` smallint(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animal_saved_search_animal_type_id_animal_type` (`animal_type_id`),
  KEY `fk_animal_saved_searches_animal_species_id` (`animal_species_id`),
  KEY `fk_animal_saved_searches_adoption_status_id` (`adoption_status_id`),
  KEY `fk_animal_saved_searches_user_id` (`user_id`),
  KEY `fk_animal_saved_searches_created_by_client_id` (`created_by_client_id`),
  KEY `fk_animal_saved_searches_updated_by_client_id` (`updated_by_client_id`),
  KEY `fk_animal_saved_searches_created_by_user_id` (`created_by_user_id`),
  KEY `fk_animal_saved_searches_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `fk_animal_saved_search_animal_type_id_animal_type` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`),
  CONSTRAINT `fk_animal_saved_searches_adoption_status_id` FOREIGN KEY (`adoption_status_id`) REFERENCES `animal_adoption_statuses` (`id`),
  CONSTRAINT `fk_animal_saved_searches_animal_species_id` FOREIGN KEY (`animal_species_id`) REFERENCES `animal_species` (`id`),
  CONSTRAINT `fk_animal_saved_searches_created_by_client_id` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_animal_saved_searches_created_by_user_id` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_animal_saved_searches_updated_by_client_id` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_animal_saved_searches_updated_by_user_id` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_animal_saved_searches_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# Table: animal_videos
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_videos`;
CREATE TABLE `animal_videos` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `animal_id` INT(11) UNSIGNED NOT NULL,
  `media_id` CHAR(36) COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `index` INT(11) UNSIGNED NOT NULL DEFAULT '1',
  `type` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `video_id` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `video_service` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `processing_status` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `processing_status_description` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `video_embed_code` VARCHAR(1024) DEFAULT NULL,
  `created_by` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `updated_by` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_processing_status` (`processing_status`),
  INDEX `idx_updated_at` (`updated_at`),
  CONSTRAINT `fk_5dfded1fa7e0813c9baac388dbe692fe` FOREIGN KEY (`animal_id`) REFERENCES `animals` (`id`),
  CONSTRAINT `fk_0849b97d6296c855621a493049c51d07` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_3d345c56be3025c1ca06f5170bdc2c47` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_bfaf9b7712c30b1b3cb633d76aa0b1f3` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_c7a43e7de6ca7661be8ecc720331d2a4` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_742466625ed7662bfaa06970b89a62fa` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: animal_sexes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_sexes`;

CREATE TABLE `animal_sexes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


# Table: animal_sizes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_sizes`;

CREATE TABLE `animal_sizes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;


# Table: animal_species
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_species`;

CREATE TABLE `animal_species` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`animal_type_id`) USING BTREE,
  KEY `FK8849413C74D8504D` (`animal_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;


# Table: animal_adoption_statuses
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_adoption_statuses`;

CREATE TABLE `animal_adoption_statuses` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) DEFAULT NULL,
  `rank` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;


# Table: animal_types
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_types`;

CREATE TABLE `animal_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned DEFAULT NULL,
  `slug` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rank` (`rank`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;


# Table: animal_types_animal_attributes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_types_animal_attributes`;

CREATE TABLE `animal_types_animal_attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `animal_attribute_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_e699a38547e4211081dc74713f9736da` (`animal_type_id`),
  KEY `fk_e83f47a1c68acb9895f5be8b8ca97939` (`animal_attribute_id`),
  CONSTRAINT `fk_e699a38547e4211081dc74713f9736da` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`),
  CONSTRAINT `fk_e83f47a1c68acb9895f5be8b8ca97939` FOREIGN KEY (`animal_attribute_id`) REFERENCES `animal_attributes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;


# Table: animal_types_animal_coat_lengths
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_types_animal_coat_lengths`;

CREATE TABLE `animal_types_animal_coat_lengths` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `animal_coat_length_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coatlength_id_fk` (`animal_coat_length_id`,`animal_type_id`),
  KEY `FK133BBBE474D8504D` (`animal_type_id`),
  KEY `FK133BBBE4919A431F` (`animal_coat_length_id`),
  CONSTRAINT `fk_87f3c92168eb0c09ff82e50c83d2c315` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`),
  CONSTRAINT `fk_90fd2756c5ca2890d0935e382c4f6a84` FOREIGN KEY (`animal_coat_length_id`) REFERENCES `animal_coat_lengths` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

# Table: animal_types_animal_sexes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_types_animal_sexes`;

CREATE TABLE `animal_types_animal_sexes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `animal_type_id` int(10) unsigned NOT NULL,
  `animal_sex_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sex_id_fk` (`animal_sex_id`,`animal_type_id`),
  KEY `FK8A8EECC474D8504D` (`animal_type_id`),
  KEY `FK8A8EECC48A9BF94B` (`animal_sex_id`),
  CONSTRAINT `fk_be32b301acb99706abcf9a93148e98d9` FOREIGN KEY (`animal_sex_id`) REFERENCES `animal_sexes` (`id`),
  CONSTRAINT `fk_ee00cf8078e7f99d64c48770446548db` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;


# Table: animal_templates
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_templates`;

CREATE TABLE `animal_templates` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by` VARCHAR(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `description` LONGTEXT,
  `is_mixed_breed` TINYINT(1) NOT NULL,
  `is_unknown_breed` TINYINT(1) NOT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `good_with_cats` TINYINT(1) NULL,
  `good_with_dogs` TINYINT(1) NULL,
  `good_with_children` TINYINT(1) NULL,
  `good_with_other_animals` TINYINT(1) NULL,
  `other_animals` VARCHAR(255) NULL,
  `age_id` INT(10)  UNSIGNED NULL DEFAULT NULL,
  `type_id` INT(10)  UNSIGNED NULL DEFAULT NULL,
  `coat_length_id` INT(10) UNSIGNED  NULL  DEFAULT NULL,
  `contact_id` INT(10) UNSIGNED NULL,
  `location_id` INT(10) UNSIGNED NULL,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `primary_breed_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `primary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `secondary_breed_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `secondary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `tertiary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `sex_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `size_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `species_id` INT(10)  UNSIGNED NULL DEFAULT NULL,
  `arrival_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `special_needs_notes` TEXT  NULL,
  `adoption_fee` DECIMAL(10,2) NULL DEFAULT NULL,
  `adoption_fee_waived` TINYINT(1) NOT NULL,
  `display_adoption_fee` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animal_templates_animal_ages_age_id` (`age_id`),
  KEY `fk_animal_templates_animal_types_type_id` (`type_id`),
  KEY `fk_animal_templates_animal_coat_lengths_coat_length_id` (`coat_length_id`),
  KEY `fk_animal_templates_organizations_organization_id` (`organization_id`),
  KEY `fk_animal_templates_animal_breeds_primary_breed_id` (`primary_breed_id`),
  KEY `fk_animal_templates_animal_colors_primary_color_id` (`primary_color_id`),
  KEY `fk_animal_templates_animal_breeds_secondary_breed_id` (`secondary_breed_id`),
  KEY `fk_animal_templates_animal_colors_secondary_color_id` (`secondary_color_id`),
  KEY `fk_animal_templates_animal_colors_tertiary_color_id` (`tertiary_color_id`),
  KEY `fk_animal_templates_animal_sexes_sex_id` (`sex_id`),
  KEY `fk_animal_templates_animal_sizes_size_id` (`size_id`),
  KEY `fk_animal_templates_animal_species_species_id` (`species_id`),
  KEY `fk_animal_templates_animal_arrival_options_arrival_id` (`arrival_id`),
  KEY `fk_animal_templates_oauth2_clients_created_by_client_id` (`created_by_client_id`),
  KEY `fk_animal_templates_oauth2_clients_updated_by_client_id` (`updated_by_client_id`),
  KEY `fk_animal_templates_sys_users_created_by_user_id` (`created_by_user_id`),
  KEY `fk_animal_templates_sys_users_updated_by_user_id` (`updated_by_user_id`),
  KEY `fk_animal_templates_organization_locations_location_id` (`location_id`),
  KEY `fk_animal_templates_organization_contacts_contact_id` (`contact_id`),
  CONSTRAINT `fk_animal_templates_animal_ages_age_id` FOREIGN KEY (`age_id`) REFERENCES `animal_ages` (`id`),
  CONSTRAINT `fk_animal_templates_animal_arrival_options_arrival_id` FOREIGN KEY (`arrival_id`) REFERENCES `animal_arrival_options` (`id`),
  CONSTRAINT `fk_animal_templates_animal_breeds_primary_breed_id` FOREIGN KEY (`primary_breed_id`) REFERENCES `animal_breeds` (`id`),
  CONSTRAINT `fk_animal_templates_animal_breeds_secondary_breed_id` FOREIGN KEY (`secondary_breed_id`) REFERENCES `animal_breeds` (`id`),
  CONSTRAINT `fk_animal_templates_animal_coat_lengths_coat_length_id` FOREIGN KEY (`coat_length_id`) REFERENCES `animal_coat_lengths` (`id`),
  CONSTRAINT `fk_animal_templates_animal_colors_primary_color_id` FOREIGN KEY (`primary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animal_templates_animal_colors_secondary_color_id` FOREIGN KEY (`secondary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animal_templates_animal_colors_tertiary_color_id` FOREIGN KEY (`tertiary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animal_templates_animal_sexes_sex_id` FOREIGN KEY (`sex_id`) REFERENCES `animal_sexes` (`id`),
  CONSTRAINT `fk_animal_templates_animal_sizes_size_id` FOREIGN KEY (`size_id`) REFERENCES `animal_sizes` (`id`),
  CONSTRAINT `fk_animal_templates_animal_species_species_id` FOREIGN KEY (`species_id`) REFERENCES `animal_species` (`id`),
  CONSTRAINT `fk_animal_templates_animal_types_type_id` FOREIGN KEY (`type_id`) REFERENCES `animal_types` (`id`),
  CONSTRAINT `fk_animal_templates_oauth2_clients_created_by_client_id` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_animal_templates_oauth2_clients_updated_by_client_id` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_animal_templates_organization_contacts_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_animal_templates_organization_locations_location_id` FOREIGN KEY (`location_id`) REFERENCES `organization_locations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_animal_templates_organizations_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_animal_templates_sys_users_created_by_user_id` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_animal_templates_sys_users_updated_by_user_id` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: animal_updates
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_templates_animal_attributes`;

CREATE TABLE `animal_templates_animal_attributes` (
  `template_id` int(11) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`template_id`,`attribute_id`),
  CONSTRAINT `fk_animal_templates_animal_attributes_template_id` FOREIGN KEY (`template_id`) REFERENCES `animal_templates` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_animal_templates_animal_attributes_attribute_id` FOREIGN KEY (`attribute_id`) REFERENCES `animal_attributes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: animal_updates
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animal_updates`;

CREATE TABLE `animal_updates` (
  `sequence` int(11) NOT NULL AUTO_INCREMENT,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `animal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: animals
# ------------------------------------------------------------
DROP TABLE IF EXISTS `animals`;

CREATE TABLE `animals` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` ENUM('draft', 'published', 'deleted', 'archived') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'draft',
  `created_by` varchar(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `arrival_date` DATE NOT NULL,
  `adoption_date` DATE DEFAULT NULL,
  `birth_date` DATE DEFAULT NULL,
  `description` TEXT,
  `extended_description` VARCHAR(300) NULL DEFAULT NULL,
  `internal_notes` VARCHAR(800) NULL DEFAULT NULL,
  `special_needs_notes` TEXT NULL,
  `mixed_breed` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `unknown_breed` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(255) DEFAULT NULL,
  `organization_animal_identifier` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `animal_age_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_type_id` INT(10) UNSIGNED NOT NULL,
  `organization_contact_id` INT(10) UNSIGNED NULL,
  `organization_location_id` INT(10) UNSIGNED NULL,
  `animal_primary_breed_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_primary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `primary_photo_id` INT(11) UNSIGNED NULL DEFAULT NULL,
  `animal_secondary_breed_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_secondary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_tertiary_color_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_sex_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_size_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_species_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_adoption_status_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_coat_length_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `animal_arrival_option_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `adopter_adoption_inquiry_id` INT(11) UNSIGNED NULL DEFAULT NULL,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `adoption_status_change_date` DATETIME NULL DEFAULT NULL,
  `published_date` datetime DEFAULT NULL,
  `transferred_date` DATETIME DEFAULT NULL,
  `transferred_from_organization_id` INT(11) UNSIGNED DEFAULT NULL,
  `tags` LONGTEXT,
  `adoption_fee` DECIMAL(10,2) UNSIGNED DEFAULT NULL,
  `adoption_fee_waived` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `display_adoption_fee` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0',
  `import_updates_enabled` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1',
  `import_deletes_enabled` TINYINT(1) UNSIGNED NOT NULL DEFAULT '1',
  `good_with_children` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `good_with_dogs` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `good_with_cats` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `good_with_other_animals` TINYINT(1) UNSIGNED NULL DEFAULT NULL,
  `other_animals` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKABC58DFC249615C` (`animal_secondary_breed_id`),
  KEY `FKABC58DFC2706A88A` (`organization_location_id`),
  KEY `FKABC58DFCC122C709` (`organization_contact_id`),
  KEY `FKABC58DFC26CDB7F7` (`animal_species_id`),
  KEY `FKABC58DFC74D8504D` (`animal_type_id`),
  KEY `FKABC58DFC77DBBD` (`animal_age_id`),
  KEY `FKABC58DFCBDD341DB` (`primary_photo_id`),
  KEY `FKABC58DFC10E598EA` (`animal_primary_breed_id`),
  KEY `FKABC58DFCCA3CD588` (`animal_primary_color_id`),
  KEY `FKABC58DFCBBA09DFA` (`animal_secondary_color_id`),
  KEY `FKABC58DFC8A9BF94B` (`animal_sex_id`),
  KEY `FKABC58DFC1654E3B7` (`animal_size_id`),
  KEY `FKABC58DFCE743B191` (`animal_adoption_status_id`),
  KEY `FKABC58DFC9ED822A0` (`animal_coat_length_id`),
  KEY `shelter_animal_id` (`organization_animal_identifier`),
  KEY `updated` (`updated_at`),
  KEY `idx_org_status` (`organization_id`, `status`, `animal_adoption_status_id`, `updated_at`),
  KEY `fk_animals_animal_tertiary_color_id` (`animal_tertiary_color_id`),
  KEY `fk_animals_animal_arrival_option_id` (`animal_arrival_option_id`),
  KEY `fk_transferred_from_organization_id` (`transferred_from_organization_id`),
  CONSTRAINT `fk_4ca82ea98fa13c1b38a0de1945f97740` FOREIGN KEY (`adopter_adoption_inquiry_id`) REFERENCES `adoption_inquiries` (`id`),
  CONSTRAINT `fk_animals_adoption_status_id` FOREIGN KEY (`animal_adoption_status_id`) REFERENCES `animal_adoption_statuses` (`id`),
  CONSTRAINT `fk_animals_animal_age_id` FOREIGN KEY (`animal_age_id`) REFERENCES `animal_ages` (`id`),
  CONSTRAINT `fk_animals_animal_arrival_option_id` FOREIGN KEY (`animal_arrival_option_id`) REFERENCES `animal_arrival_options` (`id`),
  CONSTRAINT `fk_animals_animal_coat_length_id` FOREIGN KEY (`animal_coat_length_id`) REFERENCES `animal_coat_lengths` (`id`),
  CONSTRAINT `fk_animals_animal_primary_breed_id` FOREIGN KEY (`animal_primary_breed_id`) REFERENCES `animal_breeds` (`id`),
  CONSTRAINT `fk_animals_animal_primary_color_id` FOREIGN KEY (`animal_primary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animals_animal_secondary_breed_id` FOREIGN KEY (`animal_secondary_breed_id`) REFERENCES `animal_breeds` (`id`),
  CONSTRAINT `fk_animals_animal_secondary_color_id` FOREIGN KEY (`animal_secondary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animals_animal_sex_id` FOREIGN KEY (`animal_sex_id`) REFERENCES `animal_sexes` (`id`),
  CONSTRAINT `fk_animals_animal_size_id` FOREIGN KEY (`animal_size_id`) REFERENCES `animal_sizes` (`id`),
  CONSTRAINT `fk_animals_animal_species_id` FOREIGN KEY (`animal_species_id`) REFERENCES `animal_species` (`id`),
  CONSTRAINT `fk_animals_animal_tertiary_color_id` FOREIGN KEY (`animal_tertiary_color_id`) REFERENCES `animal_colors` (`id`),
  CONSTRAINT `fk_animals_animal_type_id` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_types` (`id`),
  CONSTRAINT `fk_animals_organization_contact_id` FOREIGN KEY (`organization_contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_animals_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_animals_organization_location_id` FOREIGN KEY (`organization_location_id`) REFERENCES `organization_locations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_animals_primary_photo_id` FOREIGN KEY (`primary_photo_id`) REFERENCES `animal_photos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_transferred_from_organization_id` FOREIGN KEY (`transferred_from_organization_id`) REFERENCES `organizations` (`id`) ON DELETE SET NULL,
  INDEX `idx_org_adoption_date` (`organization_id` ASC, `adoption_date` ASC),
  INDEX `idx_org_create_at` (`organization_id` ASC, `created_at` ASC),
  INDEX `idx_adopter_adoption_inquiry_id` (`adopter_adoption_inquiry_id`),
  INDEX `idx_organization_animal_species` (`organization_id`, `animal_species_id`),
  INDEX `idx_organization_animal_status` (`organization_id`, `animal_adoption_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 5240832 kB';


# Table: campaign_categories
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_categories`;

CREATE TABLE `campaign_categories` (
  `campaign_category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`campaign_category_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_entries
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_entries`;

CREATE TABLE `campaign_entries` (
  `campaign_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `uid` int(10) unsigned NOT NULL,
  `user_comment` varchar(500) DEFAULT NULL,
  `hide` tinyint(1) unsigned DEFAULT '0',
  `hide_reason` varchar(500) DEFAULT NULL,
  `producer_comment` varchar(500) DEFAULT NULL,
  `score` varchar(25) DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`campaign_entry_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `category_id` (`category_id`),
  KEY `score` (`score`),
  KEY `hide` (`hide`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_entry_fields
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_entry_fields`;

CREATE TABLE `campaign_entry_fields` (
  `campaign_entry_id` int(10) unsigned NOT NULL,
  `campaign_field_id` int(10) unsigned NOT NULL,
  `value` varchar(5000) NOT NULL,
  PRIMARY KEY (`campaign_entry_id`,`campaign_field_id`),
  KEY `value` (`value`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_fields
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_fields`;

CREATE TABLE `campaign_fields` (
  `campaign_field_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `field_type` varchar(20) DEFAULT NULL,
  `valid_values` varchar(255) DEFAULT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  `field_length` int(10) unsigned DEFAULT NULL,
  `required` tinyint(4) DEFAULT '0',
  `data_type` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`campaign_field_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_galleries
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_galleries`;

CREATE TABLE `campaign_galleries` (
  `campaign_id` int(10) unsigned NOT NULL,
  `campaign_entry_id` int(10) unsigned NOT NULL,
  `photo_gallery_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_id`,`campaign_entry_id`,`photo_gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_pets
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_pets`;

CREATE TABLE `campaign_pets` (
  `campaign_entry_id` int(10) unsigned NOT NULL,
  `pet_id` int(10) unsigned NOT NULL,
  `animal_type` varchar(15) DEFAULT NULL,
  `pet_breed_1` varchar(90) DEFAULT NULL,
  `pet_breed_2` varchar(90) DEFAULT NULL,
  `pet_age` varchar(6) DEFAULT NULL,
  `pet_size` varchar(12) DEFAULT NULL,
  `pet_gender` varchar(6) DEFAULT NULL,
  `name` varchar(25) DEFAULT NULL,
  `description` text,
  `no_dogs` tinyint(4) DEFAULT '0',
  `no_cats` tinyint(4) DEFAULT '0',
  `no_kids` tinyint(4) DEFAULT '0',
  `declawed` tinyint(4) DEFAULT '0',
  `altered` tinyint(4) DEFAULT '0',
  `has_shots` tinyint(4) DEFAULT '0',
  `housetrained` tinyint(4) DEFAULT '0',
  `special_needs` tinyint(4) DEFAULT '0',
  `internal` varchar(50) DEFAULT NULL,
  `shelter_pet_id` varchar(25) DEFAULT NULL,
  `images` int(11) DEFAULT NULL,
  `pet_video` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `shelter_id` varchar(12) DEFAULT NULL,
  `shelter_name` varchar(90) DEFAULT NULL,
  `street_address` varchar(40) DEFAULT NULL,
  `extended_address` varchar(40) DEFAULT NULL,
  `locality` varchar(50) DEFAULT NULL,
  `region` char(3) DEFAULT NULL,
  `country` char(2) DEFAULT NULL,
  `postal_code` varchar(8) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `pet_photo_primary` tinyint(1) DEFAULT '1',
  `shelter_region` char(3) DEFAULT NULL,
  `shelter_country` char(2) DEFAULT NULL,
  PRIMARY KEY (`campaign_entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_sponsor_optins
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_sponsor_optins`;

CREATE TABLE `campaign_sponsor_optins` (
  `campaign_id` int(10) unsigned NOT NULL,
  `sponsor_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  UNIQUE KEY `campaign_id` (`campaign_id`,`sponsor_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_sponsors
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_sponsors`;

CREATE TABLE `campaign_sponsors` (
  `campaign_sponsor_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `sponsor_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`campaign_sponsor_id`),
  KEY `campaign_id` (`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaign_votes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaign_votes`;

CREATE TABLE `campaign_votes` (
  `campaign_vote_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `campaign_entry_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `ip_address` char(15) DEFAULT NULL,
  `vote` char(10) NOT NULL,
  `vote_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_comment` varchar(500) DEFAULT NULL,
  `producer_comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`campaign_vote_id`),
  KEY `campaign_entry_id` (`campaign_entry_id`),
  KEY `campaign_id` (`campaign_id`),
  KEY `category_id` (`category_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: campaigns
# ------------------------------------------------------------
DROP TABLE IF EXISTS `campaigns`;

CREATE TABLE `campaigns` (
  `campaign_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `rules` text,
  `help` text,
  `terms` text,
  `start_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `preview_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `postview_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `entry_deadline` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `vote_start_date` datetime DEFAULT NULL,
  `vote_end_date` datetime DEFAULT NULL,
  `who_can_enter` varchar(25) DEFAULT NULL,
  `who_can_vote` varchar(25) DEFAULT NULL,
  `require_login` tinyint(3) unsigned DEFAULT '1',
  `multi_vote` tinyint(3) unsigned DEFAULT '1',
  `entry_per_day` tinyint(3) unsigned DEFAULT '0',
  `entry_per_week` tinyint(3) unsigned DEFAULT '0',
  `entry_per_month` tinyint(3) unsigned DEFAULT '0',
  `entry_per_category` tinyint(3) unsigned DEFAULT '0',
  `entry_per_campaign` tinyint(3) unsigned DEFAULT '0',
  `vote_per_day` tinyint(3) unsigned DEFAULT '1',
  `vote_per_week` tinyint(3) unsigned DEFAULT '0',
  `vote_per_month` tinyint(3) unsigned DEFAULT '0',
  `vote_per_entry` tinyint(3) unsigned DEFAULT '0',
  `vote_per_category` tinyint(3) unsigned DEFAULT '0',
  `vote_per_campaign` tinyint(3) unsigned DEFAULT '0',
  `created_by` int(10) unsigned NOT NULL,
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `meta_description` varchar(500) DEFAULT NULL,
  `meta_keywords` varchar(500) DEFAULT NULL,
  `breadcrumb_html` text,
  `header_html` text,
  `prize_html` text,
  `vote_html` text,
  `thanks_html` text,
  PRIMARY KEY (`campaign_id`),
  UNIQUE KEY `name` (`name`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `preview_date` (`preview_date`),
  KEY `postview_date` (`postview_date`),
  KEY `entry_deadline` (`entry_deadline`),
  KEY `vote_start_date` (`vote_start_date`),
  KEY `vote_end_date` (`vote_end_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: classifieds
# ------------------------------------------------------------
DROP TABLE IF EXISTS `classifieds`;

CREATE TABLE `classifieds` (
  `clsid` int(1) NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL,
  `status` char(1) NOT NULL,
  `type` char(1) DEFAULT NULL,
  `city` char(255) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `country` char(3) DEFAULT NULL,
  `postal_code` varchar(12) DEFAULT NULL,
  `pet_name` varchar(18) DEFAULT NULL,
  `animal` varchar(45) DEFAULT NULL,
  `breed` varchar(90) DEFAULT NULL,
  `size` char(1) DEFAULT NULL,
  `age` char(6) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `description` text NOT NULL,
  `no_dogs` tinyint(1) NOT NULL,
  `no_cats` tinyint(1) NOT NULL,
  `no_kids` tinyint(1) NOT NULL,
  `declawed` tinyint(1) NOT NULL,
  `altered` tinyint(1) NOT NULL,
  `house_broken` tinyint(1) NOT NULL,
  `special_needs` tinyint(1) NOT NULL,
  `expires` date NOT NULL,
  `created` date NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_exists` char(1) DEFAULT NULL,
  `extend_date` date DEFAULT NULL,
  `home_phone` varchar(50) DEFAULT NULL,
  `work_phone` varchar(50) DEFAULT NULL,
  `identifier` int(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `breed_minor` varchar(90) DEFAULT NULL,
  `pf_email` char(1) DEFAULT NULL,
  PRIMARY KEY (`clsid`),
  KEY `state` (`state`,`city`),
  KEY `typestate` (`state`,`type`),
  KEY `classified_expiry_date` (`expires`),
  KEY `uid_idx` (`uid`),
  FULLTEXT KEY `animal` (`animal`,`breed`,`breed_minor`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: contact
# ------------------------------------------------------------
DROP TABLE IF EXISTS `contact`;

CREATE TABLE `contact` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `address_1` varchar(255) DEFAULT NULL,
  `address_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` char(3) DEFAULT NULL,
  `postal` varchar(25) DEFAULT NULL,
  `latitude` decimal(9,6) NOT NULL DEFAULT '0.000000',
  `longitude` decimal(10,6) NOT NULL DEFAULT '0.000000',
  `added` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `primary_phone` varchar(255) DEFAULT NULL NULL,
  `secondary_phone` varchar(255) DEFAULT NULL NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: contact_email
# ------------------------------------------------------------
DROP TABLE IF EXISTS `contact_email`;

CREATE TABLE `contact_email` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id_fk` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id_fk` (`contact_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: contact_note
# ------------------------------------------------------------
DROP TABLE IF EXISTS `contact_note`;

CREATE TABLE `contact_note` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id_fk` int(10) unsigned NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id_fk` (`contact_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: contact_phone
# ------------------------------------------------------------
DROP TABLE IF EXISTS `contact_phone`;

CREATE TABLE `contact_phone` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id_fk` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `phone` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id_fk` (`contact_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: contact_url
# ------------------------------------------------------------
DROP TABLE IF EXISTS `contact_url`;

CREATE TABLE `contact_url` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contact_id_fk` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT '',
  `url` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contact_id_fk` (`contact_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: country
# ------------------------------------------------------------
DROP TABLE IF EXISTS `countries`;

CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` TINYINT(1) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: dci_video
# ------------------------------------------------------------
DROP TABLE IF EXISTS `dci_video`;

CREATE TABLE `dci_video` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dci_id` int(10) NOT NULL,
  `video_name` varchar(255) NOT NULL,
  `video_type` varchar(25) NOT NULL,
  `video_title` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `video_url` varchar(2000) DEFAULT NULL,
  `thumbnail_url` varchar(2000) DEFAULT NULL,
  `more_videos_url` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_name` (`video_name`),
  KEY `video_title` (`video_title`),
  KEY `video_type` (`video_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: did_you_adopt_forms
# ------------------------------------------------------------
DROP TABLE IF EXISTS `did_you_adopt_forms`;

CREATE TABLE `did_you_adopt_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `user_pet_id` int(11) DEFAULT NULL,
  `veterinarian_address_id` int(10) unsigned DEFAULT NULL,
  `occupants0to5` int(11) DEFAULT NULL,
  `occupants6to11` int(11) DEFAULT NULL,
  `occupants12to17` int(11) DEFAULT NULL,
  `occupants18and_older` int(11) DEFAULT NULL,
  `pet_food_retailer_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pet_food_retailer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `previous_pets` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `has_veterinarian` tinyint(1) DEFAULT NULL,
  `veterinarian_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discussion_topics` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:array)',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `offer_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `guest_id` INT DEFAULT NULL,
  `source` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `external_id` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_FA173D82F33D648B` (`user_pet_id`),
  KEY `IDX_FA173D82A76ED395` (`user_id`),
  KEY `IDX_FA173D827BA350EE` (`veterinarian_address_id`),
  KEY `fk_created_by_client_id` (`created_by_client_id`),
  KEY `fk_updated_by_client_id` (`updated_by_client_id`),
  KEY `fk_created_by_user_id` (`created_by_user_id`),
  KEY `fk_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `FK_FA173D82A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_FA173D82F33D648B` FOREIGN KEY (`user_pet_id`) REFERENCES `user_pets` (`id`),
  CONSTRAINT `fk_did_you_adopt_forms_guest_id` FOREIGN KEY (guest_id) REFERENCES guest_profiles (id),
  CONSTRAINT `did_you_adopt_forms_created_by_client_id` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `did_you_adopt_forms_updated_by_client_id` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `did_you_adopt_forms_created_by_user_id` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `did_you_adopt_forms_updated_by_user_id` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: failed_jobs
# ------------------------------------------------------------
DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `job` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `error` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


# Table: organization_events
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_events`;

CREATE TABLE `organization_events` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_event_type_id` INT(10) UNSIGNED NOT NULL,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `organization_location_id` INT(10) UNSIGNED NULL,
  `organization_contact_id` INT(10) UNSIGNED NULL,
  `address_id` INT(10) UNSIGNED NULL,
  `media_id` CHAR(36) NULL,
  `created_by_client_id` VARCHAR(50) NULL,
  `updated_by_client_id` VARCHAR(50) NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `start_date_time` DATETIME NOT NULL,
  `end_date_time` DATETIME NOT NULL,
  `all_day_event` TINYINT(1) UNSIGNED NOT NULL,
  `website_url` VARCHAR(255) DEFAULT NULL,
  `venue_name` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(255) DEFAULT NULL,
  `entered_by` VARCHAR(255) DEFAULT NULL,
  `created_by` VARCHAR(255) DEFAULT NULL,
  `updated_by` VARCHAR(255) DEFAULT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_organization_event_type_id` (`organization_event_type_id`),
  INDEX `idx_organization_id` (`organization_id`),
  INDEX `idx_organization_location_id` (`organization_location_id`),
  INDEX `idx_organization_contact_id` (`organization_contact_id`),
  INDEX `idx_address_id` (`address_id`),
  INDEX `idx_media_id` (`media_id`),
  INDEX `idx_created_by_client_id` (`created_by_client_id`),
  INDEX `idx_updated_by_client_id` (`updated_by_client_id`),
  INDEX `idx_created_by_user_id` (`created_by_user_id`),
  INDEX `idx_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `fk_0053082ef3b089df9905d31893d31325` FOREIGN KEY (`organization_location_id`) REFERENCES `organization_locations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_2bed1bc242edbfa9699ca1cb5ba86c83` FOREIGN KEY (`organization_event_type_id`) REFERENCES `organization_event_types` (`id`),
  CONSTRAINT `fk_654f9c93d4378424fb4d609d0785b00e` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_724998516633079407bc0c7d36b968cc` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_8c16cde301ca05c57976962b02d26700` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_8cbd62cfc3a88b34170c8ad867e006ba` FOREIGN KEY (`organization_contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_aeed204e1007b8de4df90ef93b397254` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_f328adb4706a9a5cacbdbd42e1e2d688` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `fk_f83ffa4a10262feddb464c88adb4733d` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_feb5cad9e11418ae4c2d9af17bf6ff2a` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: falp_shelters
# ------------------------------------------------------------
DROP TABLE IF EXISTS `falp_shelters`;

CREATE TABLE `falp_shelters` (
  `shelter_id` varchar(12) NOT NULL,
  `shelter_name` varchar(90) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `region` char(3) NOT NULL,
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: falp_shelters_2011
# ------------------------------------------------------------
DROP TABLE IF EXISTS `falp_shelters_2011`;

CREATE TABLE `falp_shelters_2011` (
  `shelter_id` varchar(12) NOT NULL,
  `shelter_name` varchar(90) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `region` char(3) NOT NULL,
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: falp_shelters_2012
# ------------------------------------------------------------
DROP TABLE IF EXISTS `falp_shelters_2012`;

CREATE TABLE `falp_shelters_2012` (
  `shelter_id` varchar(12) NOT NULL,
  `shelter_name` varchar(90) NOT NULL,
  `locality` varchar(255) NOT NULL,
  `region` char(3) NOT NULL,
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: guest_profiles
# ------------------------------------------------------------
DROP TABLE IF EXISTS `guest_profiles`;

CREATE TABLE `guest_profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_id` int(10) unsigned DEFAULT NULL,
  `first_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_F41A4D4FF5B7AF75` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: happytails
# ------------------------------------------------------------
DROP TABLE IF EXISTS `happytails`;

CREATE TABLE `happytails` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sheltername` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shelterid` varchar(6) CHARACTER SET latin1 DEFAULT NULL,
  `sheltercity` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `shelterstate` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `petname` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `animal` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `textorig` text COLLATE utf8_unicode_ci,
  `textedit` text COLLATE utf8_unicode_ci,
  `county` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localpapers` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `original` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `photo` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thumbnail` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adddate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `moddate` datetime DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `feature_image` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `findonpf` tinyint(1) NOT NULL DEFAULT '0',
  `shareinfo` tinyint(1) NOT NULL DEFAULT '0',
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  `rss` tinyint(1) NOT NULL DEFAULT '0',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  FULLTEXT KEY `idx_happytails_fulltext` (`sheltername`,`firstname`,`petname`,`animal`,`textedit`,`county`,`city`,`state`),
  FULLTEXT KEY `idx_happytails_shelterid_fulltext` (`shelterid`),
  FULLTEXT KEY `idx_happytails_sheltername_fulltext` (`sheltername`),
  FULLTEXT KEY `idx_happytails_firstname_fulltext` (`firstname`),
  FULLTEXT KEY `idx_happytails_petname_fulltext` (`petname`),
  FULLTEXT KEY `idx_happytails_animal_fulltext` (`animal`),
  FULLTEXT KEY `idx_happytails_textedit_fulltext` (`textedit`),
  FULLTEXT KEY `idx_happytails_county_fulltext` (`county`),
  FULLTEXT KEY `idx_happytails_city_fulltext` (`city`),
  FULLTEXT KEY `idx_happytails_state_fulltext` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: help
# ------------------------------------------------------------
DROP TABLE IF EXISTS `help`;

CREATE TABLE `help` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `body` varchar(1500) DEFAULT NULL,
  `module_name` varchar(255) DEFAULT NULL,
  `section_name` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: homepage_config
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_homepage_config`;

CREATE TABLE `organization_homepage_config` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `publish_adoptable` TINYINT(1) NOT NULL DEFAULT 0,
  `publish_events` TINYINT(1) NOT NULL DEFAULT 0,
  `simple_setup` TINYINT(1) NOT NULL DEFAULT 1,
  `publish_happytails` TINYINT(1) NOT NULL DEFAULT 0,
  `alias` varchar(255) DEFAULT NULL,
  `created_by` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_by` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_2980a2b616ee8fe321b758f4c41bc814` (`organization_id`),
  UNIQUE KEY `index_724874d1be77f450a09b305fc1534afb` (`alias`) USING BTREE,
  KEY `FKAF1E88B393100206` (`organization_id`),
  KEY `fk_4802fd9e369749f2a11131c2c5401211` (`created_by_client_id`),
  KEY `fk_b83586d1807f2096a3a73259f7b71853` (`created_by_user_id`),
  KEY `fk_7f9637a4fbb623fcde32fc36001f9d72` (`updated_by_client_id`),
  KEY `fk_8853634c48b90ef37d79d0ca4c46b5d1` (`updated_by_user_id`),
  CONSTRAINT `fk_2980a2b616ee8fe321b758f4c41bc814` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_4802fd9e369749f2a11131c2c5401211` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_7f9637a4fbb623fcde32fc36001f9d72` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_8853634c48b90ef37d79d0ca4c46b5d1` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_b83586d1807f2096a3a73259f7b71853` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: organization_homepage_large_info
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_homepage_large_info`;

CREATE TABLE `organization_homepage_large_info` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `content` MEDIUMTEXT,
  `organization_homepage_large_info_content_type_id` INT(11) UNSIGNED NOT NULL,
  `organization_homepage_config_id` INT(11) UNSIGNED NULL DEFAULT NULL,
  `created_by` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_by` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_785208481c356e8c456c25417e6c8d78` (`organization_homepage_large_info_content_type_id`),
  KEY `fk_db4616ecd66bc8d54103032e774eb9e6` (`organization_homepage_config_id`),
  KEY `fk_4db1d1e6798c5b5f6b7b2faf17923dd4` (`organization_id`),
  CONSTRAINT `fk_4db1d1e6798c5b5f6b7b2faf17923dd4` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_785208481c356e8c456c25417e6c8d78` FOREIGN KEY (`organization_homepage_large_info_content_type_id`) REFERENCES `organization_homepage_large_info_content_type` (`id`),
  CONSTRAINT `fk_db4616ecd66bc8d54103032e774eb9e6` FOREIGN KEY (`organization_homepage_config_id`) REFERENCES `organization_homepage_config` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: homepage_large_info_content_type
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_homepage_large_info_content_type`;

CREATE TABLE `organization_homepage_large_info_content_type` (
  `id` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type` (`name`),
  INDEX `index_b068931cc450442b63f5b3d276ea4297` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: ip_blacklist
# ------------------------------------------------------------
DROP TABLE IF EXISTS `ip_blacklist`;

CREATE TABLE `ip_blacklist` (
  `address` char(15) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: list_video_map
# ------------------------------------------------------------
DROP TABLE IF EXISTS `list_video_map`;

CREATE TABLE `list_video_map` (
  `playlist_id_fk` bigint(20) NOT NULL,
  `video_item_id_fk` bigint(20) NOT NULL,
  `id` bigint(20) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`playlist_id_fk`,`video_item_id_fk`),
  KEY `playlist_id_fk` (`playlist_id_fk`),
  KEY `video_item_id_fk` (`video_item_id_fk`),
  KEY `FK763137257A304` (`playlist_id_fk`),
  KEY `FK763137ABF029F9` (`video_item_id_fk`),
  CONSTRAINT `FK763137257A304` FOREIGN KEY (`playlist_id_fk`) REFERENCES `playlist` (`id`),
  CONSTRAINT `FK763137ABF029F9` FOREIGN KEY (`video_item_id_fk`) REFERENCES `video_item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: log_ip_access
# ------------------------------------------------------------
DROP TABLE IF EXISTS `log_ip_access`;

CREATE TABLE `log_ip_access` (
  `username` varchar(30) NOT NULL,
  `address` char(15) NOT NULL,
  `log_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: mail_log
# ------------------------------------------------------------
DROP TABLE IF EXISTS `mail_log`;

CREATE TABLE `mail_log` (
  `sub_id` int(10) unsigned NOT NULL,
  `email` varchar(255) NOT NULL,
  `action` varchar(10) NOT NULL,
  `source` varchar(25) DEFAULT NULL,
  `response_code` varchar(25) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `postal_code` varchar(25) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `process_date` datetime DEFAULT NULL,
  KEY `sub_id` (`sub_id`),
  KEY `email` (`email`),
  KEY `last_name` (`last_name`),
  KEY `source` (`source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: mail_templates
# ------------------------------------------------------------
DROP TABLE IF EXISTS `mail_templates`;

CREATE TABLE `mail_templates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `system` varchar(255) NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `from_address` varchar(255) NOT NULL,
  `reply_to` varchar(255) DEFAULT NULL,
  `bcc` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `header` text,
  `body` text,
  `footer` text,
  `description` text,
  `multi_part` tinyint(1) unsigned DEFAULT '0',
  `template_type` enum('html','text') DEFAULT 'html',
  PRIMARY KEY (`id`),
  KEY `system` (`system`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: media
# ------------------------------------------------------------
DROP TABLE IF EXISTS `media`;

CREATE TABLE `media` (
  `id` CHAR(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `status` ENUM('unused', 'used', 'deleted') NOT NULL DEFAULT 'unused',
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `checksum` VARCHAR(32) NULL DEFAULT NULL,
  `metadata` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_6A2CA10C19EB6921` (`client_id`),
  KEY `IDX_6A2CA10CA76ED395` (`user_id`),
  KEY `status` (`status`),
  UNIQUE INDEX `idx_path` (`path`),
  CONSTRAINT `FK_6A2CA10CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_6A2CA10C19EB6921` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: migration_versions
# ------------------------------------------------------------
DROP TABLE IF EXISTS `migration_versions`;

CREATE TABLE `migration_versions` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_access_requests
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_access_requests`;

CREATE TABLE `oauth2_access_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oauth_client` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `primary_contact_id` int(10) unsigned DEFAULT NULL,
  `technical_contact_id` int(10) unsigned DEFAULT NULL,
  `alternative_contact_id` int(10) unsigned DEFAULT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `homepage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `organization_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `decided_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `note` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_25DB3225AD73274D` (`oauth_client`),
  KEY `IDX_25DB3225D905C92C` (`primary_contact_id`),
  KEY `IDX_25DB32258F27F416` (`technical_contact_id`),
  KEY `IDX_25DB3225FFA9F95B` (`alternative_contact_id`),
  KEY `IDX_25DB322543EE6C4C` (`created_by_client_id`),
  KEY `IDX_25DB3225BCEDEAAC` (`updated_by_client_id`),
  KEY `IDX_25DB32257D182D95` (`created_by_user_id`),
  KEY `IDX_25DB32252793CC5E` (`updated_by_user_id`),
  CONSTRAINT `FK_25DB32252793CC5E` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_25DB322543EE6C4C` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_25DB32257D182D95` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_25DB32258F27F416` FOREIGN KEY (`technical_contact_id`) REFERENCES `oauth2_client_contacts` (`id`),
  CONSTRAINT `FK_25DB3225AD73274D` FOREIGN KEY (`oauth_client`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_25DB3225BCEDEAAC` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_25DB3225D905C92C` FOREIGN KEY (`primary_contact_id`) REFERENCES `oauth2_client_contacts` (`id`),
  CONSTRAINT `FK_25DB3225FFA9F95B` FOREIGN KEY (`alternative_contact_id`) REFERENCES `oauth2_client_contacts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_access_tokens
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_access_tokens`;

CREATE TABLE `oauth2_access_tokens` (
  `identifier` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` datetime NOT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `client_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `scopes` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`identifier`),
  KEY `FK_5eb74279270a8b58bb2df408412600ff` (`client_id`),
  KEY `FK_4a9a9fa06575d8dfe72ffba657ac5768` (`user_id`),
  CONSTRAINT `FK_4a9a9fa06575d8dfe72ffba657ac5768` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`) ON DELETE CASCADE,
  CONSTRAINT `FK_5eb74279270a8b58bb2df408412600ff` FOREIGN KEY (`client_id`) REFERENCES `oauth2_clients` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_client_contacts
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_client_contacts`;

CREATE TABLE `oauth2_client_contacts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_clients
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_clients`;

CREATE TABLE `oauth2_clients` (
  `identifier` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `user_id` int(10) unsigned DEFAULT NULL,
  `secret` varchar(40) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `homepage_uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `redirect_uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `grant_types` varchar(66) COLLATE utf8_unicode_ci DEFAULT '',
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `primary_contact_id` int(10) unsigned DEFAULT NULL,
  `technical_contact_id` int(10) unsigned DEFAULT NULL,
  `alternative_contact_id` int(10) unsigned DEFAULT NULL,
  `usage_plan` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal` tinyint(1) NOT NULL DEFAULT '0',
  `gateway_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `referrer_id` CHAR(36) NOT NULL COMMENT '(DC2Type:guid)',
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `UNIQ_F9D02AE6798C22DB` (`referrer_id`),
  KEY `IDX_F9D02AE6A76ED395` (`user_id`),
  KEY `IDX_F9D02AE6D905C92C` (`primary_contact_id`),
  KEY `IDX_F9D02AE68F27F416` (`technical_contact_id`),
  KEY `IDX_F9D02AE6FFA9F95B` (`alternative_contact_id`),
  CONSTRAINT `FK_F9D02AE68F27F416` FOREIGN KEY (`technical_contact_id`) REFERENCES `oauth2_client_contacts` (`id`),
  CONSTRAINT `FK_F9D02AE6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_F9D02AE6D905C92C` FOREIGN KEY (`primary_contact_id`) REFERENCES `oauth2_client_contacts` (`id`),
  CONSTRAINT `FK_F9D02AE6FFA9F95B` FOREIGN KEY (`alternative_contact_id`) REFERENCES `oauth2_client_contacts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_permissions
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_permissions`;

CREATE TABLE `oauth2_permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `oauth_client` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attribute` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7BD79F7DAD73274D` (`oauth_client`),
  CONSTRAINT `FK_7BD79F7DAD73274D` FOREIGN KEY (`oauth_client`) REFERENCES `oauth2_clients` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_refresh_tokens
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_refresh_tokens`;

CREATE TABLE `oauth2_refresh_tokens` (
  `identifier` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `access_token` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `expires` datetime NOT NULL,
  `revoked` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`identifier`),
  KEY `IDX_D394478CB6A2DD68` (`access_token`),
  CONSTRAINT `FK_D394478CB6A2DD68` FOREIGN KEY (`access_token`) REFERENCES `oauth2_access_tokens` (`identifier`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: oauth2_scopes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `oauth2_scopes`;

CREATE TABLE `oauth2_scopes` (
  `identifier` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `parent` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `grant_types` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `roles` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `plans` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internal` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`identifier`),
  KEY `IDX_A50F1EAC3D8E604F` (`parent`),
  CONSTRAINT `FK_A50F1EAC3D8E604F` FOREIGN KEY (`parent`) REFERENCES `oauth2_scopes` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: organization_contacts
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_contacts`;

CREATE TABLE `organization_contacts` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT(10) UNSIGNED NULL,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `role` ENUM('noaccess','readonly','edit','admin')  NOT NULL  DEFAULT 'noaccess',
  `email` VARCHAR(255) DEFAULT NULL,
  `first_name` VARCHAR(255) DEFAULT NULL,
  `last_name` VARCHAR(255) DEFAULT NULL,
  `notes` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(255) DEFAULT NULL,
  `user_id` INT(10) unsigned DEFAULT NULL,
  `created_by` VARCHAR(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_by` VARCHAR(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_5` (`email`,`organization_id`),
  KEY `email_idx` (`email`),
  KEY `fk_user_id` (`user_id`),
  KEY `fk_address_id` (`address_id`),
  KEY `fk_organization_id` (`organization_id` ASC, `last_name` ASC),
  KEY `fk_cd1db9016f66c207cafe0d21b2ab6d50` (`created_by_client_id`),
  KEY `fk_6651600106824ae3f5a45bc79ed58530` (`created_by_user_id`),
  KEY `fk_e2a6efc49ed6eb39c006a59138c4cdd2` (`updated_by_client_id`),
  KEY `fk_1437b4190004cad795023276407bfac4` (`updated_by_user_id`),
  CONSTRAINT `fk_1437b4190004cad795023276407bfac4` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_6651600106824ae3f5a45bc79ed58530` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_cd1db9016f66c207cafe0d21b2ab6d50` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_e2a6efc49ed6eb39c006a59138c4cdd2` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_organization_contacts_address_id` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_organization_contacts_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_organization_contacts_user_id` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

# Table: organization_application_comments
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_application_comments`;

CREATE TABLE `organization_application_comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_application_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `comment` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5C5B7929CE11E97E` (`organization_application_id`),
  KEY `IDX_5C5B7929A76ED395` (`user_id`),
  KEY `IDX_5C5B792943EE6C4C` (`created_by_client_id`),
  KEY `IDX_5C5B7929BCEDEAAC` (`updated_by_client_id`),
  KEY `IDX_5C5B79297D182D95` (`created_by_user_id`),
  KEY `IDX_5C5B79292793CC5E` (`updated_by_user_id`),
  CONSTRAINT `FK_5C5B79292793CC5E` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_5C5B792943EE6C4C` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_5C5B79297D182D95` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_5C5B7929A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_5C5B7929BCEDEAAC` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_5C5B7929CE11E97E` FOREIGN KEY (`organization_application_id`) REFERENCES `organization_applications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: organization_applications
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_applications`;

CREATE TABLE `organization_applications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `organization_type_id` int(10) unsigned DEFAULT NULL,
  `mailing_address_id` int(10) unsigned DEFAULT NULL,
  `primary_location_address_id` int(10) unsigned DEFAULT NULL,
  `primary_contact_address_id` int(10) unsigned DEFAULT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `status` enum('Draft','New','Incomplete','Pending Vet','Failed','Approved') COLLATE utf8_unicode_ci NOT NULL,
  `status_reason` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `future_invite_eligible` tinyint(1) DEFAULT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `organization_type_other` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `director` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ein` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mission_statement` longtext COLLATE utf8_unicode_ci,
  `adoption_policy` tinyint(1) DEFAULT NULL,
  `adoptions_processed_per_month` enum('1-25','26-50','51-100','101 +') COLLATE utf8_unicode_ci DEFAULT NULL,
  `min_adoption_fee` decimal(10,2) DEFAULT NULL,
  `max_adoption_fee` decimal(10,2) DEFAULT NULL,
  `animal_types` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:animal_type_array)',
  `spay_neuter_responsible` enum('Yes','Sometimes','No','N/A') COLLATE utf8_unicode_ci DEFAULT NULL,
  `spay_neuter_responsible_reason` longtext COLLATE utf8_unicode_ci,
  `primary_location_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_location_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_contact_first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_contact_last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_contact_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `primary_contact_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `social_media_facebook` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `social_media_instagram` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `social_media_other` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `services` longtext COLLATE utf8_unicode_ci COMMENT '(DC2Type:organization_service_array)',
  `first_viewed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `first_viewed_by_user_id` int(10) unsigned DEFAULT NULL,
  `first_updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `first_updated_at` datetime DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_302E92E0A76ED395` (`user_id`),
  KEY `IDX_302E92E032C8A3DE` (`organization_id`),
  KEY `IDX_302E92E07B00651C` (`status`),
  KEY `IDX_302E92E05E237E06` (`name`),
  KEY `IDX_302E92E089E04D0` (`organization_type_id`),
  KEY `IDX_302E92E013E6F604` (`mailing_address_id`),
  KEY `IDX_302E92E02471DC0C` (`primary_location_email`),
  KEY `IDX_302E92E087AC37A5` (`primary_location_phone`),
  KEY `IDX_302E92E03A0DF70A` (`primary_location_address_id`),
  KEY `IDX_302E92E02070A8E5` (`primary_contact_first_name`),
  KEY `IDX_302E92E0BA4A8DC3` (`primary_contact_last_name`),
  KEY `IDX_302E92E0A59200C6` (`primary_contact_email`),
  KEY `IDX_302E92E064FEB6F` (`primary_contact_phone`),
  KEY `IDX_302E92E07C16C6A2` (`primary_contact_address_id`),
  KEY `IDX_302E92E043EE6C4C` (`created_by_client_id`),
  KEY `IDX_302E92E0BCEDEAAC` (`updated_by_client_id`),
  KEY `IDX_302E92E07D182D95` (`created_by_user_id`),
  KEY `IDX_302E92E02793CC5E` (`updated_by_user_id`),
  KEY `IDX_302E92E01E13BA89` (`first_viewed_by_user_id`),
  KEY `IDX_302E92E01DC41898` (`first_updated_by_user_id`),
  CONSTRAINT `FK_302E92E013E6F604` FOREIGN KEY (`mailing_address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `FK_302E92E01DC41898` FOREIGN KEY (`first_updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_302E92E01E13BA89` FOREIGN KEY (`first_viewed_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_302E92E02793CC5E` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_302E92E032C8A3DE` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FK_302E92E03A0DF70A` FOREIGN KEY (`primary_location_address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `FK_302E92E043EE6C4C` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `FK_302E92E07C16C6A2` FOREIGN KEY (`primary_contact_address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `FK_302E92E07D182D95` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_302E92E089E04D0` FOREIGN KEY (`organization_type_id`) REFERENCES `organization_types` (`id`),
  CONSTRAINT `FK_302E92E0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `FK_302E92E0BCEDEAAC` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: organization_contact_notifications
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_contact_notifications`;

CREATE TABLE `organization_contact_notifications` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `created_by_client_id` varchar(50) DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by_client_id` varchar(50) DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `metadata` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_contact_id` (`contact_id`),
  KEY `fk_1d1b6b18891e73c4f804301cb5321342` (`created_by_client_id`),
  KEY `fk_bde10942e55988b26bddc2ed63abaa91` (`updated_by_client_id`),
  KEY `fk_0c55c78722f9bcd56cfa66f3ca6bacfa` (`created_by_user_id`),
  KEY `fk_6acfb7fbbcd61109f32418bebae4c8e3` (`updated_by_user_id`),
  CONSTRAINT `fk_0c55c78722f9bcd56cfa66f3ca6bacfa` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_1d1b6b18891e73c4f804301cb5321342` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_6acfb7fbbcd61109f32418bebae4c8e3` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_867b36a0b02ac5b87f08ae6cff9e8228` FOREIGN KEY (`contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bde10942e55988b26bddc2ed63abaa91` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: organization_photos
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_photos`;

CREATE TABLE `organization_photos` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` INT(11) UNSIGNED NOT NULL,
  `media_id` CHAR(36) NOT NULL DEFAULT '',
  `created_by_client_id` VARCHAR(50) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED DEFAULT NULL,
  `index` INT(11) UNSIGNED NOT NULL DEFAULT '1',
  `caption` VARCHAR(255) DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_organization_id` (`organization_id`),
  KEY `idx_media_id` (`media_id`),
  KEY `idx_created_by_client_id` (`created_by_client_id`),
  KEY `idx_updated_by_client_id` (`updated_by_client_id`),
  KEY `idx_created_by_user_id` (`created_by_user_id`),
  KEY `idx_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `fk_a1d6d526ed7ebef9099742ac44b91ff7` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_26be993c05c046f46415838af8f36701` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `fk_a195d88c2f5384f8b390899bc986113f` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_be41d455ee84d0a6b10605b86d507c67` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_27dee906d206936623c7e30145104938` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_f22a5f3d4334c276490a6d99866f2d28` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: organization_event_types
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_event_types`;

CREATE TABLE `organization_event_types` (
  `id` INT(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: organization_homepage_subdomain_blacklist
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_homepage_subdomain_blacklist`;

CREATE TABLE `organization_homepage_subdomain_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(64) NOT NULL,
  `type` enum('regex','string') NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: organization_locations
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_locations`;

CREATE TABLE `organization_locations` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `updated_at` DATETIME DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `phone` VARCHAR(255) DEFAULT NULL,
  `location_type_id` int(10) unsigned NOT NULL,
  `organization_id` int(11) unsigned DEFAULT NULL,
  `public_address_id` int(10) unsigned DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `contact_name` VARCHAR(255) DEFAULT NULL,
  `is_public_location` TINYINT(1) NULL DEFAULT 1,
  `is_appointment_only` TINYINT(1) NULL DEFAULT 0,
  `hours_monday` VARCHAR(255) NULL,
  `hours_tuesday` VARCHAR(255) NULL,
  `hours_wednesday` VARCHAR(255) NULL,
  `hours_thursday` VARCHAR(255) NULL,
  `hours_friday` VARCHAR(255) NULL,
  `hours_saturday` VARCHAR(255) NULL,
  `hours_sunday` VARCHAR(255) NULL,
  `created_by` VARCHAR(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME DEFAULT NULL,
  `updated_by` VARCHAR(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `is_map_hidden` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_5` (`organization_id`,`name`),
  KEY `FK714F9FB5EBAF6C88` (`location_type_id`),
  KEY `FK714F9FB579324957` (`public_address_id`),
  KEY `FK714F9FB593100206` (`organization_id`),
  CONSTRAINT `FK_48615F1FD6A85D80DB1855799DD53E15` FOREIGN KEY (`location_type_id`) REFERENCES `organization_location_types` (`id`),
  CONSTRAINT `FK_CBD6D07084CB015D139AF91C309B7A9D` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `FK_CDB2333C5A3E5A897003CFBA60E21B1E` FOREIGN KEY (`public_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: organization_location_types
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_location_types`;

CREATE TABLE `organization_location_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `rank` tinyint(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;


# Table: organization_logos
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_logos`;

CREATE TABLE `organization_logos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(11) unsigned NOT NULL,
  `media_id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `created_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `updated_by_client_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `migrated` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_organization_id` (`organization_id`),
  UNIQUE KEY `idx_media_id` (`media_id`),
  KEY `idx_created_by_client_id` (`created_by_client_id`),
  KEY `idx_updated_by_client_id` (`updated_by_client_id`),
  KEY `idx_created_by_user_id` (`created_by_user_id`),
  KEY `idx_updated_by_user_id` (`updated_by_user_id`),
  CONSTRAINT `fk_b8b831dea32367be3ec52daaaf5a15d1` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`),
  CONSTRAINT `fk_ca61f76682e9a0511ea267c68e5914c2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`),
  CONSTRAINT `fk_eeeea03599215b69b445504467beb162` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_544729458ae8f756bda40ac4ab67e566` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_7b775412694a29162d10cc83cb418a94` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_4e720c36bd0354fc6fef1f5c36ee6d81` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: organization_services
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_services`;

CREATE TABLE `organization_services` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rank` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_9C2A23CB5E237E06` (`name`),
  KEY `IDX_9C2A23CB5E237E06` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

# Table: organization_types
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_types`;

CREATE TABLE `organization_types` (
  `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL UNIQUE,
  `rank` tinyint(1) unsigned NOT NULL
);


# Table: organization_staff_comments
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_staff_comments`;

CREATE TABLE `organization_staff_comments` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) UNSIGNED NOT NULL,
  `comments` text,
  `created_by` varchar(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `created_by_user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `updated_by_user_id` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKFE2F887393100206` (`organization_id`),
  CONSTRAINT `FKFE2F887393100206` FOREIGN KEY (`organization_id`) REFERENCES `organizations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_fe96052e0211a29311068891c6347f7b` FOREIGN KEY (`created_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_7f5329f4e9902ee2065cee69e890fa5a` FOREIGN KEY (`updated_by_client_id`) REFERENCES `oauth2_clients` (`identifier`),
  CONSTRAINT `fk_4742ae4d5c1f2074c972fb9572f19be5` FOREIGN KEY (`created_by_user_id`) REFERENCES `sys_users` (`uid`),
  CONSTRAINT `fk_39437ffa11443caa872abdaecb4909b5` FOREIGN KEY (`updated_by_user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: organization_updates
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organization_updates`;

CREATE TABLE `organization_updates` (
  `sequence` int(11) NOT NULL AUTO_INCREMENT,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: organizations
# ------------------------------------------------------------
DROP TABLE IF EXISTS `organizations`;

CREATE TABLE `organizations` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_by` VARCHAR(255) DEFAULT NULL,
  `created_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `created_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_by_client_id` VARCHAR(50) NULL DEFAULT NULL,
  `updated_by_user_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `active` TINYINT(1) NOT NULL,
  `deactivation_reason` VARCHAR(255) NULL DEFAULT NULL,
  `enabled` TINYINT(1) NOT NULL,
  `lock_reason` VARCHAR(255) NULL DEFAULT NULL,
  `last_active` DATETIME DEFAULT NULL,
  `name` VARCHAR(255) NOT NULL,
  `display_id` VARCHAR(255),
  `primary_contact_id` INT(10) UNSIGNED NULL,
  `primary_location_id` INT(10) UNSIGNED NULL,
  `primary_photo_id` INT(11) UNSIGNED NULL,
  `mailing_address_id` INT(10) UNSIGNED NULL,
  `director` varchar(255) DEFAULT NULL,
  `export_api` TINYINT(1) NOT NULL,
  `export_partners` TINYINT(1) NOT NULL,
  `marked_for_deletion` TINYINT(1) NOT NULL,
  `last_indexable_update` DATETIME DEFAULT NULL,
  `organization_type_id` INT(10)  UNSIGNED  NULL  DEFAULT NULL,
  `organization_type_other` VARCHAR(255)  NULL  DEFAULT NULL,
  `website` VARCHAR(255)  NULL  DEFAULT NULL,
  `mission_statement` TEXT  NULL,
  `adoption_policies` TEXT  NULL,
  `social_twitter_url` varchar(255) DEFAULT NULL,
  `social_facebook_url` varchar(255) DEFAULT NULL,
  `social_instagram_url` varchar(255) DEFAULT NULL,
  `social_pinterest_url` varchar(255) DEFAULT NULL,
  `social_youtube_url` varchar(255) DEFAULT NULL,
  `adoption_application_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Index_7` (`display_id`) USING BTREE,
  KEY `FK4644ED3338B68658` (`primary_contact_id`),
  KEY `FK4644ED338DDC0467` (`primary_location_id`),
  KEY `primary_contact_id_fk` (`primary_contact_id`) USING BTREE,
  KEY `FK4644ED33A0B0A6FB` (`mailing_address_id`),
  KEY `active_idx` (`active`,`enabled`,`marked_for_deletion`),
  KEY `updated` (`updated_at`),
  KEY `idx_primary_photo_id` (`primary_photo_id`),
  CONSTRAINT `fk_e2f57693595dc68768e19b56b9e776e0` FOREIGN KEY (`primary_photo_id`) REFERENCES `organization_photos` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_organizations_addresses_mailing_address_id` FOREIGN KEY (`mailing_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_organizations_organization_contacts_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `organization_contacts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_organizations_organization_locations_primary_location_id` FOREIGN KEY (`primary_location_id`) REFERENCES `organization_locations` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 5442560 kB';


# Table: pet_video_views
# ------------------------------------------------------------
DROP TABLE IF EXISTS `pet_video_views`;

CREATE TABLE `pet_video_views` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `video_id` VARCHAR(255) NOT NULL,
  `pet_id` INT UNSIGNED NOT NULL,
  `shelter_id` VARCHAR(255) NOT NULL,
  `user_id` INT UNSIGNED NULL,
  `viewed_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
);


# Table: photo_galleries
# ------------------------------------------------------------
DROP TABLE IF EXISTS `photo_galleries`;

CREATE TABLE `photo_galleries` (
  `photo_gallery_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `uid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`photo_gallery_id`),
  KEY `name` (`name`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: photo_gallery_entries
# ------------------------------------------------------------
DROP TABLE IF EXISTS `photo_gallery_entries`;

CREATE TABLE `photo_gallery_entries` (
  `photo_gallery_entry_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `photo_gallery_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned DEFAULT NULL,
  `pet_id` int(10) unsigned DEFAULT NULL,
  `user_pet_id` int(10) unsigned DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `producer_comment` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`photo_gallery_entry_id`),
  KEY `photo_gallery_id` (`photo_gallery_id`),
  KEY `pet_id` (`pet_id`),
  KEY `user_pet_id` (`user_pet_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: photo_gallery_tags
# ------------------------------------------------------------
DROP TABLE IF EXISTS `photo_gallery_tags`;

CREATE TABLE `photo_gallery_tags` (
  `photo_gallery_entry_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`photo_gallery_entry_id`,`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: photo_queue
# ------------------------------------------------------------
DROP TABLE IF EXISTS `photo_queue`;

CREATE TABLE `photo_queue` (
  `id` varchar(21) NOT NULL DEFAULT '',
  `filename` varchar(255) DEFAULT NULL,
  `action` enum('upload','delete','invalidate') DEFAULT NULL,
  `attempt` int(2) DEFAULT NULL,
  `completed` tinyint(1) DEFAULT '0',
  `active` tinyint(1) DEFAULT '1',
  `mtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ctime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `source` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `photo_queue_action` (`action`,`active`,`completed`),
  KEY `photo_queue_timestamp` (`ctime`),
  KEY `already_in_queue` (`filename`,`action`,`active`,`completed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: playlist
# ------------------------------------------------------------
DROP TABLE IF EXISTS `playlist`;

CREATE TABLE `playlist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `external_id` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire`;

CREATE TABLE `questionaire` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `questionaire_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire_html
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire_html`;

CREATE TABLE `questionaire_html` (
  `question_id` bigint(20) NOT NULL,
  `type` enum('text','textarea','select','checkbox','radio') DEFAULT NULL,
  `multiple` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire_html_attributes
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire_html_attributes`;

CREATE TABLE `questionaire_html_attributes` (
  `id` bigint(20) NOT NULL,
  `question_id` bigint(20) NOT NULL,
  `key` varchar(25) DEFAULT NULL,
  `value` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire_pages
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire_pages`;

CREATE TABLE `questionaire_pages` (
  `page_number` int(11) NOT NULL,
  `questionaire_id` bigint(20) NOT NULL,
  `page_title` varchar(100) DEFAULT NULL,
  `page_description` text,
  PRIMARY KEY (`page_number`,`questionaire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire_questions
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire_questions`;

CREATE TABLE `questionaire_questions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `question` text,
  `required` tinyint(1) NOT NULL DEFAULT '1',
  `question_type` enum('yes_no','free_form','multiple_choice','db_enum') DEFAULT NULL,
  `parent_question_id` bigint(20) DEFAULT NULL,
  `answers` text,
  `active` tinyint(1) DEFAULT '1',
  `page_number` int(11) DEFAULT NULL,
  `question_order` int(2) DEFAULT NULL,
  `questionaire_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: questionaire_validation
# ------------------------------------------------------------
DROP TABLE IF EXISTS `questionaire_validation`;

CREATE TABLE `questionaire_validation` (
  `question_id` bigint(20) NOT NULL,
  `pattern` varchar(255) DEFAULT NULL,
  `message` varchar(50) DEFAULT NULL,
  `required` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: role
# ------------------------------------------------------------
DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `super_role_id_fk` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3580766F513B90` (`super_role_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: service
# ------------------------------------------------------------
DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_by` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `description` text,
  `freeSubsidized` bit(1) NOT NULL,
  `usesMasterSchedule` bit(1) NOT NULL,
  `location_id_fk` bigint(20) DEFAULT NULL,
  `type_id_fk` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7643C6B52706A88A` (`location_id_fk`),
  KEY `FK7643C6B5B90FA348` (`type_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: service_type
# ------------------------------------------------------------
DROP TABLE IF EXISTS `service_type`;

CREATE TABLE `service_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sponsors
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sponsors`;

CREATE TABLE `sponsors` (
  `sponsor_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_name` varchar(255) DEFAULT NULL,
  `street_address` varchar(255) DEFAULT NULL,
  `extended_address` varchar(255) DEFAULT NULL,
  `locality` varchar(255) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `postal_code` varchar(25) DEFAULT NULL,
  `country_code` char(3) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `uri` varchar(2000) DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sponsor_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: state_province
# ------------------------------------------------------------
DROP TABLE IF EXISTS `states`;

CREATE TABLE `states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `active` TINYINT(1) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  `next_display_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`,`country_id`),
  UNIQUE KEY `name` (`name`,`country_id`),
  KEY `FK17742B1E97F2392B` (`country_id`),
  CONSTRAINT `fk_states_countries_country_id` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sys_api_authorized_hosts
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_api_authorized_hosts`;

CREATE TABLE `sys_api_authorized_hosts` (
  `api_key` varchar(40) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sys_api_keys
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_api_keys`;

CREATE TABLE `sys_api_keys` (
  `api_key` varchar(40) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'A',
  `api_secret` varchar(40) NOT NULL,
  `uid` int(11) NOT NULL,
  `reason_id` int(11) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`api_key`),
  UNIQUE KEY `sys_api_keys_unique_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sys_api_reasons
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_api_reasons`;

CREATE TABLE `sys_api_reasons` (
  `reason_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`reason_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sys_api_role_profiles
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_api_role_profiles`;

CREATE TABLE `sys_api_role_profiles` (
  `role_id` int(11) NOT NULL,
  `perm_read_all` tinyint(4) DEFAULT NULL,
  `perm_write_all` tinyint(4) DEFAULT NULL,
  `perm_all_status` tinyint(4) DEFAULT NULL,
  `perm_write_self` tinyint(4) DEFAULT NULL,
  `perm_self_status` tinyint(4) DEFAULT NULL,
  `perm_opt_out` tinyint(4) DEFAULT NULL,
  `record_limit` int(11) DEFAULT NULL,
  `search_limit` int(11) DEFAULT NULL,
  `request_limit` int(11) DEFAULT NULL,
  `perm_raw_data` tinyint(4) DEFAULT NULL,
  `perm_show_full_desc` tinyint(4) DEFAULT '1',
  `perm_show_all_fields` tinyint(1) DEFAULT '0',
  `perm_users-saved-search` tinyint(4) DEFAULT '1',
  `perm_users-profile-adoption` tinyint(4) DEFAULT '1',
  `perm_users-profile-write` tinyint(4) DEFAULT '1',
  `perm_users-profile-read` tinyint(4) DEFAULT '1',
  `perm_users-authenticate` tinyint(4) DEFAULT '1',
  `perm_users-create` tinyint(4) DEFAULT '1',
  `perm_search-record-count` tinyint(4) DEFAULT '1',
  `perm_geocoder` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


# Table: sys_group_members
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_group_members`;

CREATE TABLE `sys_group_members` (
  `gid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  UNIQUE KEY `gid` (`gid`,`uid`),
  KEY `uid_idx` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_groups
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_groups`;

CREATE TABLE `sys_groups` (
  `gid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `descr` varchar(90) NOT NULL,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `name` (`name`),
  KEY `gid` (`gid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_log_security
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_log_security`;

CREATE TABLE `sys_log_security` (
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `uid` int(10) unsigned NOT NULL,
  `remotehost` varchar(255) NOT NULL DEFAULT 'UNKNOWN',
  `uri` varchar(255) NOT NULL DEFAULT 'UNKNOWN',
  `message` varchar(255) NOT NULL DEFAULT 'NO MESSAGE PROVIDED',
  KEY `uid` (`uid`),
  KEY `remotehost` (`remotehost`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_optin_log
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_optin_log`;

CREATE TABLE `sys_optin_log` (
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `uid` int(10) unsigned NOT NULL,
  `optin_id` int(10) unsigned NOT NULL,
  `action` enum('add','drop') NOT NULL,
  `reason` varchar(25) DEFAULT NULL,
  KEY `date` (`date`),
  KEY `uid` (`uid`),
  KEY `optin_id` (`optin_id`),
  KEY `action` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_optins
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_optins`;

CREATE TABLE `sys_optins` (
  `optin_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`optin_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_roles
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_roles`;

CREATE TABLE `sys_roles` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `descr` varchar(50) NOT NULL,
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_roles_grant
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_roles_grant`;

CREATE TABLE `sys_roles_grant` (
  `rid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  UNIQUE KEY `rid` (`rid`,`uid`),
  KEY `uid_idx` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_saved_searches
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_saved_searches`;

CREATE TABLE `sys_saved_searches` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `url` varchar(2000) NOT NULL,
  `description` varchar(255) NOT NULL,
  `notify` tinyint(4) NOT NULL DEFAULT '0',
  `last_email` datetime DEFAULT NULL,
  `last_checked` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `new_pets` date DEFAULT NULL,
  PRIMARY KEY (`search_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_user_openids
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_user_openids`;

CREATE TABLE `sys_user_openids` (
  `open_id` varchar(255) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`open_id`),
  UNIQUE KEY `open_id` (`open_id`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_user_optins
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_user_optins`;

CREATE TABLE `sys_user_optins` (
  `optin_id` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `code` varchar(25) DEFAULT NULL,
  UNIQUE KEY `optin_id` (`optin_id`,`uid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_users
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_users`;

CREATE TABLE `sys_users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` char(50) NOT NULL,
  `contact_id_fk` int(10) unsigned DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_valid` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `disabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lock_date` date DEFAULT NULL,
  `lock_reason` varchar(255) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `pass_expires` date DEFAULT NULL,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `salt` varchar(25) DEFAULT NULL,
  `algorithm` varchar(15) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email_confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `pending_email` varchar(255) DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `shelter_id` varchar(255) DEFAULT NULL,
  `last_synced` datetime DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `email_valid` (`email_valid`),
  KEY `contact_id_fk` (`contact_id_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: sys_volunteers
# ------------------------------------------------------------
DROP TABLE IF EXISTS `sys_volunteers`;

CREATE TABLE `sys_volunteers` (
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `age` varchar(10) DEFAULT NULL,
  `travel_distance` smallint(6) DEFAULT NULL,
  `experienced` tinyint(1) unsigned DEFAULT NULL,
  `hours_per_week` varchar(10) DEFAULT NULL,
  `notes` text,
  `foster_dogs` varchar(50) DEFAULT NULL,
  `foster_cats` varchar(50) DEFAULT NULL,
  `foster_other` varchar(59) DEFAULT NULL,
  `mailings` tinyint(1) unsigned DEFAULT NULL,
  `training` tinyint(1) unsigned DEFAULT NULL,
  `dog_socialization` tinyint(1) unsigned DEFAULT NULL,
  `cat_socialization` tinyint(1) unsigned DEFAULT NULL,
  `adoption_followup` tinyint(1) unsigned DEFAULT NULL,
  `administrative` tinyint(1) unsigned DEFAULT NULL,
  `fundraise` tinyint(1) unsigned DEFAULT NULL,
  `transport` tinyint(1) unsigned DEFAULT NULL,
  `cleaning` tinyint(1) unsigned DEFAULT NULL,
  `general_writing` tinyint(1) unsigned DEFAULT NULL,
  `special_events` tinyint(1) unsigned DEFAULT NULL,
  `grant_writing` tinyint(1) unsigned DEFAULT NULL,
  `home_visits` tinyint(1) unsigned DEFAULT NULL,
  `petfinder` tinyint(1) unsigned DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`uid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# Table: user_pets
# ------------------------------------------------------------
DROP TABLE IF EXISTS `user_pets`;

CREATE TABLE `user_pets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `is_new` tinyint(1) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `acquisition_method` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `adoption_date` date DEFAULT NULL,
  `food_preference` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discovery_method` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `discovery_method_details` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type_id` int(11) NOT NULL,
  `primary_breed_id` int(11) DEFAULT NULL,
  `secondary_breed_id` int(11) DEFAULT NULL,
  `size_id` int(11) DEFAULT NULL,
  `shelter_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_FCB9A6F6A76ED395` (`user_id`),
  CONSTRAINT `FK_FCB9A6F6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `sys_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


# Table: video_group
# ------------------------------------------------------------
DROP TABLE IF EXISTS `video_group`;

CREATE TABLE `video_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
