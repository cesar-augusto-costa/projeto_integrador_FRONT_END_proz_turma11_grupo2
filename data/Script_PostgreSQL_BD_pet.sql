-- CRIAÇÃO DE ENUM
CREATE TYPE valid_sexo_enum AS ENUM ('F', 'M');

-- CRIAÇÃO DAS ENTIDADES

CREATE TABLE login (
  id_login BIGSERIAL,
  nome_usuario VARCHAR(100) NOT NULL,
  email VARCHAR(250) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  CONSTRAINT pk_login
  PRIMARY key (id_login),
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
  cidade VARCHAR(50),
  estado CHAR(2),
  pais VARCHAR(50),
  id_login INT NOT NULL,
  CONSTRAINT pk_representante
  PRIMARY KEY (id_representante),
  CONSTRAINT fk_login_tb_representante 
  FOREIGN KEY (id_login) REFERENCES login(id_login)
);

create table telefone (
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
  id_representante INT,
  CONSTRAINT pk_fornecedor
  PRIMARY KEY (id_fornecedor),
  CONSTRAINT fk_representante_tb_fornecedor
  foreign KEY (id_representante)
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
  para_pets VARCHAR(50) NOT NULL,
  tamanho_raca VARCHAR(20) NOT NULL,
  quantidade INT NOT NULL,
  id_marca INT,
  CONSTRAINT pk_produto
  PRIMARY key (id_produto),
  CONSTRAINT fk_marca_tb_produto
  foreign key (id_marca) REFERENCES marca(id_marca)
);

CREATE TABLE compra (
  id_fornecedor INT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_compra DATE,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2),
  CONSTRAINT pk_compra
  PRIMARY KEY (id_fornecedor, id_produto, nota_fiscal),
  CONSTRAINT fk_fornecedor_tb_compra
  FOREIGN key (id_fornecedor) references fornecedor(id_fornecedor),
  constraint fk_produto_tb_compra
  foreign KEY (id_produto) references produto(id_produto)
);

CREATE TABLE cliente (
  id_cliente SERIAL,
  CPF CHAR(11) NOT NULL,
  sexo valid_sexo_enum,
  id_representante INT NOT NULL,
  CONSTRAINT pk_cliente
  primary key (id_cliente),
  constraint fk_representante_tb_cliente
  foreign key (id_representante) references representante(id_representante),
  CONSTRAINT unique_cpf_tb_cliente
  unique (CPF)
);

CREATE TABLE venda (
  id_cliente INT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_venda DATE,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2),
  CONSTRAINT pk_venda
  PRIMARY KEY (id_cliente, id_produto, nota_fiscal),
  CONSTRAINT fk_cliente_tb_venda
  FOREIGN key (id_cliente) references cliente(id_cliente),
  constraint fk_produto_tb_venda
  foreign KEY (id_produto) references produto(id_produto)
);

CREATE TABLE depoimento (
  id_depoimento SERIAL,
  foto BYTEA,
  estrelas REAL not NULL,
  descricao VARCHAR(255) not NULL,
  id_cliente INT not NULL,
  CHECK (estrelas >= 0.00 AND estrelas <= 5.00 AND ((estrelas::numeric % 1 = 0.00) OR (estrelas::numeric % 1 = 0.50))),
  CONSTRAINT pk_depoimento
  PRIMARY key (id_depoimento),
  CONSTRAINT fk_cliente_tb_depoimento
  foreign key (id_cliente) references cliente(id_cliente)
);

CREATE TABLE post_adocao (
  id_post_adocao SERIAL,
  titulo VARCHAR(50) NOT NULL,
  foto BYTEA,
  descricao VARCHAR(255) NOT NULL,
  id_cliente INT NOT NULL,
  CONSTRAINT pk_post_adocao
  primary key (id_post_adocao),
  CONSTRAINT fk_cliente_tb_post_adocao
  foreign key (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE ong (
  id_ong SMALLSERIAL,
  CNPJ CHAR(15) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  link_logo VARCHAR(255),
  id_representante INT NOT NULL,
  CONSTRAINT pk_ong
  primary KEY (id_ong),
  CONSTRAINT fk_representante_tb_ong
  foreign key (id_representante) REFERENCES representante(id_representante),
  CONSTRAINT unique_cnpj_tb_ong
  unique (CNPJ)
);

CREATE TABLE pet (
  id_pet SERIAL,
  nome VARCHAR(100) NOT NULL, 
  tempo_vida VARCHAR(50),
  tipo_pet VARCHAR(20) NOT NULL,
  raca VARCHAR(20),
  tamanho_raca VARCHAR(20),
  foto BYTEA,
  disponivel BOOLEAN NOT NULL,
  id_ong INT,
  constraint pk_pet
  PRIMARY key (id_pet),
  CONSTRAINT fk_ong_tb_pet
  foreign key (id_ong) REFERENCES ong(id_ong)
);

create table post_ong (
  id_post_ong SMALLSERIAL,
  titulo VARCHAR(50),
  foto BYTEA,
  descricao TEXT,
  id_ong INT NOT NULL,
  CONSTRAINT pk_post_ong
  PRIMARY key (id_post_ong),
  CONSTRAINT fk_ong_tb_post_ong
  FOREign key (id_ong) REFERENCES ong(id_ong)
);


-- EXCLUIR TABELAS
DROP TABLE telefone;
DROP TABLE representante;
DROP TABLE login;
DROP TABLE fornecedor;

DROP TABLE marca;
DROP TABLE produto;

DROP TABLE compra;


