-- Consultar bancos de dados criados
SHOW SCHEMAS;

-- Apagar o banco de dados que foi criado
DROP DATABASE IF EXISTS curso_mysql;

-- Criar o banco de dados que será utilizado no curso
CREATE DATABASE IF NOT EXISTS curso_mysql;

-- Definir o banco que dados que será executado as consultas(queries)
USE curso_mysql;

-- Consultar as tabelas do banco de dados utilizado (vulgo comando USE curso_mysql)
SHOW TABLES;

-- Criar tabela para armazenar os registros dos alunos
CREATE TABLE alunos(
    -- AUTO_INCREMENT vai fazer o id começar com e depois incrementar em 1 a cada registro
    -- NOT NULL coluna que é obrigatório informar valor
    id INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL -- VARCHAR(100) coluna com no máximo 100 caracteres
);

-- Consultar todos os registros da tabela de alunos
SELECT id, nome FROM alunos;

-- Criar registro na tabela de alunos
INSERT INTO alunos (nome) VALUE ("José");

-- CUIDADO: Apagar TODOS os registros da tabela;
DELETE FROM alunos;

-- Consultar as colunas das tabelas
DESCRIBE alunos;
-- +-------+--------------+------+-----+---------+----------------+                                         
-- | Field | Type         | Null | Key | Default | Extra          |
-- +-------+--------------+------+-----+---------+----------------+
-- | id    | int          | NO   | PRI | NULL    | auto_increment |
-- | nome  | varchar(100) | NO   |     | NULL    |                |
-- +-------+--------------+------+-----+---------+----------------+ 

-- Redefinir o AUTO_INCREMENT e apagar todos os registros da tabela, 
--   porém n pode ter FK relacionada a esta tabela
TRUNCATE TABLE alunos;

-- Criar registro na tabela de alunos
INSERT INTO alunos (nome) VALUE ("José");
INSERT INTO alunos (nome) VALUE ("Luiz");
INSERT INTO alunos (nome) VALUE ("Bruno");
INSERT INTO alunos (nome) VALUE ("Lucas");
INSERT INTO alunos (nome) VALUE ("Jardel");
INSERT INTO alunos (nome) VALUE ("Zaqueu");
INSERT INTO alunos (nome) VALUE ("João");

-- Apagar registro do João filtrando pelo nome "João"
DELETE FROM alunos WHERE nome = "João";
-- Apagar o registro do João filtrando pelo id 7
DELETE FROM alunos WHERE id = 7;

-- Consultar quantidade de registros da tabela
SELECT COUNT(id) FROM alunos;

-- Criar tabela de professores 
CREATE TABLE professores(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    valor_hora FLOAT(5, 2) -- cinco números, sendo 2 na parte decimal
); 

INSERT INTO professores (nome, valor_hora) VALUE ("Francisco", 53.00);
INSERT INTO professores (nome, valor_hora) VALUE ("Javeiro", 80.35);
INSERT INTO professores (nome, valor_hora) VALUE ("Rubens", 75.00);
INSERT INTO professores (nome, valor_hora) VALUE ("Pablo", 60.00);
INSERT INTO professores (nome, valor_hora) VALUE ("Pamela", 100.00);

SELECT id, nome, valor_hora FROM professores;


-- Criar tabela de cursos
CREATE TABLE cursos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    carga_horaria INT NOT NULL
);

-- Criar registros de cursos
INSERT INTO cursos (nome, carga_horaria) VALUE ('MySQL', 28);
INSERT INTO cursos (nome, carga_horaria) VALUE ('C#', 40);
INSERT INTO cursos (nome, carga_horaria) VALUE ('Python', 39);
INSERT INTO cursos (nome, carga_horaria) VALUE ('Java', 41);
INSERT INTO cursos (nome, carga_horaria) VALUE ('HTML, CSS', 32);
INSERT INTO cursos (nome, carga_horaria) VALUE ('React', 52);

-- Consultar registros de cursos
SELECT id, nome, carga_horaria FROM cursos;

-- Consultar registros de cursos ordenados em ordem crescente(ASC) da coluna nome
SELECT id, nome, carga_horaria FROM cursos ORDER BY nome ASC;

-- Consultar registros de cursos ordenados em ordem decrescente(DESC) da coluna nome
SELECT id, nome, carga_horaria FROM cursos ORDER BY nome DESC;

-- Consultar registros de cursos filtrando onde a carga_horaria é maior ou igual a 40 horas
-- Ordenando pela carga_horaria em ordem crescente
SELECT id, nome, carga_horaria FROM cursos 
    WHERE carga_horaria >= 40
    ORDER BY carga_horaria ASC;

-- Operadores relacionais:
-- IGUAL            =
-- DIFERENTE        != <>
-- MENOR            <
-- MENOR OU IGUAL   <=
-- MAIOR            >
-- MAIOR OU IGUAL   >=


-- https://bit.ly/3YLA5xk

-- Consultar a menor carga horária
SELECT MIN(carga_horaria) FROM cursos;
-- Consultar a maior carga horária
SELECT MAX(carga_horaria) FROM cursos; 
-- Consultar a soma das cargas horárias
SELECT SUM(carga_horaria) FROM cursos;
-- Consultar a médias das cargas horárias
SELECT SUM(carga_horaria) / COUNT(id) FROM cursos;
SELECT AVG(carga_horaria) FROM cursos;

SELECT 
    AVG(carga_horaria) AS "Média de carga horária de cursos > 40h"
    FROM cursos WHERE carga_horaria > 40;

-- Consultar a quantidade de caracteres da coluna do nome
SELECT LENGTH(nome), nome FROM cursos;

-- Criar coluna na tabela de alunos para armazenar a data de nascimento
ALTER TABLE alunos ADD COLUMN data_nascimento DATE;

-- Consultar a data de nascimento dos alunos
SELECT id, nome, data_nascimento FROM alunos;

-- Atualizar a data de nascimento do José
DELETE FROM alunos WHERE id = 7; 
UPDATE alunos SET data_nascimento = '2000-06-28' WHERE id = 1;
UPDATE alunos SET data_nascimento = '2004-10-27' WHERE id = 2;
UPDATE alunos SET data_nascimento = '1981-10-18' WHERE id = 3;
UPDATE alunos SET data_nascimento = '2000-01-01' WHERE id = 4;
UPDATE alunos SET data_nascimento = '1996-07-27' WHERE id = 5;
UPDATE alunos SET data_nascimento = '2000-01-02' WHERE id = 6;

SELECT 
    DATE_FORMAT(data_nascimento, "%d/%m/%Y") AS 'Data de nascimento'
    FROM alunos;

-- Consultar o ano da data de nascimento
SELECT YEAR(data_nascimento) FROM alunos;
-- Consultar o mês da data de nascimento
SELECT MONTH(data_nascimento) FROM alunos;
-- Consultar o dia da data de nascimento;
SELECT DAY(data_nascimento) FROM alunos;

-- Consultar o nome e data de nascimento concatenados
SELECT CONCAT(nome, " ", data_nascimento) FROM alunos;

-- Consultar o nome e data de nascimento, de alunos nascidos depois de 1999,
-- ordenando por múltiplas colunas
SELECT nome, data_nascimento 
    FROM alunos 
    WHERE YEAR(data_nascimento) >= 2000 
    ORDER BY YEAR(data_nascimento) ASC, MONTH(data_nascimento) ASC, DAY(data_nascimento);


-- OPERADOR LÓGICO AND
-- V    e   V   => V
-- V    e   F   => F
-- F    e   V   => F
-- F    e   F   => F

-- Consultar os alunos que nasceram na década de 90
SELECT id, nome, data_nascimento 
    FROM alunos 
    WHERE 
        YEAR(data_nascimento) >= 1990 AND 
        YEAR(data_nascimento) <= 1999;

-- OPERADOR LÓGICO OR
-- V    ou  V => V
-- V    ou  F => V
-- F    ou  V => V
-- F    ou  F => F
-- Consultar os cursos com o nome C# ou Python
SELECT id, nome FROM cursos WHERE nome = "C#" OR nome = "Python";

-- Consultar os cursos com o nome C# ou Pyhon ou Java
SELECT id, nome FROM cursos WHERE nome IN ("C#", "Python", "Java");

-- Consultar os cursos com o nome diferente de C# e Python e Java (SEM NOT IN)
SELECT id, nome FROM cursos WHERE nome != "C#" AND nome != "Python" AND nome != "Java";

-- Consultar os cursos com o nome diferente de C# e Python e Java (COM NOT IN)
SELECT id, nome FROM cursos WHERE nome NOT IN ("C#", "Python", "Java");

-- Consultar os cursos com carga horária entre 40 e 45 horas
SELECT id, nome, carga_horaria 
    FROM cursos 
    WHERE carga_horaria >= 40 AND carga_horaria <= 45; -- Sem BETWEEN

SELECT id, nome, carga_horaria 
    FROM cursos
    WHERE carga_horaria BETWEEN 40 AND 45; -- Com Between

-- Consultar os cursos limitados a dois registros
SELECT * FROM cursos LIMIT 2;

-- Consultar os cursos limitados a dois registros da primeira página
SELECT * FROM cursos LIMIT 0, 2;
-- +----+-------+---------------+
-- | id | nome  | carga_horaria |
-- +----+-------+---------------+
-- |  1 | MySQL |            28 |
-- |  2 | C#    |            40 |
-- +----+-------+---------------+
-- 2 rows in set (0.00 sec)
-- Consultar os cursos limitados a dois registros da segunda página
SELECT * FROM cursos LIMIT 2, 2;
-- +----+--------+---------------+
-- | id | nome   | carga_horaria |
-- +----+--------+---------------+
-- |  3 | Python |            39 |
-- |  4 | Java   |            41 |
-- +----+--------+---------------+
-- 2 rows in set (0.00 sec)

-- Consultar os cursos limitados a dois registros da terceira página
SELECT * FROM cursos LIMIT 4, 2;
-- +----+-----------+---------------+
-- | id | nome      | carga_horaria |
-- +----+-----------+---------------+
-- |  5 | HTML, CSS |            32 |
-- |  6 | React     |            52 |
-- +----+-----------+---------------+
-- 2 rows in set (0.00 sec)

-- Consultar o nome e a geração do aluno de acordo com data de nascimento
SELECT
    nome,
    CASE
        WHEN YEAR(data_nascimento) BETWEEN 1980 AND 1994 THEN "Geração Y"
        WHEN YEAR(data_nascimento) BETWEEN 1995 AND 2009 THEN "Geração Z"
        WHEN YEAR(data_nascimento) BETWEEN 2010 AND 2023 THEN "Geração Alpha"
        ELSE "Geração X"
    END AS "Geração" -- AS chamado ALIAS (Apelido)
    FROM alunos;