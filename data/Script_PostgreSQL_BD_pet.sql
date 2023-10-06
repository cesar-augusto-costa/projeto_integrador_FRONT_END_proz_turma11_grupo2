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
  titulo VARCHAR(50) NOT NULL,
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
  ('060787001000190', 'ONG Ampara Animal', NULL, 1),
  ('060787002000190', 'ONG Cão Sem Dono', NULL, 2),
  ('060787003000190', 'ONG Focinho de Luz', NULL, 3),
  ('060787004000190', 'ONG Suipa', NULL, 4),
  ('060787005000190', 'ONG Vira Lata', NULL, 5);


INSERT INTO post_ong
  (titulo, foto, descricao, id_ong)
VALUES
  ('Evento de arrecadação', NULL, 'Participe do nosso evento de arrecadação de fundos!', 1),
  ('A importância do lar temporário', NULL, NULL, 1),
  ('Conheça 10 alimentos tóxicos', NULL, NULL, 1),
  ('Dia do Protetor Animal', NULL, NULL, 1),
  ('Cães também ficam gripados?', NULL, NULL, 1);

INSERT INTO pet
  (nome, tempo_vida, tipo_pet, raca, tamanho_raca, foto, disponivel, id_ong, id_cliente)
VALUES
  ('Fiel', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Van Gogh', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Barto', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Boris', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Bebeto', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Fido', '10 anos', 'Cachorro', 'Vira-lata', 'Raças Pequenas', NULL, FALSE, 1, 1),
  ('Bolinha', '12 anos', 'Cachorro', 'Poodle', 'Raças Pequenas', NULL, TRUE, 1, NULL),
  ('Whiskers', '15 anos', 'Gato', 'Siamês', 'Raças Pequenas', NULL, TRUE, 2, 3),
  ('Lucky', '8 anos', 'Cachorro', 'Labrador', 'Raças Grandes', NULL, TRUE, 3, 4),
  ('Mia', '10 anos', 'Gato', 'Persa', 'Raças Grandes', NULL, TRUE, 4, 5),
  ('Rocky', '9 anos', 'Cachorro', 'Bulldog', 'Raças Grandes', NULL, TRUE, 5, 6),
  ('Fluffy', '14 anos', 'Gato', 'Maine Coon', 'Raças Grandes', NULL, TRUE, 6, 7),
  ('Rex', '11 anos', 'Cachorro', 'Pastor Alemão', 'Raças Grandes', NULL, TRUE, 7, 8),
  ('Sasha', '13 anos', 'Gato', 'Ragdoll', 'Raças Grandes', NULL, TRUE, 8, 9),
  ('Max', '7 anos', 'Cachorro', 'Golden Retriever', 'Raças Grandes', NULL, TRUE, 9, 10),
  ('Lucy', '12 anos', 'Cachorro', 'Beagle', 'Raças Pequenas', NULL, TRUE, 10, 11),
  ('Oliver', '6 anos', 'Gato', 'British Shorthair', 'Raças Grandes', NULL, TRUE, 11, 12),
  ('Charlie', '10 anos', 'Cachorro', 'Bulldog Francês', 'Raças Pequenas', NULL, TRUE, 12, 13),
  ('Luna', '11 anos', 'Gato', 'Siamese', 'Raças Pequenas', NULL, TRUE, 13, 14),
  ('Cooper', '9 anos', 'Cachorro', 'Boxer', 'Raças Grandes', NULL, TRUE, 14, 15),
  ('Milo', '7 anos', 'Gato', 'Persian', 'Raças Grandes', NULL, TRUE, 15, 16),
  ('Daisy', '8 anos', 'Cachorro', 'Dachshund', 'Raças Pequenas', NULL, TRUE, 16, 17),
  ('Simba', '13 anos', 'Gato', 'Lion', 'Raças Grandes', NULL, TRUE, 17, 18),
  ('Bailey', '10 anos', 'Cachorro', 'Chihuahua', 'Raças Pequenas', NULL, TRUE, 18, 19),
  ('Zoe', '11 anos', 'Gato', 'Maine Coon', 'Raças Grandes', NULL, TRUE, 19, 20),
  ('Teddy', '9 anos', 'Cachorro', 'Shih Tzu', 'Raças Pequenas', NULL, TRUE, 20, 21);

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
  ('..\img\produtos\gato\racao\racao_gato_adulto.png', 4.5, 'Ótimo produto!', 1),
  ('..\img\produtos\gato\petisco\leite.png', 5.0, 'Excelente serviço!', 2),
  ('..\img\produtos\gato\brinquedos\bolinha.png', 4.0, 'Satisfeito!', 3),
  ('..\img\produtos\cachorro\petisco\petisco_cao_adulto.png', 4.0, 'Bom atendimento.', 4),
  ('..\img\produtos\cachorro\brinquedos\galinha.png', 5.0, 'Recomendo a todos!', 5),
  ('..\img/produtos/cachorro/racao/racao_cao_adulto_porte_grande.png', 4.0, 'Produto de qualidade.', 1),
  ('..\img/produtos/cachorro/petisco/petisco_cao_filhote.png', 5.0, 'Entrega rápida.', 2),
  ('..\img/produtos/gato/brinquedos/ratinho.png', 3.5, 'Poderia melhorar.', 3),
  ('..\img/produtos/gato/racao/racao_gato_filhote.png', 4.0, 'Bom custo-benefício.', 4),
  ('..\img/produtos/cachorro/brinquedos/bolinha_interativa.png', 4.5, 'Atendimento excelente.', 5);



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
  ('Brinquedo Bolas Catnip', 'Para Gatos', 'Todas as Raças', 0, 29.99, 13),
  ('Brinquedo Bolas Catnip', 'Para Gatos', 'Todas as Raças', 0, 29.99, 13);

INSERT INTO venda
  (id_fornecedor, id_produto, nota_fiscal, data_venda, quantidade_produto, valor_unitario)
VALUES
  (1, 1, 1002, '2023-09-28', 5, 10.50);

INSERT INTO compra
  (id_cliente, id_produto, nota_fiscal, data_compra, quantidade_produto, valor_unitario)
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
SELECT *
FROM login;
SELECT *
FROM representante;
SELECT *
FROM telefone;
SELECT *
FROM fornecedor;
SELECT *
FROM cliente;
SELECT *
FROM ong;
SELECT *
FROM post_ong;
SELECT *
FROM pet;
SELECT *
FROM post_adocao;
SELECT *
FROM depoimento;
SELECT *
FROM marca;
SELECT *
FROM produto;
SELECT *
FROM compra;
SELECT *
FROM venda;

-- CONSULTAS SIMPLES

-- Listar todos os clientes do sexo feminino (gênero 'F'):
SELECT nome_completo
FROM cliente
WHERE sexo = 'F';

-- Listar todos os produtos com um preço superior a R$ 50,00:
SELECT descricao, preco
FROM produto
WHERE preco > 50.00;

-- Listar todos os produtos para cães adultos com estoque maior que 10 unidades:
SELECT descricao, para_pets, qtd_estoque
FROM produto
WHERE para_pets = 'Para Cães Adultos' AND qtd_estoque > 10;

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
SELECT descricao, para_pets
FROM produto
WHERE para_pets LIKE 'Para Gatos%';

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
