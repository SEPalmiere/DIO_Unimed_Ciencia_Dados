-- Criacao do database Oficina_Mecanica
-- By Sergio Palmiere
drop database oficina_mecanica;
create database oficina_mecanica;
show databases;
use oficina_mecanica;
show tables;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema oficina_mecanica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema oficina_mecanica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina_mecanica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `oficina_mecanica` ;

-- -----------------------------------------------------
-- Table `oficina_mecanica`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`pessoa` (
  `CPF` CHAR(11) NOT NULL,
  `Pnome` VARCHAR(45) NULL DEFAULT NULL,
  `Snome` VARCHAR(45) NULL DEFAULT NULL,
  `Sobrenome` VARCHAR(45) NULL DEFAULT NULL,
  `Data_nascimento` DATETIME NULL DEFAULT NULL,
  `Sexo` ENUM('masculino', 'feminino') NULL DEFAULT NULL,
  PRIMARY KEY (`CPF`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`veiculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`veiculo` (
  `idVeiculo` INT NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Ano_fabricacao` YEAR NOT NULL,
  `Placa` CHAR(7) NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`cliente` (
  `idCliente` VARCHAR(45) NOT NULL,
  `Pessoa_CPF` CHAR(11) NOT NULL,
  `Veiculo_idVeiculo` INT NOT NULL,
  `Endereco` VARCHAR(45) NULL DEFAULT NULL,
  `fone` CHAR(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Pessoa_CPF_UNIQUE` (`Pessoa_CPF` ASC) VISIBLE,
  INDEX `fk_Cliente_Veiculo1_idx` (`Veiculo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_Cliente_Pessoa2_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa2`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `oficina_mecanica`.`pessoa` (`CPF`),
  CONSTRAINT `fk_Cliente_Veiculo1`
    FOREIGN KEY (`Veiculo_idVeiculo`)
    REFERENCES `oficina_mecanica`.`veiculo` (`idVeiculo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`equipe` (
  `idEquipe` INT NOT NULL AUTO_INCREMENT,
  `funcao` CHAR(25) NOT NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`manutencao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`manutencao` (
  `idManutencao` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NULL DEFAULT NULL,
  `preco` FLOAT NOT NULL,
  `quantidade_horas` INT NOT NULL,
  PRIMARY KEY (`idManutencao`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`mecanico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`mecanico` (
  `idMecanico` VARCHAR(45) NOT NULL,
  `Pessoa_CPF` CHAR(11) NOT NULL,
  `salario` FLOAT NULL DEFAULT NULL,
  `Especialidade` VARCHAR(45) NULL DEFAULT NULL,
  `contratacao` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idMecanico`),
  UNIQUE INDEX `idMecanico_UNIQUE` (`idMecanico` ASC) VISIBLE,
  UNIQUE INDEX `Pessoa_CPF_UNIQUE` (`Pessoa_CPF` ASC) VISIBLE,
  INDEX `fk_Mecanico_Pessoa1_idx` (`Pessoa_CPF` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_Pessoa1`
    FOREIGN KEY (`Pessoa_CPF`)
    REFERENCES `oficina_mecanica`.`pessoa` (`CPF`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`oficina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`oficina` (
  `idOficina` INT NOT NULL AUTO_INCREMENT,
  `Cliente_idCliente` VARCHAR(45) NOT NULL,
  `Filial_Matriz` ENUM('Filial', 'Matriz') NULL DEFAULT 'Matriz',
  `equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`idOficina`, `Cliente_idCliente`, `equipe_idEquipe`),
  INDEX `fk_Oficina_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_oficina_equipe1_idx` (`equipe_idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Oficina_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `oficina_mecanica`.`cliente` (`idCliente`),
  CONSTRAINT `fk_oficina_equipe1`
    FOREIGN KEY (`equipe_idEquipe`)
    REFERENCES `oficina_mecanica`.`equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`ordem_servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`ordem_servico` (
  `idOS` INT NOT NULL AUTO_INCREMENT,
  `Equipe_idEquipe` INT NOT NULL,
  `Manutencao_idManutencao` INT NOT NULL,
  `Descricao` VARCHAR(255) NULL DEFAULT NULL,
  `Revisao_Conserto` ENUM('Revisao', 'Conserto') NULL DEFAULT 'Conserto',
  `peca_necessaria` INT NULL DEFAULT NULL,
  `status_OS` ENUM('Entrada', 'Em revisao', 'Concluido') NULL DEFAULT NULL,
  `data_emissao` DATETIME NULL DEFAULT NULL,
  `Data_entrega` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idOS`, `Equipe_idEquipe`, `Manutencao_idManutencao`),
  INDEX `fk_Ordem de Servico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Ordem de Servico_Manutencao1_idx` (`Manutencao_idManutencao` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Servico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `oficina_mecanica`.`equipe` (`idEquipe`),
  CONSTRAINT `fk_Ordem de Servico_Manutencao1`
    FOREIGN KEY (`Manutencao_idManutencao`)
    REFERENCES `oficina_mecanica`.`manutencao` (`idManutencao`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`pecas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`pecas` (
  `idPecas` INT NOT NULL AUTO_INCREMENT,
  `Peca` VARCHAR(45) NULL DEFAULT NULL,
  `preco` FLOAT NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`idPecas`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`possui`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`possui` (
  `Pecas_idPecas` INT NOT NULL,
  `Ordem_Servico_idOS` INT NOT NULL,
  `Ordem_Servico_Equipe_idEquipe` INT NOT NULL,
  `Ordem_Servico_Manutencao_idManutencao` INT NOT NULL,
  PRIMARY KEY (`Pecas_idPecas`, `Ordem_Servico_idOS`, `Ordem_Servico_Equipe_idEquipe`, `Ordem_Servico_Manutencao_idManutencao`),
  INDEX `fk_Pecas_has_Ordem_Servico_Ordem_Servico1_idx` (`Ordem_Servico_idOS` ASC, `Ordem_Servico_Equipe_idEquipe` ASC, `Ordem_Servico_Manutencao_idManutencao` ASC) VISIBLE,
  INDEX `fk_Pecas_has_Ordem_Servico_Pecas1_idx` (`Pecas_idPecas` ASC) VISIBLE,
  CONSTRAINT `fk_Pecas_has_Ordem_Servico_Ordem_Servico1`
    FOREIGN KEY (`Ordem_Servico_idOS` , `Ordem_Servico_Equipe_idEquipe` , `Ordem_Servico_Manutencao_idManutencao`)
    REFERENCES `oficina_mecanica`.`ordem_servico` (`idOS` , `Equipe_idEquipe` , `Manutencao_idManutencao`),
  CONSTRAINT `fk_Pecas_has_Ordem_Servico_Pecas1`
    FOREIGN KEY (`Pecas_idPecas`)
    REFERENCES `oficina_mecanica`.`pecas` (`idPecas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oficina_mecanica`.`trabalha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina_mecanica`.`trabalha` (
  `Mecanico_idMecanico` VARCHAR(45) NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`Mecanico_idMecanico`, `Equipe_idEquipe`),
  INDEX `fk_Mecanico_has_Equipe_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Mecanico_has_Equipe_Mecanico1_idx` (`Mecanico_idMecanico` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_has_Equipe_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `oficina_mecanica`.`equipe` (`idEquipe`),
  CONSTRAINT `fk_Mecanico_has_Equipe_Mecanico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `oficina_mecanica`.`mecanico` (`idMecanico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Populando o banco de dados usando dados extraidos do site Mockaroo
    -- By Sergio Palmiere
    
  use oficina_mecanica;  
  
  
insert into Pessoa (CPF, Pnome, Snome, Sobrenome, Data_nascimento, Sexo) 
values (30789862818, 'Gordon', 'Sigmund', 'Bosch', '1989/04/27', 'Masculino'),
		(49969209375, 'Tynan', 'Darby', 'Bleasby', '1978/12/11', 'Masculino'),
		(44858313793, 'Tierney', 'Greer', 'St. Clair', '1994/09/05', 'Feminino'),
		(90987653871, 'Dodi', 'Melodie', 'Mickelwright', '1975/06/18', 'Feminino'),
	    (60695004659, 'Eduard', 'Rolfe', 'Rogerot', '1997/09/04', 'Masculino'),
		(92231017848, 'Chryste', 'Wilone', 'Suff', '1993/12/07', 'Feminino'),
		(15983362639, 'Karly', 'Teena', 'Houldey', '1985/10/15', 'Feminino'),
		(27480593327, 'Sheryl', 'Queenie', 'Loughman', '1987/12/22', 'Feminino'),
		(44573509042, 'Mahalia', 'Genevra', 'Bradnam', '1972/11/18', 'Feminino'),
		(26209450720, 'Emmerich', 'Fernando', 'Stopford', '1985/01/04', 'Masculino');
        
insert into Veiculo (idVeiculo, Modelo, Marca, Ano_fabricacao, Placa) 
values (1,'98', 'Oldsmobile', 1995, '1YV5438'),
		(2,'Montego', 'Mercury', 2007, '1GH4659'),
		(3,'Firebird', 'Pontiac', 1968, 'JHD2685'),
		(4,'Grand Voyager', 'Plymouth', 1994, 'WAU1899'),
		(5,'Mark VIII', 'Lincoln', 1993, 'JHD7796'),
		(6,'Mystique', 'Mercury', 2000, 'CBC8965'),
		(7,'Diablo', 'Lamborghini', 2000, 'JMT5449'),
		(8,'Cabriolet', 'Volkswagen', 1996, 'ABA7424'),
		(9,'Escalade', 'Cadillac', 2003, '1G60719'),
		(10,'Amigo', 'Isuzu', 1999, 'JHC3945');
        
insert into Cliente (idCliente, Pessoa_CPF, Veiculo_idVeiculo, Endereco, fone)
	values (1, 30789862818, 7, 'Sao Paulo', 11999999999),
			(2, 49969209375, 2, 'Sao Paulo', 11777777777),
            (3, 15983362639, 9, 'Sao Paulo', 11333333333);
            
insert into Mecanico (idMecanico, Pessoa_CPF, salario, Especialidade, contratacao)
		values (1, 60695004659, 3.500, 'soldador', '2020/11/01'),
				(2, 26209450720, 3.200, 'reparador', '2020/11/01'),
                (3, 44858313793, 3.500, 'finalizador', '2020/11/01'),
                (4, 92231017848, 3.200, 'preparador', '2020/11/01'),
                (5, 44573509042, 3.500, 'reparador', '2020/11/01');
                
insert into Equipe (idEquipe, funcao)
	values (1, 'Reparos rapidos'),
			(2, 'Reparos Demorados');
            
insert into Trabalha(Mecanico_idMecanico, Equipe_idEquipe)
	Values (1,1),
			(2,1),
            (3,1),
            (4,1),
            (1,2),
            (3,2),
            (4,2),
            (5,2);
            
            
insert into Pecas (idPecas, Peca, preco, quantidade)
		values (1, 'Motor Sedan', 3.800, 3),
				(2, 'Motor Hatch', 5.800, 2),
                (3, 'Filtro Oleo', 55, 20),
                (4, 'Palete limpador', 18.5, 200),
                (5, 'Bobina eletrica', 300, 78);
                
insert into Manutencao (idManutencao, descricao, preco, quantidade_horas)
	values (1, 'Troca motor sedan', 2000, 5),
			(2, 'Troca motor hatch', 3500, 8),
            (3,	'Troca filtro do oleo', 250, 1),
            (4, 'Substituicao palete limpador', 50, 1),
            (5, 'Troca bobina eletrica', 180, 1);
  
insert into Ordem_servico (idOS, Equipe_idEquipe, Manutencao_idManutencao, Descricao, Revisao_Conserto, peca_necessaria, status_OS, data_emissao, data_entrega)
		values (1, 1, 2, 'Troca realizada com sucesso' ,'Revisao', 2, 'Concluido', '2022/10/25', '2022/10/24'),
				(2, 2, 1, 'Em andamento, aguardando peça' ,'Conserto', 1, 'Em revisao', '2022/11/14', '2022/11/15'),
                (3, 1, 5, null ,'Conserto', 5, 'Entrada', '2022/11/14', null);

insert into oficina(idOficina, Cliente_idCliente, Filial_Matriz, equipe_idEquipe)
		values	(1,1,'Matriz',1),
                (1,2,'Matriz',2),
                (2,3,'Filial',2);
                
 insert into possui (Pecas_idPecas, Ordem_Servico_idOS, Ordem_Servico_Equipe_idEquipe, Ordem_Servico_Manutencao_idManutencao)
		values (2,1,1,2),
				(1,2,2,1),
                (5,3,1,5);     
                
                
                
-- Realizando consultas no banco de dados
-- By Sergio Palmiere

Select * from Mecanico;
Select * from equipe;
Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as mecanico, CPF, Sexo from pessoa; 
-- Recuperando os nomes e cpf dos mecanicos 
Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as mecanico, CPF, Sexo from pessoa p, mecanico m
where p.CPF = m.Pessoa_CPF;

-- Recuperando os nomes dos clientes, e seus veiculos com numero da placa
Select concat(Pnome, ' ', Snome, ' ', Sobrenome) as cliente, Modelo, Marca, Placa, Ano_fabricacao
from cliente c, veiculo v, pessoa p
where p.CPF = c.Pessoa_CPF
group by v.marca;

