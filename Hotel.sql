
-- 1 Questão --------------------------------------------------------------------------------------------------

create schema hospedar_db;
use hospedar_db;



-- 2 Questão --------------------------------------------------------------------------------------------------
create table Hotel(
id int primary key auto_increment,
nome varchar(100) not null,
cidade varchar(100) not null,
ratting	int not null
);

create table Quarto(
id int primary key auto_increment,
id_hotel int not null,
numero int not null,
tipo varchar(50) not null,
preco decimal not null,
foreign key(id_hotel) references Hotel (id)
);

create table Cliente(
id int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(15) not null,
cpf varchar(11) not null
);

create table Hospedagem(
id int primary key auto_increment,
id_cliente int not null,
id_quarto int not null,
data_checkin date not null,
data_checkout date not null,
Valor_total float not null,
status_hosp varchar(25) not null,
foreign key (id_cliente) references Cliente (id),
foreign key (id_quarto) references Quarto (id)
);

-- 3 Questão --------------------------------------------------------------------------------------------------

insert into Hotel (nome,cidade,ratting) values

('Hotel Central','Santa Catarina',5),
('Hotel Litoral','Rio de Janeiro',2),
('Hotel Campo Verde','Curitiba',4),
('Hotel Vista Mar','Salvador',3),
('Hotel da Serra','Gramado',3);

insert into Quarto (id_hotel,numero,tipo,preco) values

-- Hotel 1
(1, 101, 'Standard', 200.00),
(1, 102, 'Deluxe', 300.00),
(1, 103, 'Suíte', 400.00),
(1, 104, 'Standard', 200.00),
(1, 105, 'Deluxe', 300.00),

-- Hotel 2
(2, 201, 'Standard', 180.00),
(2, 202, 'Deluxe', 280.00),
(2, 203, 'Suíte', 380.00),
(2, 204, 'Standard', 180.00),
(2, 205, 'Deluxe', 280.00),

-- Hotel 3
(3, 301, 'Standard', 150.00),
(3, 302, 'Deluxe', 250.00),
(3, 303, 'Suíte', 350.00),
(3, 304, 'Standard', 150.00),
(3, 305, 'Deluxe', 250.00),

-- Hotel 4
(4, 401, 'Standard', 220.00),
(4, 402, 'Deluxe', 320.00),
(4, 403, 'Suíte', 420.00),
(4, 404, 'Standard', 220.00),
(4, 405, 'Deluxe', 320.00),

-- Hotel 5
(5, 501, 'Standard', 190.00),
(5, 502, 'Deluxe', 290.00),
(5, 503, 'Suíte', 390.00),
(5, 504, 'Standard', 190.00),
(5, 505, 'Deluxe', 290.00);


insert into Cliente (nome,email,telefone,cpf) values
('Cleber','clebi_do_pneu@gmail.com','11999999999','000.000.000-00'),
('João Silva','joao.silva@gmail.com','10999999999','100.000.000-00'),
('Maria Oliveira','maria.oliveira@gmail.com','12999999999','010.000.000-00'),
('João','joao@gmail.com','13999999999','001.000.000-00'),
('Rafael','rafael@gmail.com','14999999999','000.100.000-00');

insert into Hospedagem (id_cliente,id_quarto,data_checkin,data_checkout,Valor_total,status_hosp) values 

(1, 1, '2024-09-01', '2024-09-05', 800.00, 'finalizada'),
(2, 2, '2024-09-10', '2024-09-15', 1500.00, 'finalizada'),
(3, 3, '2024-08-20', '2024-08-25', 1200.00, 'finalizada'),
(4, 4, '2024-08-10', '2024-08-12', 600.00, 'finalizada'),
(5, 5, '2024-09-05', '2024-09-07', 1100.00, 'finalizada'),

-- Hospedagens com status "hospedado"
(1, 6, '2024-10-01', '2024-10-10', 1800.00, 'hospedado'),
(2, 7, '2024-10-02', '2024-10-09', 2000.00, 'hospedado'),
(3, 8, '2024-10-05', '2024-10-12', 1300.00, 'hospedado'),
(4, 9, '2024-10-03', '2024-10-11', 1400.00, 'hospedado'),
(5, 10, '2024-10-04', '2024-10-12', 1700.00, 'hospedado'),

-- Hospedagens com status "reserva"
(1, 11, '2024-11-01', '2024-11-05', 1000.00, 'reserva'),
(2, 12, '2024-11-10', '2024-11-15', 1500.00, 'reserva'),
(3, 13, '2024-11-20', '2024-11-25', 1300.00, 'reserva'),
(4, 14, '2024-11-05', '2024-11-07', 700.00, 'reserva'),
(5, 15, '2024-11-15', '2024-11-20', 1600.00, 'reserva'),

-- Hospedagens com status "cancelada"
(1, 16, '2024-09-01', '2024-09-03', 400.00, 'cancelada'),
(2, 17, '2024-09-10', '2024-09-12', 500.00, 'cancelada'),
(3, 18, '2024-09-15', '2024-09-17', 600.00, 'cancelada'),
(4, 19, '2024-09-20', '2024-09-22', 450.00, 'cancelada'),
(5, 20, '2024-09-25', '2024-09-28', 550.00, 'cancelada');

-- 4 Questão --------------------------------------------------------------------------------------------------

-- 4 Questão (A) --------------------------------------------------------------------------------------------------

SELECT h.nome AS hotel_nome, h.cidade, q.tipo, q.preco
FROM Hotel h
JOIN Quarto q ON h.id = q.id_hotel;


-- 4 Questão (B) --------------------------------------------------------------------------------------------------

SELECT c.nome AS cliente_nome, h.nome AS hotel_nome, q.numero AS quarto_numero
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
JOIN Quarto q ON hosp.id_quarto = q.id
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.status_hosp = 'finalizada';


-- 4 Questão (C) --------------------------------------------------------------------------------------------------

SELECT hosp.id, h.nome AS hotel_nome, q.numero AS quarto_numero, hosp.data_checkin, hosp.data_checkout
FROM Hospedagem hosp
JOIN Quarto q ON hosp.id_quarto = q.id
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.id_cliente = 1 
ORDER BY hosp.data_checkin;



-- 4 Questão (D) --------------------------------------------------------------------------------------------------

SELECT c.nome, COUNT(hosp.id) AS total_hospedagens
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
GROUP BY c.id
ORDER BY total_hospedagens DESC
LIMIT 1;


-- 4 Questão (E) --------------------------------------------------------------------------------------------------

SELECT c.nome AS cliente_nome, h.nome AS hotel_nome, q.numero AS quarto_numero
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
JOIN Quarto q ON hosp.id_quarto = q.id
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.status_hosp = 'cancelada';


-- 4 Questão (F) --------------------------------------------------------------------------------------------------

SELECT h.nome AS hotel_nome, SUM(hosp.valor_total) AS receita
FROM Hotel h
JOIN Quarto q ON h.id = q.id_hotel
JOIN Hospedagem hosp ON q.id = hosp.id_quarto
WHERE hosp.status_hosp = 'finalizada'
GROUP BY h.id
ORDER BY receita DESC;


-- 4 Questão (G) --------------------------------------------------------------------------------------------------

SELECT c.nome AS cliente_nome
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
JOIN Quarto q ON hosp.id_quarto = q.id
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.status_hosp = 'reserva' AND h.id = 3; 


-- 4 Questão (H) --------------------------------------------------------------------------------------------------

SELECT c.nome AS cliente_nome, SUM(hosp.valor_total) AS total_gasto
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
WHERE hosp.status_hosp = 'finalizada'
GROUP BY c.id
ORDER BY total_gasto DESC;


-- 4 Questão (I) --------------------------------------------------------------------------------------------------

SELECT q.numero, h.nome AS hotel_nome
FROM Quarto q
LEFT JOIN Hospedagem hosp ON q.id = hosp.id_quarto
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.id_quarto IS NULL;


-- 4 Questão (J) --------------------------------------------------------------------------------------------------

SELECT q.tipo, AVG(q.preco) AS media_preco
FROM Quarto q
GROUP BY q.tipo;


-- 4 Questão (K) --------------------------------------------------------------------------------------------------

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Hospedagem
WHERE status_hosp = 'cancelada';


-- 4 Questão (L) --------------------------------------------------------------------------------------------------

ALTER TABLE Hospedagem ADD COLUMN checkin_realizado BOOLEAN;

UPDATE Hospedagem
SET checkin_realizado = TRUE
WHERE status_hosp IN ('finalizada', 'hospedado');

UPDATE Hospedagem
SET checkin_realizado = FALSE
WHERE status_hosp IN ('reserva', 'cancelada');


-- 4 Questão (M) --------------------------------------------------------------------------------------------------

ALTER TABLE Hotel CHANGE COLUMN ratting classificacao INT;


-- 4 Questão (N) --------------------------------------------------------------------------------------------------

CREATE VIEW ReservasFuturas AS
SELECT c.nome AS cliente_nome, h.nome AS hotel_nome, q.numero AS quarto_numero, hosp.data_checkin
FROM Cliente c
JOIN Hospedagem hosp ON c.id = hosp.id_cliente
JOIN Quarto q ON hosp.id_quarto = q.id
JOIN Hotel h ON q.id_hotel = h.id
WHERE hosp.status_hosp = 'reserva' AND hosp.data_checkin > NOW()
ORDER BY hosp.data_checkin;



