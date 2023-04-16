DROP DATABASE IF EXISTS financeiro;
CREATE DATABASE Financeiro;
USE Financeiro;
CREATE TABLE contas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    valor DECIMAL(6, 2),
    status TINYINT
);

INSERT INTO contas (nome, valor, status) VALUES
('Luz', 240.00, 0);

INSERT INTO contas (nome, valor, status) VALUES 
('Youtube Premium', 36.00, 1);

UPDATE contas SET valor = 40.00 WHERE id = 2;

CREATE TABLE entradas_saidas(
	id INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(100),
    nome VARCHAR(100),
    valor DECIMAL(6, 2),
    registro_ativo BIT
);


ALTER TABLE entradas_saidas ADD COLUMN data DATE AFTER valor;

INSERT INTO entradas_saidas (nome, tipo, valor) VALUES
("Salário Google", "pagamento", 1000.00 * 5.60);
UPDATE entradas_saidas SET data = '2023-05-01' WHERE id = 1;

INSERT INTO entradas_saidas (nome, tipo, valor, data) VALUES
("Salário de Professor C#", "pagamento", 5000.00, "2023-05-01"),
("Investimentos cripto 2023", "pagamento", 2500.20, "2023-05-01"),
("Investimentos cripto 2022", "pagamento", 2600.20, "2022-06-01"),
("Investimentos cripto 2021", "pagamento", 2600.20, "2021-06-01"),
("Investimentos cripto 2020", "pagamento", 2600.20, "2020-06-01");
UPDATE entradas_saidas SET registro_ativo = 0 WHERE id = 4;

DELIMITER $ 
DROP PROCEDURE IF EXISTS HouseKeeping $
CREATE PROCEDURE HouseKeeping()
BEGIN
	 DECLARE hoje DATETIME;
     DECLARE ano INT;
     DECLARE mes INT;
     DECLARE dia INT;
     DECLARE data_apagar CHAR(10);
    
     SET hoje = NOW();
     SET ano = YEAR(hoje) - 2;
     SET mes = MONTH(hoje);
     SET dia = DAY(hoje);
     SET data_apagar = CONCAT(ano, "-", mes, "-", dia);
     DELETE FROM entradas_saidas WHERE data <= data_apagar;
    
END $
DELIMITER ;
SELECT * FROM entradas_saidas;
CALL HouseKeeping();
SELECT * FROM entradas_saidas;






