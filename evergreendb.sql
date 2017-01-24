-- MySQL Script generated by MySQL Workbench
-- 01/23/17 18:11:43
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema evergreendb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema evergreendb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `evergreendb` DEFAULT CHARACTER SET utf8 ;
USE `evergreendb` ;

-- -----------------------------------------------------
-- Table `evergreendb`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`users` (
  `id` BINARY(16) NOT NULL,
  `type` TINYINT(1) NULL DEFAULT NULL,
  `company` VARCHAR(45) NULL DEFAULT NULL,
  `contact` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `picture` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`proposals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`proposals` (
  `id` BINARY(16) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT NULL,
  `product` VARCHAR(100) NULL DEFAULT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `completion` DATETIME NULL DEFAULT NULL,
  `zip` INT(11) NULL DEFAULT NULL,
  `audience` TINYINT(1) NULL DEFAULT NULL,
  `info` VARCHAR(1000) NULL DEFAULT NULL,
  `attachment` VARCHAR(45) NULL DEFAULT NULL,
  `nda` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_proposals_users1_idx` (`user_id` ASC),
  CONSTRAINT `fk_proposals_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`addresses` (
  `street` VARCHAR(45) NULL DEFAULT NULL,
  `street_ext` VARCHAR(45) NULL DEFAULT NULL,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `state` VARCHAR(2) NULL DEFAULT NULL,
  `zip` INT(11) NULL DEFAULT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`proposal_id`),
  UNIQUE INDEX `proposal_id_UNIQUE` (`proposal_id` ASC),
  INDEX `fk_addresses_proposals1_idx` (`proposal_id` ASC),
  CONSTRAINT `fk_addresses_proposals1`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `evergreendb`.`proposals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`attachments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`attachments` (
  `id` BINARY(16) NOT NULL,
  `attachment` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_attachments_proposals1_idx` (`proposal_id` ASC),
  CONSTRAINT `fk_attachments_proposals1`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `evergreendb`.`proposals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`banks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`banks` (
  `account` INT(11) NULL DEFAULT NULL,
  `routing` INT(11) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `account_UNIQUE` (`account` ASC),
  UNIQUE INDEX `routing_UNIQUE` (`routing` ASC),
  CONSTRAINT `fk_banks_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`cards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`cards` (
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `number` INT(11) NULL DEFAULT NULL,
  `ccv` INT(11) NULL DEFAULT NULL,
  `expiration` DATETIME NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  INDEX `fk_creditcards_supplier1_idx` (`user_id` ASC),
  CONSTRAINT `fk_cards_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`offers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`offers` (
  `status` TINYINT(1) NULL DEFAULT NULL,
  `sga` DECIMAL(12,2) NULL DEFAULT NULL,
  `profit` DECIMAL(12,2) NULL DEFAULT NULL,
  `overhead` DECIMAL(12,2) NULL DEFAULT NULL,
  `total` DECIMAL(12,2) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`proposal_id`, `user_id`),
  INDEX `fk_offer_proposals1_idx` (`proposal_id` ASC),
  INDEX `fk_offer_supplier1_idx` (`user_id` ASC),
  CONSTRAINT `fk_offer_proposals1`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `evergreendb`.`proposals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_offer_supplier1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`labors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`labors` (
  `id` BINARY(16) NOT NULL,
  `type` TINYINT(1) NULL DEFAULT NULL,
  `labor` VARCHAR(45) NULL DEFAULT NULL,
  `time` INT(11) NULL DEFAULT NULL,
  `yield` INT(11) NULL DEFAULT NULL,
  `rate` DECIMAL(10,2) NULL DEFAULT NULL,
  `count` INT(11) NULL DEFAULT NULL,
  `created_at` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` VARCHAR(45) NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_labors_offers1_idx` (`proposal_id` ASC, `user_id` ASC),
  CONSTRAINT `fk_labors_offers1`
    FOREIGN KEY (`proposal_id` , `user_id`)
    REFERENCES `evergreendb`.`offers` (`proposal_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`leads`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`leads` (
  `maker_id` BINARY(16) NOT NULL,
  `supplier_id` BINARY(16) NOT NULL,
  `created_at` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`maker_id`, `supplier_id`),
  INDEX `fk_users_has_users_users2_idx` (`supplier_id` ASC),
  INDEX `fk_users_has_users_users1_idx` (`maker_id` ASC),
  CONSTRAINT `fk_users_has_users_users1`
    FOREIGN KEY (`maker_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_users_users2`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`materials` (
  `id` BINARY(16) NOT NULL,
  `material` VARCHAR(45) NULL DEFAULT NULL,
  `weight` DECIMAL(12,2) NULL DEFAULT NULL,
  `cost` DECIMAL(12,2) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  `user_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_materials_offers1_idx` (`proposal_id` ASC, `user_id` ASC),
  CONSTRAINT `fk_materials_offers1`
    FOREIGN KEY (`proposal_id` , `user_id`)
    REFERENCES `evergreendb`.`offers` (`proposal_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`messages` (
  `id` BINARY(16) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT NULL,
  `pdf_attach_s` VARCHAR(45) NULL DEFAULT NULL,
  `pdf_attach_m` VARCHAR(45) NULL DEFAULT NULL,
  `jpg_attach_s` VARCHAR(45) NULL DEFAULT NULL,
  `jpg_attach_m` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_messages_offers1_idx` (`user_id` ASC, `proposal_id` ASC),
  CONSTRAINT `fk_messages_offers1`
    FOREIGN KEY (`user_id` , `proposal_id`)
    REFERENCES `evergreendb`.`offers` (`user_id` , `proposal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`ndas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`ndas` (
  `id` BINARY(16) NOT NULL,
  `nda` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_attachments_proposals1_idx` (`proposal_id` ASC),
  CONSTRAINT `fk_attachments_proposals10`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `evergreendb`.`proposals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`processes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`processes` (
  `process` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`process`),
  UNIQUE INDEX `process_UNIQUE` (`process` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`proposal_processes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`proposal_processes` (
  `process` VARCHAR(45) NOT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`process`, `proposal_id`),
  INDEX `fk_processes_has_proposals_proposals1_idx` (`proposal_id` ASC),
  INDEX `fk_processes_has_proposals_processes1_idx` (`process` ASC),
  CONSTRAINT `fk_processes_has_proposals_processes1`
    FOREIGN KEY (`process`)
    REFERENCES `evergreendb`.`processes` (`process`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_processes_has_proposals_proposals1`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `evergreendb`.`proposals` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`reports` (
  `id` BINARY(16) NOT NULL,
  `status` TINYINT(1) NULL DEFAULT NULL,
  `input` VARCHAR(45) NULL DEFAULT NULL,
  `output` VARCHAR(45) NULL DEFAULT NULL,
  `shipping` VARCHAR(45) NULL DEFAULT NULL,
  `note` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` VARCHAR(45) NULL DEFAULT NULL,
  `updated_at` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  `proposal_id` BINARY(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_reports_offers1_idx` (`user_id` ASC, `proposal_id` ASC),
  CONSTRAINT `fk_reports_offers1`
    FOREIGN KEY (`user_id` , `proposal_id`)
    REFERENCES `evergreendb`.`offers` (`user_id` , `proposal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`urls`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`urls` (
  `homepage` VARCHAR(255) NULL DEFAULT NULL,
  `facebook` VARCHAR(255) NULL DEFAULT NULL,
  `instagram` VARCHAR(255) NULL DEFAULT NULL,
  `linkedin` VARCHAR(255) NULL DEFAULT NULL,
  `twiiter` VARCHAR(255) NULL DEFAULT NULL,
  `user_id` BINARY(16) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  UNIQUE INDEX `supplier_id_UNIQUE` (`user_id` ASC),
  INDEX `fk_urls_suppliers1_idx` (`user_id` ASC),
  CONSTRAINT `fk_urls_suppliers1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `evergreendb`.`user_processes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evergreendb`.`user_processes` (
  `process` VARCHAR(45) NOT NULL,
  `user_id` BINARY(16) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`process`, `user_id`),
  INDEX `fk_processes_has_users_users1_idx` (`user_id` ASC),
  INDEX `fk_processes_has_users_processes1_idx` (`process` ASC),
  CONSTRAINT `fk_processes_has_users_processes1`
    FOREIGN KEY (`process`)
    REFERENCES `evergreendb`.`processes` (`process`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_processes_has_users_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `evergreendb`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
