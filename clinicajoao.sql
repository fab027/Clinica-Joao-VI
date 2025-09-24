-- Criar banco de dados
CREATE DATABASE clinica_joaovi;
USE clinica_joaovi;

-- =========================
-- TABELA ENDERECO
-- =========================
CREATE TABLE Endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10),
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(9)
);

-- =========================
-- TABELA PACIENTE
-- =========================
CREATE TABLE Paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    data_nascimento DATE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

-- =========================
-- TABELA MEDICO
-- =========================
CREATE TABLE Medico (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    especialidade VARCHAR(50),
    telefone VARCHAR(15),
    email VARCHAR(100),
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

-- =========================
-- TABELA CONVENIO
-- =========================
CREATE TABLE Convenio (
    id_convenio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100),
    id_endereco INT,
    FOREIGN KEY (id_endereco) REFERENCES Endereco(id_endereco)
);

-- =========================
-- TABELA EXAME
-- =========================
CREATE TABLE Exame (
    id_exame INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    preco_padrao DECIMAL(10,2) NOT NULL
);

-- =========================
-- TABELA DESCONTO POR CONVENIO
-- (relação N:N entre Convenio e Exame)
-- =========================
CREATE TABLE DescontoConvenio (
    id_convenio INT,
    id_exame INT,
    percentual_desconto DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id_convenio, id_exame),
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio),
    FOREIGN KEY (id_exame) REFERENCES Exame(id_exame)
);

-- =========================
-- TABELA ATENDIMENTO
-- =========================
CREATE TABLE Atendimento (
    id_atendimento INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_convenio INT,
    data_atendimento DATETIME NOT NULL,
    observacoes TEXT,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico),
    FOREIGN KEY (id_convenio) REFERENCES Convenio(id_convenio)
);

-- =========================
-- TABELA EXAME REALIZADO
-- (Exames feitos em cada atendimento)
-- =========================
CREATE TABLE ExameRealizado (
    id_exame_realizado INT AUTO_INCREMENT PRIMARY KEY,
    id_atendimento INT NOT NULL,
    id_exame INT NOT NULL,
    valor_final DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_atendimento) REFERENCES Atendimento(id_atendimento),
    FOREIGN KEY (id_exame) REFERENCES Exame(id_exame)
);
