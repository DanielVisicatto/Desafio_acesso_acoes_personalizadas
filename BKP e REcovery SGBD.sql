-- Criando o banco de dados e-commerce
CREATE DATABASE e_commerce;

-- Utilizando o banco de dados e-commerce
USE e_commerce;

-- Criando a tabela de usuários
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  senha VARCHAR(50) NOT NULL
);

-- Inserindo alguns dados na tabela de usuários
INSERT INTO usuarios (nome, email, senha) VALUES
('Maria', 'maria@email.com', 'senha123'),
('João', 'joao@email.com', 'senha456'),
('Ana', 'ana@email.com', 'senha789');

-- Iniciando uma transação sem utilizar procedures
START TRANSACTION;
UPDATE usuarios SET senha = 'novasenha123' WHERE id = 1;
SELECT * FROM usuarios WHERE id = 1;
COMMIT;

-- Criando uma procedure que realiza uma atualização na tabela de usuários
DELIMITER $$
CREATE PROCEDURE atualizar_senha(IN id INT, IN nova_senha VARCHAR(50))
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
  END;
  START TRANSACTION;
  UPDATE usuarios SET senha = nova_senha WHERE id = id;
  SELECT * FROM usuarios WHERE id = id;
  COMMIT;
END $$
DELIMITER ;

-- Chamando a procedure criada
CALL atualizar_senha(1, 'outrasenha123');

-- Realizando o backup do banco de dados e-commerce com o mysqldump
mysqldump -u root -p e_commerce > e_commerce_backup.sql

-- Realizando o recovery do banco de dados e-commerce
mysql -u root -p e_commerce < e_commerce_backup.sql