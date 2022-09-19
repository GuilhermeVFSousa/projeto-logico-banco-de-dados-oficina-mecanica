CREATE SCHEMA IF NOT EXISTS Oficina_Mecanica ;
USE Oficina_Mecanica;

-- -----------------------------------------------------
-- Table Cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Cliente (
  idCliente INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(60) NOT NULL,
  CPF VARCHAR(11) NOT NULL,
  Telefone VARCHAR(45) NULL,
  Endereco VARCHAR(100) NULL,
  PRIMARY KEY (idCliente),
  CONSTRAINT UNIQUE CPF_UNIQUE (CPF),
  CONSTRAINT UNIQUE idCliente_UNIQUE (idCliente)
  );
ALTER TABLE CLIENTE AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Veiculo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Veiculo (
  idVeiculo INT NOT NULL AUTO_INCREMENT,
  Modelo VARCHAR(45) NOT NULL,
  Marca VARCHAR(45) NOT NULL,
  Placa VARCHAR(7) NOT NULL,
  Cliente_idCliente INT NOT NULL,
  PRIMARY KEY (idVeiculo, Cliente_idCliente),
  CONSTRAINT UNIQUE Placa_UNIQUE (Placa),
  CONSTRAINT fk_Veiculo_Cliente
    FOREIGN KEY (Cliente_idCliente)
    REFERENCES Cliente (idCliente)
    );
ALTER TABLE Veiculo AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Funcionarios
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Funcionarios (
  idFuncionarios INT NOT NULL AUTO_INCREMENT,
  Nome VARCHAR(60) NOT NULL,
  Endereço VARCHAR(100) NOT NULL,
  Telefone VARCHAR(45) NULL,
  PRIMARY KEY (idFuncionarios)
  );
ALTER TABLE Funcionarios AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Mecanicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Mecanicos (
  idMecanicos INT NOT NULL AUTO_INCREMENT,
  Codigo_Funcionario INT NOT NULL,
  Funcionarios_idFuncionarios INT NOT NULL,
  PRIMARY KEY (idMecanicos, Funcionarios_idFuncionarios),
  CONSTRAINT UNIQUE Codigo_Funcionario_UNIQUE (Codigo_Funcionario),
  CONSTRAINT fk_Mecanicos_Funcionarios
    FOREIGN KEY (Funcionarios_idFuncionarios)
    REFERENCES Funcionarios (idFuncionarios)
    );
ALTER TABLE Mecanicos AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Equipe
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Equipe (
  idEquipe INT NOT NULL AUTO_INCREMENT,
  EquipeNome VARCHAR(45) NOT NULL,
  Especialidade VARCHAR(45) NOT NULL,
  PRIMARY KEY (idEquipe)
  );
ALTER TABLE Equipe AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido (
  idPedido INT NOT NULL AUTO_INCREMENT,
  Veiculo_idVeiculo INT NOT NULL,
  Veiculo_Cliente_idCliente INT NOT NULL,
  Equipe_idEquipe INT NOT NULL,
  Servico_idServico INT NOT NULL,
  PRIMARY KEY (idPedido, Veiculo_idVeiculo, Veiculo_Cliente_idCliente, Equipe_idEquipe, Servico_idServico),
  CONSTRAINT fk_Pedido_Veiculo
    FOREIGN KEY (Veiculo_idVeiculo , Veiculo_Cliente_idCliente)
    REFERENCES Veiculo (idVeiculo , Cliente_idCliente),
  CONSTRAINT fk_Pedido_Equipe
    FOREIGN KEY (Equipe_idEquipe)
    REFERENCES Equipe (idEquipe)
    );
ALTER TABLE Pedido AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pecas (
  idPecas INT NOT NULL AUTO_INCREMENT,
  NomePeca VARCHAR(45) NOT NULL,
  ValorPeca FLOAT NOT NULL,
  PRIMARY KEY (idPecas)
  );
ALTER TABLE Pecas AUTO_INCREMENT = 1;

-- -----------------------------------------------------
-- Table Servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Servico (
  idServico INT NOT NULL AUTO_INCREMENT,
  ServicoNome VARCHAR(45) NOT NULL,
  ValorMaoDeObra FLOAT NOT NULL,
  PRIMARY KEY (idServico)
  );
ALTER TABLE Servico AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table OrdemDeServico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS OrdemDeServico (
  idOrdemDeServico INT NOT NULL AUTO_INCREMENT,
  Numero_OS VARCHAR(45) NULL,
  DataEmissao DATE NULL,
  Status_OS VARCHAR(45),
  DataConclusao DATE NULL,
  Pedido_idPedido INT NOT NULL,
  PRIMARY KEY (idOrdemDeServico, Pedido_idPedido),
  CONSTRAINT UNIQUE Numero_OS_UNIQUE (Numero_OS),
  CONSTRAINT fk_OrdemDeServico_Pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido)
    );
ALTER TABLE OrdemDeServico AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Table Pedido_Servico
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido_Servico (
  Pedido_idPedido INT NOT NULL,
  Servico_idServico INT NOT NULL,
  Quantidade INT NULL,
  PRIMARY KEY (Pedido_idPedido, Servico_idServico),
  CONSTRAINT fk_Pedido_has_Servico_Pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_Pedido_has_Servico_Servico
    FOREIGN KEY (Servico_idServico)
    REFERENCES Servico (idServico)
    );


-- -----------------------------------------------------
-- Table Pedido_Pecas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Pedido_Pecas (
  Pedido_idPedido INT NOT NULL,
  Pecas_idPecas INT NOT NULL,
  Quantidade INT NULL,
  PRIMARY KEY (Pedido_idPedido, Pecas_idPecas),
  CONSTRAINT fk_Pedido_has_Pecas_Pedido
    FOREIGN KEY (Pedido_idPedido)
    REFERENCES Pedido (idPedido),
  CONSTRAINT fk_Pedido_has_Pecas_Pecas
    FOREIGN KEY (Pecas_idPecas)
    REFERENCES Pecas (idPecas)
    );


-- -----------------------------------------------------
-- Table Equipe_Mecanicos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Equipe_Mecanicos (
  Equipe_idEquipe INT NOT NULL,
  Mecanicos_idMecanicos INT NOT NULL,
  PRIMARY KEY (Equipe_idEquipe, Mecanicos_idMecanicos),
  CONSTRAINT fk_Equipe_has_Mecanicos_Equipe
    FOREIGN KEY (Equipe_idEquipe)
    REFERENCES Equipe (idEquipe),
  CONSTRAINT fk_Equipe_has_Mecanicos_Mecanicos
    FOREIGN KEY (Mecanicos_idMecanicos)
    REFERENCES Mecanicos (idMecanicos)
    );

