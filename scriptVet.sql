CREATE TABLE Pessoas (
  cpf          VARCHAR(14) NOT NULL,
  nome         VARCHAR(60) NULL,
  dtNascimento DATETIME NULL,
  rua          VARCHAR(45) NULL,
  bairro       VARCHAR(45) NULL,
  CONSTRAINT pk_Pessoas 
    PRIMARY KEY (cpf)
);

CREATE TABLE Pessoas_Fones (
  fone        VARCHAR(15) NOT NULL,
  pessoas_cpf VARCHAR(14) NOT NULL,
  CONSTRAINT pk_PessoasFones
    PRIMARY KEY (fone, pessoas_cpf),
  CONSTRAINT fk_Pessoas_Fones_Pessoas
    FOREIGN KEY (pessoas_cpf)
    REFERENCES Pessoas (cpf)
);

CREATE TABLE Veterinarios (
  vet_cpf        VARCHAR(14) NOT NULL,
  especialidade  VARCHAR(50) NULL,
  dtAdmissao     DATETIME NOT NULL,
  CONSTRAINT pk_Veterinarios 
    PRIMARY KEY (vet_cpf),
  CONSTRAINT fk_Veterinarios_Pessoas
    FOREIGN KEY (vet_cpf)
    REFERENCES Pessoas (cpf)
);

CREATE TABLE Animais (
  animal_id      INT NOT NULL AUTO_INCREMENT,
  nome_animal    VARCHAR(40) NOT NULL,
  especie        VARCHAR(30) NOT NULL,
  raca           VARCHAR(30),
  dtNascimento   DATETIME NULL,
  dono_cpf       VARCHAR(14) NOT NULL,
  CONSTRAINT pk_Animais 
    PRIMARY KEY (animal_id),
  CONSTRAINT fk_Animais_Dono
    FOREIGN KEY (dono_cpf)
    REFERENCES Pessoas (cpf)
);

CREATE TABLE Consultas (
  consulta_id       INT NOT NULL AUTO_INCREMENT,
  consulta_data     DATETIME NOT NULL,
  veterinario_cpf   VARCHAR(14) NOT NULL,
  animal_id         INT NOT NULL,
  CONSTRAINT pk_Consultas 
    PRIMARY KEY (consulta_id),
  CONSTRAINT fk_Consultas_Veterinarios
    FOREIGN KEY (veterinario_cpf)
    REFERENCES Veterinarios (vet_cpf),
  CONSTRAINT fk_Consultas_Animais
    FOREIGN KEY (animal_id)
    REFERENCES Animais (animal_id)
);

CREATE TABLE Tratamentos (
  tratamento_id    INT NOT NULL AUTO_INCREMENT,
  consulta_id      INT NOT NULL,
  descricao        VARCHAR(100),
  medicamento      VARCHAR(50),
  duracao_dias     INT,
  CONSTRAINT pk_Tratamentos 
    PRIMARY KEY (tratamento_id),
  CONSTRAINT fk_Tratamentos_Consultas
    FOREIGN KEY (consulta_id)
    REFERENCES Consultas (consulta_id)
);

-- ALTER - para alterar a estrutura da tabela
ALTER TABLE Veterinarios
  ADD COLUMN registro_profissional VARCHAR(20) NOT NULL,
  ADD CONSTRAINT uk_registro_profissional UNIQUE (registro_profissional);

-- DROP para eliminar a tabela do BD
DROP TABLE Tratamentos;
DROP TABLE Consultas;
DROP TABLE Animais;
DROP TABLE Veterinarios;
DROP TABLE Pessoas_Fones;
DROP TABLE Pessoas;
