create schema consultorio;
USE consultorio;


--    1 QUESTÃO   --------------------------------------------------------------------------------------------


CREATE TABLE Especialidade(
id integer primary key auto_increment,
nome varchar(50)
);

CREATE TABLE Paciente(
id integer primary key auto_increment,
nome varchar(100) not null,
celular varchar(15)
);

CREATE TABLE Medico (
id integer primary key auto_increment,
id_especialidade integer not null,
nome varchar(100) not null,
celular varchar(15) not null,
FOREIGN KEY (id_especialidade) REFERENCES Especialidade (id)
);

CREATE TABLE Consulta (
id integer primary key auto_increment,
id_medico integer not null,
id_paciente integer not null,
data_horario_inicio datetime not null,
data_hora_fim datetime not null,
FOREIGN KEY (id_medico) REFERENCES Medico (id),
FOREIGN KEY (id_paciente) REFERENCES Paciente (id)
);

--    2 QUESTÃO   --------------------------------------------------------------------------------------------

	-- (1) --
INSERT INTO Especialidade (nome) VALUES
('Cardiologia'),
('Oftalmologia'),
('Pediatria');

-- (2) --

INSERT INTO Medico (id_especialidade,nome,celular) VALUES
('1','Beatriz','(47) 99999-9999'),
('3','José','(47) 99999-9999'),
('1','Ana','(47) 99999-9999'),
('2','Gustavo','(47) 99999-9999'),
('1','Paulo','(47) 99999-9999'),
('3','Carlos','(47) 99999-9999');

-- (3) --

INSERT INTO Paciente (nome,celular) VALUES
('Marina','(47) 99999-9999'),
('Marcos','(47) 99999-9999'),
('Maicon','(47) 99999-9999'),
('Roberta','(47) 99999-9999'),
('Joaquim','(47) 99999-9999'),
('Bianca','(47) 99999-9999'),
('Pedro','(47) 99999-9999');
-- (4) --
INSERT INTO Consulta (id_medico,id_paciente,data_horario_inicio,data_hora_fim) VALUES
('19', '4','2024-12-08 10:00:00','2024-12-08 11:30:00'),
('19', '5','2024-12-08 11:30:00','2024-12-08 12:00:00'),
('19', '6','2024-12-08 13:30:00','2024-12-08 14:30:00'),
('20', '2','2024-12-08 08:00:00','2024-12-08 10:00:00'),
('20', '3','2024-12-08 10:00:00','2024-12-08 11:00:00'),
('20', '1','2024-12-08 11:00:00','2024-12-08 12:00:00'),
('23', '7','2024-12-09 08:30:00','2024-12-09 09:00:00'),
('22', '7','2024-12-09 09:00:00','2024-12-09 10:00:00'),
('22', '5','2024-12-09 11:00:00','2024-12-09 12:00:00'),
('22', '6','2024-12-09 13:30:00','2024-12-09 14:30:00'),
('22', '2','2024-12-09 14:30:00','2024-12-09 15:00:00');



--    3 QUESTÃO   --------------------------------------------------------------------------------------------

UPDATE Paciente
SET celular = '(47) 88888-8888'
WHERE nome = 'Bianca';

UPDATE Paciente
SET celular = '(47) 77777-7777'
WHERE nome = 'Marcos';


--    4 QUESTÃO   --------------------------------------------------------------------------------------------


SELECT id FROM Medico WHERE nome = 'Beatriz'; -- Suponhamos que o id seja 19
SELECT id FROM Paciente WHERE nome = 'Bianca'; -- Suponhamos que o id seja 6


DELETE FROM Consulta
WHERE id_medico = 19
AND id_paciente = 6
AND DATE(data_horario_inicio) = '2024-12-08';


--    5 QUESTÃO   --------------------------------------------------------------------------------------------

-- (1) --

SELECT M.nome AS medico, COUNT(C.id) AS quantidade_consultas
FROM Medico M
LEFT JOIN Consulta C ON M.id = C.id_medico
GROUP BY M.nome
ORDER BY M.nome ASC;

-- (2) --

SELECT E.nome AS especialidade, COUNT(C.id) AS quantidade_consultas
FROM Especialidade E
LEFT JOIN Medico M ON E.id = M.id_especialidade
LEFT JOIN Consulta C ON M.id = C.id_medico
GROUP BY E.nome;


-- (3) --

SELECT DATE_FORMAT(data_horario_inicio, '%d/%m') AS dia_mes, 
       MAX(TIMESTAMPDIFF(MINUTE, data_horario_inicio, data_hora_fim)) AS maior_duracao_minutos
FROM Consulta
GROUP BY DATE(data_horario_inicio);


-- (4) --

SELECT COUNT(C.id) AS quantidade_consultas, E.nome AS especialidade, M.nome AS medico
FROM Medico M
JOIN Especialidade E ON M.id_especialidade = E.id
JOIN Consulta C ON M.id = C.id_medico
GROUP BY M.id, E.nome
ORDER BY quantidade_consultas DESC
LIMIT 1;


-- (5) --

CREATE VIEW todas_consultas AS
SELECT P.nome AS paciente, 
       M.nome AS medico, 
       E.nome AS especialidade, 
       C.data_horario_inicio AS data
FROM Consulta C
JOIN Paciente P ON C.id_paciente = P.id
JOIN Medico M ON C.id_medico = M.id
JOIN Especialidade E ON M.id_especialidade = E.id
ORDER BY C.data_horario_inicio;


