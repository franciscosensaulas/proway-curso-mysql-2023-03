DROP DATABASE IF EXISTS ultima_aula;
CREATE DATABASE ultima_aula;
USE ultima_aula;

CREATE TABLE bebidas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(40),
    tipo VARCHAR(30),
    estoque INT DEFAULT 1
);

INSERT INTO bebidas(nome, tipo) VALUES
    ("Monster", " Energético "),
    ("RedBull", " Energético "),
    ("Pepsi Black", "Refrigerante"),
    ("Coca-Cola","Refrigerante"),
    (" L'or "," Café ");
SELECT * FROM bebidas;

CREATE TABLE pedidos (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cliente VARCHAR(100),
    total DECIMAL(8, 2),
    status INT, -- 1 Finalizado -- 0 Processando
    data_finalizacao DATE
);

CREATE TABLE itens_pedido(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_bebida INT,
    id_pedido INT,
    quantidade INT,
    UNIQUE(id_pedido, id_bebida),
     
    FOREIGN KEY(id_bebida) REFERENCES bebidas(id),
    FOREIGN KEY(id_pedido) REFERENCES pedidos(id)
);

INSERT INTO pedidos(cliente, total) VALUES ("José", 0);

INSERT INTO itens_pedido(id_pedido, id_bebida, quantidade) VALUES (1, 1, 2); -- Monster
INSERT INTO itens_pedido(id_pedido, id_bebida, quantidade) VALUES (1, 2, 1); -- RedBull
INSERT INTO itens_pedido(id_pedido, id_bebida, quantidade) VALUES (1, 4, 2); -- Coca Cola

SELECT 
	p.cliente,
    b.nome,
    ip.quantidade
	FROM itens_pedido ip
    INNER JOIN pedidos p ON(ip.id_pedido = p.id)
    INNER JOIN bebidas b ON(ip.id_bebida = b.id);


SET AUTOCOMMIT = OFF;
START TRANSACTION;
	INSERT INTO pedidos (cliente, total) VALUES ("Jardel", 0);
	INSERT INTO itens_pedido (id_pedido, id_bebida, quantidade) VALUES (2, 5, 1);
	INSERT INTO itens_pedido (id_pedido, id_bebida, quantidade) VALUES (2, 3, 10);
	INSERT INTO itens_pedido (id_pedido, id_bebida, quantidade) VALUES (2, 1, 1);
	INSERT INTO itens_pedido (id_pedido, id_bebida, quantidade) VALUES (2, 1, 1);

	SELECT * FROM pedidos;
	SELECT * FROM itens_pedido;
COMMIT;

ROLLBACK;
SET AUTOCOMMIT = ON;

SELECT 
	p.cliente,
    b.nome,
    ip.quantidade
	FROM itens_pedido ip
    INNER JOIN pedidos p ON(ip.id_pedido = p.id)
    INNER JOIN bebidas b ON(ip.id_bebida = b.id);


DELIMITER $
DROP TRIGGER IF EXISTS DefinirStatusPedido $
CREATE TRIGGER DefinirStatusPedido BEFORE INSERT
ON pedidos
FOR EACH ROW
BEGIN
	IF NEW.data_finalizacao IS NOT NULL THEN
		SET NEW.status = 1;
	ELSE
		SET NEW.status = 0;
    END IF;
END $
DELIMITER ;
INSERT INTO pedidos (cliente, total) VALUES ("Luiz", 0);
INSERT INTO pedidos (cliente, total, data_finalizacao) VALUES 
	("Francisco", 0, "2023-05-10");

SELECT * FROM pedidos;



