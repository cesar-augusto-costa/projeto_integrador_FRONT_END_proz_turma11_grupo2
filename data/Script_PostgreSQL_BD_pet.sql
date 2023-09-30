-- CRIAÇÃO DE ENUM

CREATE TYPE valid_sexo_enum AS ENUM ('F', 'M');
CREATE TYPE valid_para_pets_enum AS ENUM('Para Cães e Gatos',
           'Para Cães Adultos','Para Cães Filhotes', 'Para Cães',
           'Para Gatos Adultos', 'Para Gatos Filhotes', 'Para Gatos');
CREATE TYPE valid_tamanho_raca_prod_enum AS ENUM(
  'Todas as Raças','Raças Grandes','Raças Pequenas'
);
CREATE TYPE valid_tamanho_raca_pet_enum AS ENUM('Raças Grandes','Raças Pequenas');

-- CRIAÇÃO DAS ENTIDADES

CREATE TABLE login (
  id_login BIGSERIAL,
  nome_usuario VARCHAR(100) NOT NULL,
  email VARCHAR(250) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  CONSTRAINT pk_login
  PRIMARY KEY (id_login),
  CONSTRAINT unique_email_tb_login
  UNIQUE (email)
);

CREATE TABLE representante (
  id_representante SERIAL,
  nome_completo VARCHAR(150) NOT NULL,
  CEP CHAR(8),
  tipo_logradouro VARCHAR(20),
  logradouro VARCHAR(100),
  num VARCHAR(8),
  complemento VARCHAR(100),
  bairro VARCHAR(50),
  cidade VARCHAR(50) NOT NULL,
  estado CHAR(2) NOT NULL,
  pais VARCHAR(50) NOT NULL,
  id_login BIGINT NOT NULL,
  CONSTRAINT pk_representante
  PRIMARY KEY (id_representante),
  CONSTRAINT fk_login_tb_representante 
  FOREIGN KEY (id_login) REFERENCES login(id_login)
);

CREATE TABLE telefone (
  id_telefone SERIAL, 
  tipo_telefone VARCHAR(50),
  telefone VARCHAR(14) NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT pk_telefone
  PRIMARY KEY (id_telefone),
  CONSTRAINT fk_representante_tb_telefone
  FOREIGN KEY (id_representante)
  REFERENCES representante(id_representante)
);

CREATE TABLE fornecedor (
  id_fornecedor SMALLSERIAL,
  CNPJ CHAR(15) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT pk_fornecedor
  PRIMARY KEY (id_fornecedor),
  CONSTRAINT fk_representante_tb_fornecedor
  FOREIGN KEY (id_representante)
  REFERENCES representante(id_representante),
  CONSTRAINT unique_CNPJ_tb_fornecedor
  UNIQUE (CNPJ)
);

CREATE TABLE marca (
  id_marca SMALLSERIAL, 
  marca VARCHAR(50) NOT NULL,
  CONSTRAINT pk_marca
  PRIMARY KEY (id_marca),
  CONSTRAINT unique_marca
  UNIQUE (marca)
);

CREATE TABLE produto (
  id_produto SERIAL,
  descricao VARCHAR(50) NOT NULL,
  para_pets valid_para_pets_enum NOT NULL,
  tamanho_raca valid_tamanho_raca_prod_enum NOT NULL,
  quantidade SMALLINT NOT NULL DEFAULT 0,
  preco NUMERIC(6,2) NOT NULL,
  id_marca SMALLINT NOT NULL,
  CHECK (quantidade >= 0), 
  CONSTRAINT pk_produto
  PRIMARY KEY (id_produto),
  CONSTRAINT fk_marca_tb_produto
  FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE compra (
  id_fornecedor SMALLINT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_compra DATE NOT NULL,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2) NOT NULL,
  CHECK (quantidade_produto > 0), 
  CONSTRAINT pk_compra
  PRIMARY KEY (id_fornecedor, id_produto, nota_fiscal),
  CONSTRAINT fk_fornecedor_tb_compra
  FOREIGN key (id_fornecedor) REFERENCES fornecedor(id_fornecedor),
  CONSTRAINT fk_produto_tb_compra
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE cliente (
  id_cliente SERIAL,
  CPF CHAR(11) NOT NULL,
  sexo valid_sexo_enum NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT pk_cliente
  PRIMARY KEY (id_cliente),
  CONSTRAINT fk_representante_tb_cliente
  FOREIGN KEY (id_representante) REFERENCES representante(id_representante),
  CONSTRAINT unique_cpf_tb_cliente
  UNIQUE (CPF)
);

CREATE TABLE venda (
  id_cliente INT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_venda DATE,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2),
  CHECK (quantidade_produto > 0),
  CONSTRAINT pk_venda
  PRIMARY KEY (id_cliente, id_produto, nota_fiscal),
  CONSTRAINT fk_cliente_tb_venda
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  CONSTRAINT fk_produto_tb_venda
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
);

CREATE TABLE depoimento (
  id_depoimento SERIAL,
  foto BYTEA,
  estrelas REAL NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  id_cliente INT NOT NULL,
  CHECK (estrelas >= 0.00 AND estrelas <= 5.00 AND ((estrelas::numeric % 1 = 0.00) OR (estrelas::numeric % 1 = 0.50))),
  CONSTRAINT pk_depoimento
  PRIMARY KEY (id_depoimento),
  CONSTRAINT fk_cliente_tb_depoimento
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE post_adocao (
  id_post_adocao SERIAL,
  titulo VARCHAR(50) NOT NULL,
  foto BYTEA,
  descricao VARCHAR(255) NOT NULL,
  id_cliente INT NOT NULL,
  CONSTRAINT pk_post_adocao
  PRIMARY KEY (id_post_adocao),
  CONSTRAINT fk_cliente_tb_post_adocao
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE ong (
  id_ong SMALLSERIAL,
  CNPJ CHAR(15) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  link_logo VARCHAR(255),
  id_representante INT NOT NULL,
  CONSTRAINT pk_ong
  PRIMARY KEY (id_ong),
  CONSTRAINT fk_representante_tb_ong
  FOREIGN KEY (id_representante) REFERENCES representante(id_representante),
  CONSTRAINT unique_cnpj_tb_ong
  UNIQUE (CNPJ)
);

CREATE TABLE pet (
  id_pet SERIAL,
  nome VARCHAR(100) NOT NULL, 
  tempo_vida VARCHAR(50),
  tipo_pet VARCHAR(20) NOT NULL,
  raca VARCHAR(20),
  tamanho_raca valid_tamanho_raca_pet_enum,
  foto BYTEA,
  disponivel BOOLEAN NOT NULL,
  id_ong SMALLINT,
  id_cliente INT,
  CONSTRAINT pk_pet
  PRIMARY KEY (id_pet),
  CONSTRAINT fk_ong_tb_pet
  FOREIGN KEY (id_ong) REFERENCES ong(id_ong),
  CONSTRAINT fk_cliente_tb_pet
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE post_ong (
  id_post_ong SMALLSERIAL,
  titulo VARCHAR(50),
  foto BYTEA,
  descricao TEXT,
  id_ong SMALLINT NOT NULL,
  CONSTRAINT pk_post_ong
  PRIMARY KEY (id_post_ong),
  CONSTRAINT fk_ong_tb_post_ong
  FOREIGN KEY (id_ong) REFERENCES ong(id_ong)
);

-- CRIAÇÃO DA TRIGGER - COMPRA

CREATE OR REPLACE FUNCTION realizar_compra()
RETURNS TRIGGER AS $$
BEGIN
  -- Atualiza a quantidade de produtos após uma compra
  UPDATE produto
  SET quantidade = quantidade + NEW.quantidade_produto
  WHERE id_produto = NEW.id_produto;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger para a tabela de compras
CREATE TRIGGER realizar_compra_trigger
AFTER INSERT ON compra
FOR EACH ROW
EXECUTE FUNCTION realizar_compra();

-- CRIAÇÃO DA TRIGGER - VENDA

CREATE OR REPLACE FUNCTION realizar_venda()
RETURNS TRIGGER AS $$
BEGIN
  -- Atualiza a quantidade de produtos após uma venda
  UPDATE produto
  SET quantidade = quantidade - NEW.quantidade_produto
  WHERE id_produto = NEW.id_produto;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger para a tabela de vendas
CREATE TRIGGER realizar_venda_trigger
BEFORE INSERT ON venda
FOR EACH ROW
EXECUTE FUNCTION realizar_venda();

-- EXCLUIR TABELAS

DROP TABLE telefone;
DROP TABLE depoimento;
DROP TABLE post_adocao;
DROP TABLE post_ong;

DROP TABLE compra;
DROP TABLE venda;
DROP TABLE produto;
DROP TABLE marca;

DROP TABLE fornecedor;

DROP TABLE pet;
DROP TABLE cliente;
DROP TABLE ong;

DROP TABLE representante;
DROP TABLE login;

-- INSERIR DADOS

INSERT INTO login
(nome_usuario, email, senha)
VALUES
('Cesinha', 'cesar@email.com', 'senh@2023');

INSERT INTO representante
(nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login)
VALUES
('Representante 1', '13058434', 'Rua', 'Exemplo', '123', 'Apto 1', 'Bairro 1', 'Cidade 1', 'UF', 'Brasil', 1);

INSERT INTO telefone
(tipo_telefone, telefone, id_representante)
VALUES
('Celular', '55019988776655', 1),
('Celular', '55019988776677', 1),
('Celular', '55019988776688', 1),
('Celular', '55019988776699', 1),
('Celular', '55019988776611', 1),
('Celular', '55019988776622', 1),
('Celular', '55019988776633', 1),
('Celular', '55019988776644', 1),
('Celular', '55019988776666', 1),
('Celular', '55019988776644', 1),
('Celular', '55019988776633', 1),
('Celular', '55019988776622', 1),
('Celular', '55019988776611', 1),
('Celular', '55019988776600', 1),
('Celular', '55019988776601', 1),
('Celular', '55019988776602', 1),
('Celular', '55019988776603', 1),
('Celular', '55019988776604', 1),
('Celular', '55019988776605', 1);

INSERT INTO fornecedor
(CNPJ, nome, id_representante)
VALUES
('060787124000190', 'Petz', 1);


INSERT INTO cliente
(CPF, sexo, id_representante)
VALUES
('12345678901', 'F', 1);

INSERT INTO ong
(CNPJ, nome, link_logo, id_representante)
VALUES
('98765432109876', 'ONG Animal', 'https://onganimal.org/logo.jpg', 1);

INSERT INTO post_ong
(titulo, foto, descricao, id_ong)
VALUES
('Evento de arrecadação', NULL, 'Participe do nosso evento de arrecadação de fundos!', 1);

INSERT INTO pet
(nome, tempo_vida, tipo_pet, raca, tamanho_raca, foto, disponivel, id_ong, id_cliente)
VALUES
('Fido', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, TRUE, 1, 1);

INSERT INTO post_adocao
(titulo, foto, descricao, id_cliente)
VALUES
('Adoção de um gatinho', NULL, 'Estamos procurando um lar para um gatinho adorável!', 1);

INSERT INTO depoimento
(foto, estrelas, descricao, id_cliente)
VALUES
(NULL, 4.5, 'Ótimo produto!', 1);

INSERT INTO marca
(marca)
VALUES
('Golden Mega'),
('Golden Fórmula'),
('Premier Cookie'),
('KelDog Mini'),
('Líder Pet'),
('Pet Games'),
('Napi'),
('GranPlus'),
('Royal Canin'),
('Dreamies'),
('Snack Kelcat'),
('Pet Hello Kitty'),
('Chalesco');

INSERT INTO produto
(descricao, para_pets, tamanho_raca, quantidade, preco, id_marca)
VALUES
('Ração 15 Kg', 'Para Cães Adultos', 'Raças Grandes', 0, 169.90, 1),
('Ração 15 Kg', 'Para Cães Filhotes', 'Raças Grandes', 0, 179.90, 1),
('Ração 15 Kg', 'Para Cães Adultos', 'Raças Pequenas', 0, 169.99, 2),
('Ração 10,1 Kg', 'Para Cães Filhotes', 'Raças Pequenas', 0, 136.90, 2),
('Biscoito 250 g', 'Para Cães Filhotes', 'Todas as Raças', 0, 16.40, 3),
('Biscoito 250 g', 'Para Cães Adultos', 'Raças Pequenas', 0, 16.99, 3),
('Bifinho 500 g', 'Para Cães Adultos', 'Todas as Raças', 0, 25.41, 4),
('Brinquedo Bola Cravo', 'Para Cães', 'Todas as Raças', 0, 12.99, 5),
('Brinquedo Interativo Petball', 'Para Cães', 'Todas as Raças', 0, 37.99, 6),
('Brinquedo Mordedor Galinha', 'Para Cães', 'Todas as Raças', 0, 19.99, 7),
('Ração 10,1 Kg', 'Para Gatos Adultos', 'Todas as Raças', 0, 147.99, 8),
('Ração 1,5 Kg', 'Para Gatos Filhotes', 'Todas as Raças', 0, 112.19, 9),
('Petisco', 'Para Gatos Adultos', 'Todas as Raças', 0, 19.99, 10),
('Bifitos 30 g', 'Para Gatos', 'Todas as Raças', 0, 5.52, 11),
('Leite 220 ml', 'Para Gatos', 'Todas as Raças', 0, 12.99, 12),
('Brinquedo Ratinhos', 'Para Gatos', 'Todas as Raças', 0, 16.99, 13),
('Brinquedo Bolas Catnip', 'Para Gatos', 'Todas as Raças', 0, 29.99, 13),
('Brinquedo Bolas Catnip', 'Para Gatos', 'Todas as Raças', 0, 29.99, 13);

INSERT INTO compra
(id_fornecedor, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario)
VALUES
(1, 1, 1002, '2023-09-28', 5, 10.50);

INSERT INTO venda
(id_cliente, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario)
VALUES
(1, 1, 2001, '2023-09-29', 3, 15.75),
(1, 1, 2002, '2023-09-29', 3, 15.75);

-- CONSULTAS

-- Mostrar todas as tabelas
SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public';

-- Mostrar quantas tabelas tem
SELECT COUNT(tablename)
FROM pg_catalog.pg_tables
WHERE schemaname = 'public'; 

-- Selecionar cada tabela
SELECT * FROM login;
SELECT * FROM representante;
SELECT * FROM telefone;
SELECT * FROM fornecedor;
SELECT * FROM cliente;
SELECT * FROM ong;
SELECT * FROM post_ong;
SELECT * FROM pet;
SELECT * FROM post_adocao;
SELECT * FROM depoimento;
SELECT * FROM marca;
SELECT * FROM produto;
SELECT * FROM compra;
SELECT * FROM venda;
