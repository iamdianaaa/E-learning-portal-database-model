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
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ratings` (
  `ratingId` INT NOT NULL,
  `rating` INT NULL,
  PRIMARY KEY (`ratingId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Progress` (
  `idProgress` INT NOT NULL AUTO_INCREMENT,
  `problemGrade` INT NOT NULL,
  `moduleProgress` INT NOT NULL,
  PRIMARY KEY (`idProgress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courses` (
  `courseId` INT NOT NULL AUTO_INCREMENT,
  `courseName` VARCHAR(45) NOT NULL,
  `coursePrice` FLOAT NOT NULL,
  `courseDescription` VARCHAR(200) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `isFree` TINYINT(1) NOT NULL,
  `duration` VARCHAR(45) NOT NULL,
  `hasCertificate` TINYINT(1) NULL,
  `language` VARCHAR(45) NOT NULL,
  `uploadedOn` VARCHAR(45) NOT NULL,
  `Ratings_ratingId` INT NOT NULL,
  `Progress_idProgress` INT NOT NULL,
  PRIMARY KEY (`courseId`),
  INDEX `fk_Courses_Ratings1_idx` (`Ratings_ratingId` ASC) VISIBLE,
  INDEX `fk_Courses_Progress1_idx` (`Progress_idProgress` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_Ratings1`
    FOREIGN KEY (`Ratings_ratingId`)
    REFERENCES `mydb`.`Ratings` (`ratingId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_Progress1`
    FOREIGN KEY (`Progress_idProgress`)
    REFERENCES `mydb`.`Progress` (`idProgress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modules` (
  `moduleId` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `slideUrl` VARCHAR(45) NOT NULL,
  `videoUrl` VARCHAR(45) NOT NULL,
  `Courses_courseId` INT NOT NULL,
  PRIMARY KEY (`moduleId`),
  INDEX `fk_Modules_Courses_idx` (`Courses_courseId` ASC) VISIBLE,
  CONSTRAINT `fk_Modules_Courses`
    FOREIGN KEY (`Courses_courseId`)
    REFERENCES `mydb`.`Courses` (`courseId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProblemSets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ProblemSets` (
  `problemSetId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(200) NOT NULL,
  `deadline` DATETIME(18) NOT NULL,
  `submissionDetails` VARCHAR(45) NOT NULL,
  `Modules_moduleId` INT NOT NULL,
  PRIMARY KEY (`problemSetId`),
  INDEX `fk_ProblemSets_Modules1_idx` (`Modules_moduleId` ASC) VISIBLE,
  CONSTRAINT `fk_ProblemSets_Modules1`
    FOREIGN KEY (`Modules_moduleId`)
    REFERENCES `mydb`.`Modules` (`moduleId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Users` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `isNotificationSend` TINYINT(1) NULL,
  `isAgreePolicy` TINYINT(1) NOT NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Notifications` (
  `notificationId` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(100) NOT NULL,
  `Users_userId` INT NOT NULL,
  PRIMARY KEY (`notificationId`),
  INDEX `fk_Notifications_Users1_idx` (`Users_userId` ASC) VISIBLE,
  CONSTRAINT `fk_Notifications_Users1`
    FOREIGN KEY (`Users_userId`)
    REFERENCES `mydb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Enrollment` (
  `Courses_courseId` INT NOT NULL,
  `Users_userId` INT NOT NULL,
  `paymentType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Courses_courseId`, `Users_userId`),
  INDEX `fk_Courses_has_Users_Users1_idx` (`Users_userId` ASC) VISIBLE,
  INDEX `fk_Courses_has_Users_Courses1_idx` (`Courses_courseId` ASC) VISIBLE,
  CONSTRAINT `fk_Courses_has_Users_Courses1`
    FOREIGN KEY (`Courses_courseId`)
    REFERENCES `mydb`.`Courses` (`courseId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Courses_has_Users_Users1`
    FOREIGN KEY (`Users_userId`)
    REFERENCES `mydb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Forums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Forums` (
  `forumId` INT NOT NULL,
  `comment` VARCHAR(200) NULL,
  `Users_userId` INT NOT NULL,
  `Courses_courseId` INT NOT NULL,
  PRIMARY KEY (`forumId`),
  INDEX `fk_Forums_Users1_idx` (`Users_userId` ASC) VISIBLE,
  INDEX `fk_Forums_Courses1_idx` (`Courses_courseId` ASC) VISIBLE,
  CONSTRAINT `fk_Forums_Users1`
    FOREIGN KEY (`Users_userId`)
    REFERENCES `mydb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Forums_Courses1`
    FOREIGN KEY (`Courses_courseId`)
    REFERENCES `mydb`.`Courses` (`courseId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Support Chats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Support Chats` (
  `chatId` INT NOT NULL AUTO_INCREMENT,
  `questionComment` VARCHAR(200) NOT NULL,
  `Users_userId` INT NOT NULL,
  PRIMARY KEY (`chatId`),
  INDEX `fk_Support Chats_Users1_idx` (`Users_userId` ASC) VISIBLE,
  CONSTRAINT `fk_Support Chats_Users1`
    FOREIGN KEY (`Users_userId`)
    REFERENCES `mydb`.`Users` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
