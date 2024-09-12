-- MySQL Script generated by MySQL Workbench
-- Tue Sep 10 12:50:40 2024
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aluno` (
  `idAlunos` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Data_nascimento` DATE NULL,
  `CPF` VARCHAR(11) NOT NULL COMMENT 'CPF vachar no tamanho de 11 pq quero apenas os números e sem formatação (com pontos e traços)',
  `endereco` VARCHAR(45) NULL,
  `telefone` VARCHAR(15) NULL COMMENT 'Telefone vachar(15) com formatação e código do país',
  PRIMARY KEY (`idAlunos`, `CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `idProfessor` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Data_nascimento` DATE NULL,
  `CPF` VARCHAR(11) NOT NULL COMMENT 'CPF vachar no tamanho de 11 pq quero apenas os números e sem formatação (com pontos e traços)',
  `endereco` VARCHAR(45) NULL,
  `telefone` VARCHAR(15) NULL COMMENT 'Telefone vachar(15) com formatação e código do país',
  PRIMARY KEY (`idProfessor`, `CPF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `idcurso` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(255) NULL,
  `creditosTotal` INT NOT NULL COMMENT 'Nescessario creditos totais do curso',
  `id_disciplinas` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcurso`, `id_disciplinas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disciplina` (
  `idDisciplinas` INT NOT NULL AUTO_INCREMENT,
  `ID_curso` INT NOT NULL,
  `ID_Professor` INT NOT NULL,
  `ID_alunos` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `creditos` INT NULL COMMENT 'creditos que a disciplina deu',
  PRIMARY KEY (`idDisciplinas`, `ID_curso`, `ID_Professor`, `ID_alunos`),
  INDEX `ID_curso_idx` (`ID_curso` ASC) VISIBLE,
  INDEX `ID_Professor_idx` (`ID_Professor` ASC) VISIBLE,
  INDEX `ID_Alunos_idx` (`ID_alunos` ASC) VISIBLE,
  CONSTRAINT `ID_curso`
    FOREIGN KEY (`ID_curso`)
    REFERENCES `mydb`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Professor`
    FOREIGN KEY (`ID_Professor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Alunos`
    FOREIGN KEY (`ID_alunos`)
    REFERENCES `mydb`.`Aluno` (`idAlunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`matricula` (
  `idmatriculas` INT NOT NULL AUTO_INCREMENT,
  `id_aluno` INT NOT NULL,
  `ID_disciplina` INT NOT NULL,
  `data_matricula` DATE NOT NULL,
  PRIMARY KEY (`idmatriculas`, `id_aluno`, `ID_disciplina`),
  INDEX `ID_aluno_idx` (`id_aluno` ASC) VISIBLE,
  INDEX `ID_discipina_idx` (`ID_disciplina` ASC) VISIBLE,
  CONSTRAINT `ID_aluno`
    FOREIGN KEY (`id_aluno`)
    REFERENCES `mydb`.`Aluno` (`idAlunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_discipina`
    FOREIGN KEY (`ID_disciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aula` (
  `idAula` INT NOT NULL AUTO_INCREMENT,
  `ID_disciplina` INT NOT NULL,
  `ID_Professor` INT NOT NULL,
  `ID_alunos` INT NOT NULL,
  `data` DATE NOT NULL,
  `time` TIME NOT NULL,
  PRIMARY KEY (`idAula`, `ID_disciplina`, `ID_Professor`, `ID_alunos`),
  INDEX `ID_disciplina_idx` (`ID_disciplina` ASC) VISIBLE,
  INDEX `ID_professor_idx` (`ID_Professor` ASC) VISIBLE,
  INDEX `ID_Alunos_idx` (`ID_alunos` ASC) VISIBLE,
  CONSTRAINT `ID_disciplina`
    FOREIGN KEY (`ID_disciplina`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_professor`
    FOREIGN KEY (`ID_Professor`)
    REFERENCES `mydb`.`Professor` (`idProfessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_Alunos`
    FOREIGN KEY (`ID_alunos`)
    REFERENCES `mydb`.`Aluno` (`idAlunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno_aula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno_aula` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ID_aula` INT NOT NULL,
  `ID_aluno` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `ID_aula_idx` (`ID_aula` ASC) VISIBLE,
  INDEX `ID_aluno_idx` (`ID_aluno` ASC) VISIBLE,
  CONSTRAINT `ID_aula`
    FOREIGN KEY (`ID_aula`)
    REFERENCES `mydb`.`Aula` (`idAula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_aluno`
    FOREIGN KEY (`ID_aluno`)
    REFERENCES `mydb`.`Aluno` (`idAlunos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`disciplinas_cursando`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`disciplinas_cursando` (
  `iddisciplinas_cursando` INT NOT NULL AUTO_INCREMENT,
  `ID_disciplinas` INT NOT NULL,
  `ID_curso` INT NOT NULL,
  PRIMARY KEY (`iddisciplinas_cursando`),
  INDEX `ID_curso_idx` (`ID_curso` ASC) VISIBLE,
  INDEX `ID_disciplinas_idx` (`ID_disciplinas` ASC) VISIBLE,
  CONSTRAINT `ID_curso`
    FOREIGN KEY (`ID_curso`)
    REFERENCES `mydb`.`curso` (`id_disciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ID_disciplinas`
    FOREIGN KEY (`ID_disciplinas`)
    REFERENCES `mydb`.`Disciplina` (`idDisciplinas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;