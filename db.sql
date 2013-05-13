SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Category` (
  `ID` INT NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  `CategoryOverThisCategoryID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Category_Category1` (`CategoryOverThisCategoryID` ASC) ,
  CONSTRAINT `fk_Category_Category1`
    FOREIGN KEY (`CategoryOverThisCategoryID` )
    REFERENCES `mydb`.`Category` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Login`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Login` (
  `username` VARCHAR(20) NOT NULL ,
  `password` VARCHAR(32) NOT NULL ,
  `email` VARCHAR(100) NOT NULL ,
  `name` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`username`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Article`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Article` (
  `ID` INT NOT NULL ,
  `Content` TEXT NOT NULL ,
  `Header` VARCHAR(200) NOT NULL ,
  `type` ENUM('article','exersise','tutorial') NOT NULL ,
  `date` DATETIME NOT NULL ,
  `CategoryID` INT NOT NULL ,
  `username` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`ID`, `CategoryID`, `username`) ,
  INDEX `fk_Article_category1` (`CategoryID` ASC) ,
  INDEX `fk_Article_Login1` (`username` ASC) ,
  CONSTRAINT `fk_Article_category1`
    FOREIGN KEY (`CategoryID` )
    REFERENCES `mydb`.`Category` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Article_Login1`
    FOREIGN KEY (`username` )
    REFERENCES `mydb`.`Login` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Assets`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Assets` (
  `ID` INT NOT NULL ,
  `url` VARCHAR(1000) NOT NULL ,
  `ArticleID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_Images_Article1` (`ArticleID` ASC) ,
  CONSTRAINT `fk_Images_Article1`
    FOREIGN KEY (`ArticleID` )
    REFERENCES `mydb`.`Article` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Message`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Message` (
  `ID` INT NOT NULL ,
  `message` TEXT NOT NULL ,
  `email` VARCHAR(100) NULL ,
  `name` VARCHAR(100) NULL ,
  `answered` TINYINT(1) NOT NULL DEFAULT false ,
  `date` DATETIME NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MessageAnswer`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`MessageAnswer` (
  `ID` INT NOT NULL ,
  `answer` TEXT NOT NULL ,
  `wasThisHelpfullYes` INT NOT NULL ,
  `wasThisHelpfullNo` INT NOT NULL ,
  `date` DATETIME NOT NULL ,
  `username` VARCHAR(20) NOT NULL ,
  `MessagesID` INT NOT NULL ,
  PRIMARY KEY (`ID`) ,
  INDEX `fk_MessageAnswers_Login1` (`username` ASC) ,
  INDEX `fk_MessageAnswers_Messages1` (`MessagesID` ASC) ,
  CONSTRAINT `fk_MessageAnswers_Login1`
    FOREIGN KEY (`username` )
    REFERENCES `mydb`.`Login` (`username` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MessageAnswers_Messages1`
    FOREIGN KEY (`MessagesID` )
    REFERENCES `mydb`.`Message` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Tag` (
  `ID` INT NOT NULL ,
  `name` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`ID`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TagsMessage`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`TagsMessage` (
  `TagsID` INT NOT NULL ,
  `MessagesID` INT NOT NULL ,
  PRIMARY KEY (`TagsID`, `MessagesID`) ,
  INDEX `fk_Tags_has_Messages_Messages1` (`MessagesID` ASC) ,
  INDEX `fk_Tags_has_Messages_Tags1` (`TagsID` ASC) ,
  CONSTRAINT `fk_Tags_has_Messages_Tags1`
    FOREIGN KEY (`TagsID` )
    REFERENCES `mydb`.`Tag` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tags_has_Messages_Messages1`
    FOREIGN KEY (`MessagesID` )
    REFERENCES `mydb`.`Message` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TagsArticle`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`TagsArticle` (
  `TagsID` INT NOT NULL ,
  `ArticleID` INT NOT NULL ,
  PRIMARY KEY (`TagsID`, `ArticleID`) ,
  INDEX `fk_Tags_has_Article_Article1` (`ArticleID` ASC) ,
  INDEX `fk_Tags_has_Article_Tags1` (`TagsID` ASC) ,
  CONSTRAINT `fk_Tags_has_Article_Tags1`
    FOREIGN KEY (`TagsID` )
    REFERENCES `mydb`.`Tag` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tags_has_Article_Article1`
    FOREIGN KEY (`ArticleID` )
    REFERENCES `mydb`.`Article` (`ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
