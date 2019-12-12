-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema blood-donation-db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema blood-donation-db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `blood-donation-db` DEFAULT CHARACTER SET utf8 ;
USE `blood-donation-db` ;

-- -----------------------------------------------------
-- Table `blood-donation-db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood-donation-db`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `dob` VARCHAR(45) NULL,
  `bloodgroup` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood-donation-db`.`bloddbank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood-donation-db`.`bloddbank` (
  `bbid` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  PRIMARY KEY (`bbid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood-donation-db`.`donations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood-donation-db`.`donations` (
  `donationid` INT NOT NULL AUTO_INCREMENT,
  `user_userId` INT NOT NULL,
  `bloddbank_bbid` INT NOT NULL,
  `amtOfBlood` INT NULL,
  `date` DATE NULL,
  `expiryDate` DATE NULL,
  PRIMARY KEY (`donationid`),
  INDEX `fk_user_has_bloddbank_bloddbank1_idx` (`bloddbank_bbid` ASC),
  INDEX `fk_user_has_bloddbank_user_idx` (`user_userId` ASC),
  CONSTRAINT `fk_user_has_bloddbank_user`
    FOREIGN KEY (`user_userId`)
    REFERENCES `blood-donation-db`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_bloddbank_bloddbank1`
    FOREIGN KEY (`bloddbank_bbid`)
    REFERENCES `blood-donation-db`.`bloddbank` (`bbid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood-donation-db`.`Requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood-donation-db`.`Requests` (
  `requestId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  `bloodGroup` VARCHAR(45) NULL,
  `neededBy` DATE NULL,
  `granted` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`requestId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `blood-donation-db`.`Recepient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `blood-donation-db`.`Recepient` (
  `recepientId` INT NOT NULL AUTO_INCREMENT,
  `Requests_requestId` INT NOT NULL,
  `donations_donationid` INT NOT NULL,
  `user_userId` INT NOT NULL,
  PRIMARY KEY (`recepientId`),
  INDEX `fk_Recepient_Requests1_idx` (`Requests_requestId` ASC),
  INDEX `fk_Recepient_donations1_idx` (`donations_donationid` ASC),
  INDEX `fk_Recepient_user1_idx` (`user_userId` ASC),
  CONSTRAINT `fk_Recepient_Requests1`
    FOREIGN KEY (`Requests_requestId`)
    REFERENCES `blood-donation-db`.`Requests` (`requestId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recepient_donations1`
    FOREIGN KEY (`donations_donationid`)
    REFERENCES `blood-donation-db`.`donations` (`donationid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Recepient_user1`
    FOREIGN KEY (`user_userId`)
    REFERENCES `blood-donation-db`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
