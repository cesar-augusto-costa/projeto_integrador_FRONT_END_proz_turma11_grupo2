-- CRIAÇÃO DE ENUM

CREATE TYPE valid_sexo_enum AS ENUM
('F', 'M');
CREATE TYPE valid_para_pets_enum AS ENUM
('Para Cães e Gatos',
           'Para Cães Adultos','Para Cães Filhotes', 'Para Cães',
           'Para Gatos Adultos', 'Para Gatos Filhotes', 'Para Gatos');
CREATE TYPE valid_tamanho_raca_prod_enum AS ENUM
(
  'Todas as Raças','Raças Grandes','Raças Pequenas'
);
CREATE TYPE valid_tamanho_raca_pet_enum AS ENUM
('Raças Grandes','Raças Pequenas');

-- CRIAÇÃO DAS ENTIDADES

CREATE TABLE login
(
  id_login BIGSERIAL,
  nome_usuario VARCHAR(100) NOT NULL,
  email VARCHAR(250) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  CONSTRAINT pk_login
  PRIMARY KEY (id_login),
  CONSTRAINT unique_email_tb_login
  UNIQUE (email)
);

CREATE TABLE representante
(
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
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE telefone
(
  id_telefone SERIAL,
  tipo_telefone VARCHAR(50),
  telefone VARCHAR(14) NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT pk_telefone
  PRIMARY KEY (id_telefone),
  CONSTRAINT fk_representante_tb_telefone
  FOREIGN KEY (id_representante)
  REFERENCES representante(id_representante)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE fornecedor
(
  id_fornecedor SMALLSERIAL,
  CNPJ CHAR(15) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT unique_CNPJ_tb_fornecedor
  UNIQUE (CNPJ),
  CONSTRAINT pk_fornecedor
  PRIMARY KEY (id_fornecedor),
  CONSTRAINT fk_representante_tb_fornecedor
  FOREIGN KEY (id_representante)
  REFERENCES representante(id_representante)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE marca
(
  id_marca SMALLSERIAL,
  marca VARCHAR(50) NOT NULL,
  CONSTRAINT pk_marca
  PRIMARY KEY (id_marca),
  CONSTRAINT unique_marca
  UNIQUE (marca)
);

CREATE TABLE produto
(
  id_produto SERIAL,
  descricao VARCHAR(50) NOT NULL,
  para_pets valid_para_pets_enum NOT NULL,
  tamanho_raca valid_tamanho_raca_prod_enum NOT NULL,
  qtd_estoque SMALLINT NOT NULL DEFAULT 0,
  preco NUMERIC(6,2) NOT NULL,
  id_marca SMALLINT NOT NULL,
  CHECK (qtd_estoque >= 0),
  CONSTRAINT pk_produto
  PRIMARY KEY (id_produto),
  CONSTRAINT fk_marca_tb_produto
  FOREIGN KEY (id_marca) REFERENCES marca(id_marca)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE venda
(
  id_fornecedor SMALLINT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_venda DATE NOT NULL,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2) NOT NULL,
  CHECK (quantidade_produto > 0),
  CONSTRAINT pk_venda
  PRIMARY KEY (id_fornecedor, id_produto, nota_fiscal),
  CONSTRAINT fk_fornecedor_tb_venda
  FOREIGN key (id_fornecedor) REFERENCES fornecedor(id_fornecedor)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  CONSTRAINT fk_produto_tb_venda
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE cliente
(
  id_cliente SERIAL,
  CPF CHAR(11) NOT NULL,
  sexo valid_sexo_enum NOT NULL,
  id_representante INT NOT NULL,
  CONSTRAINT unique_cpf_tb_cliente
  UNIQUE (CPF),
  CONSTRAINT pk_cliente
  PRIMARY KEY (id_cliente),
  CONSTRAINT fk_representante_tb_cliente
  FOREIGN KEY (id_representante) REFERENCES representante(id_representante)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE compra
(
  id_cliente INT NOT NULL,
  id_produto INT NOT NULL,
  nota_fiscal INT NOT NULL,
  data_compra DATE,
  quantidade_produto SMALLINT NOT NULL DEFAULT 1,
  valor_unitario NUMERIC(6,2),
  CHECK (quantidade_produto > 0),
  CONSTRAINT pk_compra
  PRIMARY KEY (id_cliente, id_produto, nota_fiscal),
  CONSTRAINT fk_cliente_tb_compra
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  CONSTRAINT fk_produto_tb_compra
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE depoimento
(
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
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE post_adocao
(
  id_post_adocao SERIAL,
  titulo VARCHAR(100) NOT NULL,
  foto BYTEA,
  descricao VARCHAR(255) NOT NULL,
  id_cliente INT NOT NULL,
  CONSTRAINT pk_post_adocao
  PRIMARY KEY (id_post_adocao),
  CONSTRAINT fk_cliente_tb_post_adocao
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE ong
(
  id_ong SMALLSERIAL,
  CNPJ CHAR(15) NOT NULL,
  nome VARCHAR(100) NOT NULL,
  link_logo VARCHAR(255),
  id_representante INT NOT NULL,
  CONSTRAINT unique_cnpj_tb_ong
  UNIQUE (CNPJ),
  CONSTRAINT pk_ong
  PRIMARY KEY (id_ong),
  CONSTRAINT fk_representante_tb_ong
  FOREIGN KEY (id_representante) REFERENCES representante(id_representante)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE pet
(
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
  FOREIGN KEY (id_ong) REFERENCES ong(id_ong)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  CONSTRAINT fk_cliente_tb_pet
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

CREATE TABLE post_ong
(
  id_post_ong SMALLSERIAL,
  titulo VARCHAR(50),
  foto BYTEA,
  descricao TEXT,
  id_ong SMALLINT NOT NULL,
  CONSTRAINT pk_post_ong
  PRIMARY KEY (id_post_ong),
  CONSTRAINT fk_ong_tb_post_ong
  FOREIGN KEY (id_ong) REFERENCES ong(id_ong)
  ON UPDATE CASCADE
  ON DELETE CASCADE
);

-- TRIGGER - COMPRA

-- Função Realizar Compra
CREATE OR REPLACE FUNCTION realizar_compra
()
RETURNS TRIGGER AS $$
BEGIN
  -- Atualiza a quantidade de produtos após uma compra
  UPDATE produto
  SET qtd_estoque = qtd_estoque - NEW.quantidade_produto
  WHERE id_produto = NEW.id_produto;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger para a tabela de compras
CREATE OR REPLACE TRIGGER realizar_compra_trigger
AFTER
INSERT ON
compra
FOR
EACH
ROW
EXECUTE FUNCTION realizar_compra
();

-- TRIGGER - VENDA 

-- Função Realizar Venda
CREATE OR REPLACE FUNCTION realizar_venda
()
RETURNS TRIGGER AS $$
BEGIN
  -- Atualiza a quantidade de produtos após uma venda
  UPDATE produto
  SET qtd_estoque = qtd_estoque + NEW.quantidade_produto
  WHERE id_produto = NEW.id_produto;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger para a tabela de vendas
CREATE OR REPLACE TRIGGER realizar_venda_trigger
BEFORE
INSERT ON
venda
FOR
EACH
ROW
EXECUTE FUNCTION realizar_venda
();

-- TRIGGER - COMPRA DO CLIENTE SEM PREJUIZO PARA O PETSHOP

-- Criação da função para verificar o valor da compra
CREATE OR REPLACE FUNCTION verificar_valor_compra
()
RETURNS TRIGGER AS $$
BEGIN
  -- Verifica se o valor unitário da compra é menor do que o valor unitário da venda correspondente
  IF EXISTS (
    SELECT 1
  FROM venda
  WHERE id_produto = NEW.id_produto
    AND valor_unitario > NEW.valor_unitario
  ) THEN
    RAISE EXCEPTION 'Não é permitido comprar o produto por um valor unitário menor do que o da venda.';
END
IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criação da Trigger para a tabela de compras
CREATE OR REPLACE TRIGGER verificar_valor_compra_trigger
BEFORE
INSERT ON
compra
FOR
EACH
ROW
EXECUTE FUNCTION verificar_valor_compra
();

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

insert into login (nome_usuario, email, senha) values ('Imogene Beevors', 'ibeevors0@prnewswire.com', 'bJ6+lfau~''X');
insert into login (nome_usuario, email, senha) values ('Tuck Genthner', 'tgenthner1@github.io', 'iG1/z%_268O<&2');
insert into login (nome_usuario, email, senha) values ('Craggy Jovovic', 'cjovovic2@reverbnation.com', 'kS4*$PUy4');
insert into login (nome_usuario, email, senha) values ('Waly Wheowall', 'wwheowall3@biglobe.ne.jp', 'qP0#rCN6');
insert into login (nome_usuario, email, senha) values ('Demetri Paulat', 'dpaulat4@a8.net', 'cL8)qHXAXxF\(JK');
insert into login (nome_usuario, email, senha) values ('Cymbre Neillans', 'cneillans5@ovh.net', 'rV0$fWOF');
insert into login (nome_usuario, email, senha) values ('Garvy McPolin', 'gmcpolin6@google.co.jp', 'zI2%RZX,t');
insert into login (nome_usuario, email, senha) values ('Chryste De Simoni', 'cde7@fotki.com', 'jY9{kXyP');
insert into login (nome_usuario, email, senha) values ('Phyllys Temby', 'ptemby8@google.com.au', 'uZ6=O&gracS');
insert into login (nome_usuario, email, senha) values ('Dory Escolme', 'descolme9@xing.com', 'fV5?B=PHvz|Gc2{');
insert into login (nome_usuario, email, senha) values ('Agnese Jakuszewski', 'ajakuszewskia@newyorker.com', 'dY8"JJ`g|U7u5tAC');
insert into login (nome_usuario, email, senha) values ('Lannie Loxston', 'lloxstonb@state.tx.us', 'sP6(XM7Ae');
insert into login (nome_usuario, email, senha) values ('Mal Le febre', 'mlec@ucoz.ru', 'fI6,1aJv2>N{cI');
insert into login (nome_usuario, email, senha) values ('Jackie Moffett', 'jmoffettd@mayoclinic.com', 'wK9+,x''!,!ar>');
insert into login (nome_usuario, email, senha) values ('Saunderson Zannetti', 'szannettie@diigo.com', 'kH7''&U__!4`fWZ');
insert into login (nome_usuario, email, senha) values ('Wilie Etteridge', 'wetteridgef@bigcartel.com', 'gE6{nXYp)v#=.Lp');
insert into login (nome_usuario, email, senha) values ('Karla Fenkel', 'kfenkelg@issuu.com', 'tV4?a(JNRoLsXo');
insert into login (nome_usuario, email, senha) values ('Jerrilee Kippling', 'jkipplingh@redcross.org', 'tO7)Q"5RM(C`?');
insert into login (nome_usuario, email, senha) values ('Irvine Oneil', 'ioneili@digg.com', 'eL7<#0dIf2e#s1');
insert into login (nome_usuario, email, senha) values ('Isaiah Claypool', 'iclaypoolj@usgs.gov', 'fU2{3~k/Yz9FX');

insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Paulo Ricardo da Silva', '02030110', 'Rua', 'Santa Luzia', '343', 'Casa', 'Iguatemi', 'São Paulo', 'SP', 'Brasil', 1);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('José de Freitas', '09020230', 'Rua', 'Castro Alves', '125', 'Casa', 'Osasco', 'São Paulo', 'SP', 'Brasil', 2);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Beatriz de Souza', '01456660', 'Alameda', 'Santos Dumont', '306', 'Casa', 'Santana', 'São Paulo', 'SP', 'Brasil', 3);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Viviane de Oliveira', '78925220', 'Rua', 'Das Flores', '36', 'Casa', 'Itaquera', 'São Paulo', 'SP', 'Brasil', 4);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Rogerio Assunção', '65412888', 'Avenida', 'Narciso Silva', '85', 'Apto 1', 'Moema', 'São Paulo', 'SP', 'Brasil', 5);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Osvaldo Nascimento', '84567842', 'Rua', 'Alaide Cerdá Breá', '208', 'Casa', 'Santo Amaro', 'São Paulo', 'SP', 'Brasil', 6);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Paloma Vieira', '75892666', 'Alameda', 'Rio das Pedras', '25', 'Apto 225', 'Pinheiros', 'São Paulo', 'SP', 'Brasil', 7);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Bruno Olegario', '65321145', 'Rua', 'Barão de Itapetininga', '869', 'Casa', 'Brás', 'São Paulo', 'SP', 'Brasil', 8);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Leticia da Silva', '23541689', 'Rua', 'Cambuci', '22', 'Casa', 'Perdizes', 'São Paulo', 'SP', 'Brasil', 9);
insert into representante (nome_completo, CEP, tipo_logradouro, logradouro, num, complemento, bairro, cidade, estado, pais, id_login) values ('Carlos Nascimento', '42589222', 'Rua', 'Gasometro', '98', 'Casa', 'Itaquaquecetuba', 'São Paulo', 'SP', 'Brasil', 10);

INSERT INTO telefone
  (tipo_telefone, telefone, id_representante)
VALUES
  ('Celular', '55019988776655', 1),
  ('Celular', '55019988776677', 2),
  ('Celular', '55019988776688', 3),
  ('Celular', '55019988776699', 4),
  ('Celular', '55019988776611', 5),
  ('Celular', '55019988776622', 6),
  ('Celular', '55019988776633', 7),
  ('Celular', '55019988776644', 8),
  ('Celular', '55019988776666', 9),
  ('Celular', '55019988776644', 10),
  ('Celular', '55019988776633', 1),
  ('Celular', '55019988776622', 2),
  ('Celular', '55019988776611', 3),
  ('Celular', '55019988776600', 4),
  ('Celular', '55019988776601', 5),
  ('Celular', '55019988776602', 6),
  ('Celular', '55019988776603', 7),
  ('Celular', '55019988776604', 8),
  ('Celular', '55019988776605', 9);

INSERT INTO fornecedor
  (CNPJ, nome, id_representante)
VALUES
  ('060787124000190', 'Petz', 1),
  ('986574236581258', 'Cobasi', 2),
  ('125478965823658', 'Petlove', 3);

insert into cliente (CPF, sexo, id_representante) values ('37360160412', 'F', 1);
insert into cliente (CPF, sexo, id_representante) values ('53261349314', 'F', 2);
insert into cliente (CPF, sexo, id_representante) values ('42731752714', 'M', 3);
insert into cliente (CPF, sexo, id_representante) values ('41880780114', 'M', 4);
insert into cliente (CPF, sexo, id_representante) values ('47107593911', 'F', 5);
insert into cliente (CPF, sexo, id_representante) values ('75768755412', 'F', 6);
insert into cliente (CPF, sexo, id_representante) values ('88193147710', 'F', 7);
insert into cliente (CPF, sexo, id_representante) values ('28836645316', 'F', 8);
insert into cliente (CPF, sexo, id_representante) values ('52691295017', 'F', 9);
insert into cliente (CPF, sexo, id_representante) values ('72913102012', 'M', 10);

INSERT INTO ong
  (CNPJ, nome, link_logo, id_representante)
VALUES
  ('060787001000190', 'ONG Ampara Animal', NULL, 1),
  ('060787002000190', 'ONG Cão Sem Dono', NULL, 2),
  ('060787003000190', 'ONG Focinho de Luz', NULL, 3),
  ('060787004000190', 'ONG Suipa', NULL, 4),
  ('060787005000190', 'ONG Vira Lata', NULL, 5);

INSERT INTO post_ong
  (titulo, foto, descricao, id_ong)
VALUES
  ('Evento de arrecadação', NULL, NULL, 1),
  ('A importância do lar temporário', NULL, NULL, 2),
  ('Conheça 10 alimentos tóxicos', NULL, NULL, 3),
  ('Dia do Protetor Animal', NULL, NULL, 4),
  ('Cães também ficam gripados?', NULL, NULL, 5);
  
INSERT INTO pet
  (nome, tempo_vida, tipo_pet, raca, tamanho_raca, foto, disponivel, id_ong, id_cliente)
VALUES
  ('Fiel', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Van Gogh', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Barto', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Boris', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Bebeto', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Fido', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Bolinha', '12 anos', 'Cachorro', 'Poodle', 'Raças Pequenas', NULL, TRUE, 1, 2),
  ('Whiskers', '15 anos', 'Gato', 'Siamês', 'Raças Pequenas', NULL, TRUE, 2, 3),
  ('Lucky', '8 anos', 'Cachorro', 'Labrador', 'Raças Grandes', NULL, TRUE, 3, 4),
  ('Mia', '10 anos', 'Gato', 'Persa', 'Raças Grandes', NULL, TRUE, 4, 5),
  ('Rocky', '9 anos', 'Cachorro', 'Bulldog', 'Raças Grandes', NULL, TRUE, 5, 6),
  ('Fluffy', '14 anos', 'Gato', 'Maine Coon', 'Raças Grandes', NULL, TRUE, 1, 7),
  ('Rex', '11 anos', 'Cachorro', 'Pastor Alemão', 'Raças Grandes', NULL, TRUE, 2, 8),
  ('Sasha', '13 anos', 'Gato', 'Ragdoll', 'Raças Grandes', NULL, TRUE, 3, 9),
  ('Max', '7 anos', 'Cachorro', 'Golden Retriever', 'Raças Grandes', NULL, TRUE, 4, 10),
  ('Lucy', '12 anos', 'Cachorro', 'Beagle', 'Raças Pequenas', NULL, TRUE, 5, 10),
  ('Oliver', '6 anos', 'Gato', 'British Shorthair', 'Raças Grandes', NULL, TRUE, 1, 9),
  ('Charlie', '10 anos', 'Cachorro', 'Bulldog Francês', 'Raças Pequenas', NULL, TRUE, 2, 8),
  ('Luna', '11 anos', 'Gato', 'Siamese', 'Raças Pequenas', NULL, TRUE, 3, 7),
  ('Cooper', '9 anos', 'Cachorro', 'Boxer', 'Raças Grandes', NULL, TRUE, 4, 6),
  ('Milo', '7 anos', 'Gato', 'Persian', 'Raças Grandes', NULL, TRUE, 5, 5),
  ('Daisy', '8 anos', 'Cachorro', 'Dachshund', 'Raças Pequenas', NULL, TRUE, 1, 4),
  ('Simba', '13 anos', 'Gato', 'Lion', 'Raças Grandes', NULL, TRUE, 2, 3),
  ('Bailey', '10 anos', 'Cachorro', 'Chihuahua', 'Raças Pequenas', NULL, TRUE, 3, 2),
  ('Zoe', '11 anos', 'Gato', 'Maine Coon', 'Raças Grandes', NULL, TRUE, 4, 1),
  ('Teddy', '9 anos', 'Cachorro', 'Shih Tzu', 'Raças Pequenas', NULL, TRUE, 5, 5);

INSERT INTO post_adocao
  (titulo, foto, descricao, id_cliente)
VALUES
  ('cão branco e marrom no colo da sua nova dona', NULL, 'Esse é o Téo, adotado por uma família e demonstrando sua alegria!', 1),
  ('cão caramelo no colo da sua nova dona', NULL, 'Tonico, sem "Auu..lavras" para expressar a gratidão!', 1),
  ('gato amarelo no colo da sua nova dona', NULL, 'Amarelinho também foi adotado! Depois de alguns meses na tentativa, finalmente encontramos uma dona.', 1),
  ('um gato cinza e um gato amarelo no colo da sua nova dona', NULL, 'Quem disse que irmãos não podem ser diferentes? Manu e Cleo foram adotadas e vivem como uma família.', 1),
  ('cão idoso caramelo com sua nova dona', NULL, 'Finalmente foi adotada aos 14 anos! Senhorinha, como foi carinhosamente chamada pela dona, demonstra gratidão em cada olhar.', 1),
  ('gato amarelo no colo da sua nova dona', NULL, 'A tranquilidade de Cacau em sua nova casa. Adotada recentemente e curtindo a nova vida.', 1),
  ('gato amarelo no colo da sua nova dona', NULL, 'Muito feliz na sua nova casa! Clarinha com poucas semanas de vida ganhou um novo lar.', 1),
  ('2 cachorros amarelos e 1 cachorro preto', NULL, 'Quem disse que uma familia não pode ser adotada? Mel, Lara e Perola são um exemplo disso.', 1);


INSERT INTO depoimento
  (foto, estrelas, descricao, id_cliente)
VALUES
  (NULL, 4.5, 'Ótimo produto!', 1),
  (NULL, 4.5, 'Ótimo produto!', 1),
  (NULL, 5.0, 'Excelente serviço!', 2),
  (NULL, 4.0, 'Satisfeito!', 3),
  (NULL, 4.0, 'Bom atendimento.', 4),
  (NULL, 5.0, 'Recomendo a todos!', 5),
  (NULL, 4.0, 'Produto de qualidade.', 1),
  (NULL, 5.0, 'Entrega rápida.', 2),
  (NULL, 3.5, 'Poderia melhorar.', 3),
  (NULL, 4.0, 'Bom custo-benefício.', 4),
  (NULL, 4.5, 'Atendimento excelente.', 5);
  
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
  (descricao, para_pets, tamanho_raca, qtd_estoque, preco, id_marca)
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
  ('Brinquedo Bolas Catnip', 'Para Gatos', 'Todas as Raças', 0, 29.99, 13);
  
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 13, 1, '2023-10-15', 9, 144.42);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 12, 2, '2023-10-17', 2, 20.72);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 8, 3, '2023-10-10', 2, 4.19);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 4, 2, '2023-10-15', 1, 197.16);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 16, 4, '2023-10-14', 5, 100.26);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 15, 4, '2023-10-11', 6, 67.58);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 12, 3, '2023-10-13', 9, 96.09);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 14, 1, '2023-10-09', 9, 111.13);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 15, 2, '2023-10-11', 8, 24.75);
insert into venda (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario) values (1, 6, 2, '2023-10-06', 1, 129.02);


insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 15, 2, '2023-10-09', 1, 110.07);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 13, 3, '2023-10-14', 2, 199.99);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 13, 4, '2023-10-13', 1, 299.99);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 12, 4, '2023-10-11', 1, 101.9);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 6, 1, '2023-10-17', 1, 150.00);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 8, 4, '2023-10-06', 2, 59.99);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 4, 2, '2023-10-17', 1, 299.99);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 16, 1, '2023-10-08', 1, 399.99);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 16, 2, '2023-10-17', 1, 166.55);
insert into compra (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario) values (1, 15, 4, '2023-10-08', 1, 159.99);

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

-- CONSULTAS SIMPLES

-- Listar todos os clientes do sexo feminino (gênero 'F'):
SELECT *
FROM cliente
WHERE sexo = 'F';

-- Listar todos os produtos com um preço superior a R$ 50,00:
SELECT descricao, preco
FROM produto
WHERE preco > 50.00;

-- Listar todos os produtos para cães adultos com estoque maior que 4 unidades:
SELECT descricao, para_pets, qtd_estoque
FROM produto
WHERE para_pets = 'Para Cães Adultos' AND qtd_estoque > 4;

-- Listar todos os representantes que não estão localizados no Brasil:
SELECT nome_completo, pais
FROM representante
WHERE pais <> 'Brasil';

-- Listar todas as marcas de produtos que têm a palavra 'Pet' em seu nome:
SELECT marca
FROM marca
WHERE marca LIKE '%Pet%';

-- Listar todos os representantes que têm um CEP definido:
SELECT nome_completo
FROM representante
WHERE CEP IS NOT NULL;

-- Listar todos os produtos disponíveis para gatos:
SELECT *
FROM produto
WHERE para_pets::VARCHAR LIKE 'Para Gatos%';

SELECT *
FROM produto
WHERE para_pets = 'Para Gatos';

-- Listar todos os representantes que estão localizados em São Paulo (estado 'SP'):
SELECT nome_completo, cidade, estado
FROM representante
WHERE estado = 'SP';

-- Listar todos os depoimentos com 5 estrelas:
SELECT estrelas, descricao
FROM depoimento
WHERE estrelas = 5.0;

-- Listar todas as compras feitas em setembro de 2023:
SELECT nota_fiscal, data_compra
FROM compra
WHERE EXTRACT(YEAR FROM data_compra) = 2023 AND EXTRACT(MONTH FROM data_compra) = 9;

-- Listar todos os pets disponíveis para adoção:
SELECT nome, tipo_pet, disponivel
FROM pet
WHERE disponivel = TRUE;

-- Listar todos os produtos com estoque zerado:
SELECT descricao, qtd_estoque
FROM produto
WHERE qtd_estoque = 0;

-- Listar todos os produtos com uma descrição que contenha a palavra 'Ração':
SELECT descricao
FROM produto
WHERE descricao LIKE '%Ração%';

-- Listar os produtos em estoque com quantidade maior que zero:
SELECT descricao, qtd_estoque
FROM produto
WHERE qtd_estoque > 0;

-- Listar os produtos em estoque com quantidade maior que zero dando um apelido para a tabela:
SELECT p.descricao, p.qtd_estoque
FROM produto p
WHERE p.qtd_estoque > 0;

-- CONSULTAS ORDENADAS

-- Listar todas as marcas de produtos em ordem alfabética:
SELECT marca
FROM marca
ORDER BY marca;

-- Mostrar o valor total da nota:
SELECT nota_fiscal, SUM(quantidade_produto * valor_unitario) AS total_da_nota
FROM compra
WHERE nota_fiscal = 1000
GROUP BY nota_fiscal;

-- CONSULTAS COM SUBCONSULTAS

-- Listar todos os clientes que não têm um pet associado a eles:
SELECT nome_completo
FROM cliente
WHERE id_cliente NOT IN (SELECT DISTINCT id_cliente
FROM pet);

-- Listar todas as compras feitas por um fornecedor específico (por CNPJ):
SELECT nota_fiscal, data_compra
FROM compra
WHERE id_fornecedor = (SELECT id_fornecedor
FROM fornecedor
WHERE CNPJ = '060787124000190');

-- CONSULTAS COM JOIN

-- Listar todos os clientes que adotaram pelo menos um pet:
SELECT DISTINCT c.nome_completo
FROM cliente c
  JOIN pet p ON c.id_cliente = p.id_cliente;

-- Listar todos os representantes e seus respectivos telefones:
SELECT r.nome_completo, t.telefone
FROM representante r
  JOIN telefone t ON r.id_representante = t.id_representante;

-- Listar todos os produtos de uma marca específica:
SELECT p.descricao, p.para_pets, p.preco
FROM produto p
  JOIN marca m ON p.id_marca = m.id_marca
WHERE m.marca = 'Golden Mega';

-- Listar todos os depoimentos de um cliente:
SELECT d.estrelas, d.descricao
FROM depoimento d
  JOIN cliente c ON d.id_cliente = c.id_cliente
WHERE c.CPF = '12345678901';

-- Listar todas as compras feitas por um fornecedor específico:
SELECT c.nota_fiscal, c.data_compra, p.descricao, c.quantidade_produto, c.valor_unitario
FROM compra c
  JOIN produto p ON c.id_produto = p.id_produto
WHERE c.id_fornecedor = 1;

-- Listar todas as vendas feitas para um cliente específico:
SELECT v.nota_fiscal, v.data_venda, p.descricao, v.quantidade_produto, v.valor_unitario
FROM venda v
  JOIN produto p ON v.id_produto = p.id_produto
WHERE v.id_cliente = 1;

-- CONSULTAS COM GROUP BY E HAVING

-- Listar todas as marcas de produtos e a quantidade de produtos de cada marca:
SELECT m.marca, COUNT(p.id_produto) AS quantidade_de_produtos
FROM marca m
JOIN produto p ON m.id_marca = p.id_marca
GROUP BY m.marca
ORDER BY quantidade_de_produtos DESC;

-- Listar todas as marcas de produtos que têm pelo menos 3 produtos:
SELECT m.marca, COUNT(p.id_produto) AS quantidade_de_produtos
FROM marca m
JOIN produto p ON m.id_marca = p.id_marca
GROUP BY m.marca
HAVING COUNT(p.id_produto) >= 3
ORDER BY quantidade_de_produtos DESC;

-- Listar todos os clientes que adotaram pelo menos 2 pets:
SELECT c.nome_completo, COUNT(p.id_pet) AS quantidade_de_pets_adotados
FROM cliente c
JOIN pet p ON c.id_cliente = p.id_cliente
GROUP BY c.nome_completo
HAVING COUNT(p.id_pet) >= 2
ORDER BY quantidade_de_pets_adotados DESC;

-- Listar todas as compras feitas em que o valor total da nota seja superior a R$ 100,00:
SELECT nota_fiscal, SUM(quantidade_produto * valor_unitario) AS total_da_nota
FROM compra
GROUP BY nota_fiscal
HAVING SUM(quantidade_produto * valor_unitario) > 100.00
ORDER BY total_da_nota;

-- CONSULTAS COM JOINS E SUBCONSULTAS

-- Listar todos os produtos comprados por um cliente específico (por CPF):
SELECT p.descricao, c.CPF
FROM compra co
JOIN cliente c ON co.id_cliente = c.id_cliente
JOIN produto p ON co.id_produto = p.id_produto
WHERE c.CPF = '12345678901';

-- Listar todos os depoimentos de clientes que adotaram pelo menos um pet:
SELECT d.estrelas, d.descricao
FROM depoimento d
JOIN cliente c ON d.id_cliente = c.id_cliente
WHERE c.id_cliente IN (SELECT DISTINCT id_cliente
FROM pet);

-- Listar todos os pets adotados por um cliente específico (por CPF):
SELECT p.nome, c.CPF
FROM pet p
JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE c.CPF = '12345678901';

-- Listar todos os produtos comprados por clientes que adotaram pets do tipo 'Cachorro':
SELECT DISTINCT p.descricao
FROM compra co
JOIN cliente c ON co.id_cliente = c.id_cliente
JOIN pet p ON c.id_cliente = p.id_cliente
WHERE p.tipo_pet = 'Cachorro';

-- CONSULTAS COM MAIS DE UMA TABELA RELACIONADA

-- Listar todos os representantes e seus telefones de contato, juntamente com os nomes das marcas de produtos que eles representam:
SELECT r.nome_completo, t.telefone, m.marca
FROM representante r
JOIN telefone t ON r.id_representante = t.id_representante
JOIN fornecedor f ON r.id_representante = f.id_representante
JOIN marca m ON f.id_fornecedor = m.id_fornecedor;

-- Listar todos os pets disponíveis para adoção juntamente com os nomes dos clientes que os adotaram:
SELECT p.nome, c.nome_completo AS nome_do_adotante
FROM pet p
LEFT JOIN cliente c ON p.id_cliente = c.id_cliente
WHERE p.disponivel = TRUE;

-- Listar todos os depoimentos de clientes que adotaram pets, juntamente com os nomes dos pets adotados:
SELECT d.descricao, p.nome AS nome_do_pet
FROM depoimento d
JOIN cliente c ON d.id_cliente = c.id_cliente
JOIN pet p ON c.id_cliente = p.id_cliente;

-- Listar todos os produtos comprados por clientes que adotaram pets, juntamente com os nomes dos pets adotados:
SELECT p.descricao, co.nota_fiscal, co.id_cliente, c.CPF, pet.nome AS nome_do_pet
FROM compra co
JOIN cliente c ON co.id_cliente = c.id_cliente
JOIN pet ON c.id_cliente = pet.id_cliente
JOIN produto p ON co.id_produto = p.id_produto;

-- CONSULTAS COM OPERAÇÕES DE DATA

-- Listar todas as compras feitas em setembro de 2023:
SELECT nota_fiscal, data_compra
FROM compra
WHERE EXTRACT(YEAR FROM data_compra) = 2023 AND EXTRACT(MONTH FROM data_compra) = 9;

-- Listar todos os pets disponíveis para adoção que foram cadastrados no ano de 2023:
SELECT nome, data_cadastro
FROM pet
WHERE EXTRACT

-- CONSULTAS AVANÇADAS

-- Seleciona o ID do pedido e o nome do cliente
SELECT orders.order_id, customers.customer_name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.order_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Seleciona o nome e preço do produto com o preço máximo
SELECT product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- Seleciona o departamento e o salário médio, filtrando departamentos com salário médio > $50.000
SELECT department, AVG(salary) as avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;

-- Seleciona o ID do funcionário, o nome do funcionário e o nome do departamento (se disponível)
SELECT employees.employee_id, employees.employee_name, departments.department_name
FROM employees
LEFT JOIN departments ON employees.department_id = departments.department_id;

-- Seleciona o nome e preço do produto, classificando por preço em ordem decrescente
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- Seleciona o nome do cliente e o número de telefone (se não for nulo)
SELECT customer_name, phone_number
FROM customers
WHERE phone_number IS NULL;

-- Seleciona o nome completo (primeiro nome + sobrenome) e o e-mail em maiúsculas
SELECT CONCAT(first_name, ' ', last_name) as full_name, UPPER(email) as upper_email
FROM users;

-- Seleciona o ID do pedido, a quantidade e um rótulo com base na quantidade
SELECT order_id, quantity,
       CASE
           WHEN quantity > 10 THEN 'Muitos'
           WHEN quantity > 5 THEN 'Alguns'
           ELSE 'Poucos'
       END as quantity_label
FROM order_details;

-- TRINAMENTO

-- Consultas Simples:

-- Listar todos os clientes do sexo feminino (gênero 'F').
-- Listar todos os produtos com um preço superior a R$ 50,00.
-- Listar todos os produtos para cães adultos com estoque maior que 10 unidades.
-- Listar todos os representantes que não estão localizados no Brasil.
-- Listar todas as marcas de produtos que têm a palavra 'Pet' em seu nome.
-- Listar todos os representantes que têm um CEP definido.
-- Listar todos os produtos disponíveis para gatos.
-- Listar todos os representantes que estão localizados em São Paulo (estado 'SP').
-- Listar todos os depoimentos com 5 estrelas.
-- Listar todas as compras feitas em setembro de 2023.
-- Listar todos os pets disponíveis para adoção.
-- Listar todos os produtos com estoque zerado.
-- Listar todos os produtos com uma descrição que contenha a palavra 'Ração'.
-- Listar os produtos em estoque com quantidade maior que zero.
-- Listar os produtos em estoque com quantidade maior que zero dando um apelido para a tabela.
-- Consultas Ordenadas:

-- Listar todas as marcas de produtos em ordem alfabética.
-- Mostrar o valor total da nota.
-- Consultas com Subconsultas:

-- Listar todos os clientes que não têm um pet associado a eles.
-- Listar todas as compras feitas por um fornecedor específico (por CNPJ).
-- Consultas com JOIN:

-- Listar todos os clientes que adotaram pelo menos um pet.
-- Listar todos os representantes e seus respectivos telefones.
-- Listar todos os produtos de uma marca específica.
-- Listar todos os depoimentos de um cliente.
-- Listar todas as compras feitas por um fornecedor específico.
-- Listar todas as vendas feitas para um cliente específico.
-- Consultas com GROUP BY e HAVING:

-- Listar todas as marcas de produtos e a quantidade de produtos de cada marca.
-- Listar todas as marcas de produtos que têm pelo menos 3 produtos.
-- Listar todos os clientes que adotaram pelo menos 2 pets.
-- Listar todas as compras feitas em que o valor total da nota seja superior a R$ 100,00.
-- Consultas com Joins e Subconsultas:

-- Listar todos os produtos comprados por um cliente específico (por CPF).
-- Listar todos os depoimentos de clientes que adotaram pelo menos um pet.
-- Listar todos os pets adotados por um cliente específico (por CPF).
-- Listar todos os produtos comprados por clientes que adotaram pets do tipo 'Cachorro'.
-- Consultas com Mais de Uma Tabela Relacionada:

-- Listar todos os representantes e seus telefones de contato, juntamente com os nomes das marcas de produtos que eles representam.
-- Listar todos os pets disponíveis para adoção juntamente com os nomes dos clientes que os adotaram.
-- Listar todos os depoimentos de clientes que adotaram pets, juntamente com os nomes dos pets adotados.
-- Listar todos os produtos comprados por clientes que adotaram pets, juntamente com os nomes dos pets adotados.
-- Consultas com Operações de Data:

-- Listar todas as compras feitas em setembro de 2023.
-- Listar todos os pets disponíveis para adoção que foram cadastrados no ano de 2023.
-- Consultas Avançadas:

-- Selecionar o ID do pedido e o nome do cliente.
-- Selecionar o nome e preço do produto com o preço máximo.
-- Selecionar o departamento e o salário médio, filtrando departamentos com salário médio > $50.000.
-- Selecionar o ID do funcionário, o nome do funcionário e o nome do departamento (se disponível).
-- Selecionar o nome e preço do produto, classificando por preço em ordem decrescente.
-- Selecionar o nome do cliente e o número de telefone (se não for nulo).
-- Selecionar o nome completo (primeiro nome + sobrenome) e o e-mail em maiúsculas.
-- Selecionar o ID do pedido, a quantidade e um rótulo com base na quantidade.