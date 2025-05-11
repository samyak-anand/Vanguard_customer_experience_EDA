-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `vanguard` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema vanguard
-- -----------------------------------------------------
USE `vanguard` ;

-- -----------------------------------------------------
-- Table `vanguard`.`customer_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vanguard`.`customer_data` (
  `client_id` INT NOT NULL,
  `clnt_tenure_yr` DECIMAL(5,1) NULL,
  `clnt_tenure_mnth` DECIMAL(5,1) NULL,
  `clnt_age` DECIMAL(5,1) NULL,
  `gendr` CHAR(8) NULL,
  `num_accts` DECIMAL(5,1) NULL,
  `bal` DECIMAL(10,2) NULL,
  `calls_6_mnth` DECIMAL(5,1) NULL,
  `logons_6_mnth` DECIMAL(5,1) NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE INDEX `client_id_UNIQUE` (`client_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vanguard`.`digital_footprint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vanguard`.`digital_footprint` (
  `client_id` INT NOT NULL,
  `visitor_id` VARCHAR(45) NULL,
  `visit_id` VARCHAR(45) NULL,
  `process_step` VARCHAR(45) NULL,
  `date_time` DATETIME NULL,
  `customer_data_client_id` INT NOT NULL,
  PRIMARY KEY (`client_id`),
  INDEX `fk_digital_footprint_customer_data_idx` (`customer_data_client_id` ASC) VISIBLE,
  CONSTRAINT `fk_digital_footprint_customer_data`
    FOREIGN KEY (`customer_data_client_id`)
    REFERENCES `vanguard`.`customer_data` (`client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
