CREATE TABLE Studenti(
	Matricola char(5) PRIMARY KEY,
	Cognome varchar(30) NOT NULL,
	Nome varchar(30) NOT NULL,
	DataNascita date NOT NULL,
	Email varchar(100)
)

CREATE TABLE Corsi(
	CodCorso int PRIMARY KEY,
	Titolo varchar(50) NOT NULL,
	Docente varchar(30),
	Anno int DEFAULT 1 CHECK (Anno > 0)
)

CREATE TABLE Esami(
	Matricola char(5) NOT NULL REFERENCES Studenti,
	CodCorso int NOT NULL REFERENCES Corsi,
	Voto int NOT NULL CHECK (Voto BETWEEN 18 AND 30),
	Lode char(2) NOT NULL CHECK (Lode IN ('SI', 'NO')),
	PRIMARY KEY(Matricola, CodCorso)
)


INSERT INTO Studenti(Matricola, Cognome, Nome, DataNascita, Email)
VALUES('29323',  'Bianchi', 'Giorgio', '1978-06-21', 'gbianchi@alma.unibo.it')

INSERT INTO Studenti(Matricola, Cognome, Nome, DataNascita, Email)
VALUES('35467',  'Roddi', 'Anna', '1978-04-13', 'anna.rossi@yahoo.it')

INSERT INTO Studenti(Matricola, Cognome, Nome, DataNascita, Email)
VALUES('39654',  'Verdi', 'Marco', '1979-09-20', 'mverdi@mv.com')


INSERT INTO Studenti(Matricola, Cognome, Nome, DataNascita, Email)
VALUES('42132',  'Neri', 'Lucia', '1978-02-15', 'lucia78@cs.ucsd.edu@yahoo.it')

INSERT INTO Corsi VALUES(483, 'Analisi', 'Biondi', 1)
INSERT INTO Corsi VALUES(729, 'Analisi', 'Neri', 1)
INSERT INTO Corsi VALUES(913, 'Sistemi Informativi', 'Castani', 2)

SELECT * FROM Esami

BEGIN TRANSACTION
BEGIN TRY
INSERT INTO Esami VALUES('29323', 483, 28, 'NO') 
INSERT INTO Esami VALUES('39654', 729, 30, 'SI')
INSERT INTO Esami VALUES('29323', 913, 26, 'NO')
INSERT INTO Esami VALUES('35467', 913, 30, 'NO')
COMMIT
PRINT('Inserimento completato')
END TRY
BEGIN CATCH
ROLLBACK
PRINT('Errore durante l inserimanto')
END CATCH
 


SELECT * FROM Studenti
SELECT * FROM Corsi
SELECT * FROM Esami

SELECT codcorso
FROM Corsi
WHERE Titolo = 'Analisi' AND Docente = 'Biondi'

SELECT Matricola
FROM Esami 
WHERE CodCorso = 483


SELECT * FROM Corsi
SELECT * FROM Esami

SELECT Esami.Matricola
FROM Corsi, Esami
WHERE Corsi.CodCorso = Esami.CodCorso
AND Corsi.Titolo = 'Analisi' AND Corsi.Docente = 'Biondi'

SELECT e.Matricola
FROM Corsi c
JOIN Esami e ON c.CodCorso = e.CodCorso
WHERE c.Titolo = 'Analisi' AND c.Docente = 'Biondi'


SELECT * FROM Corsi
SELECT * FROM Esami


SELECT *
FROM Corsi c
JOIN Esami e ON c.CodCorso = e.CodCorso


SELECT *
FROM Corsi c
JOIN Esami e ON c.CodCorso = e.CodCorso
WHERE c.Titolo = 'Analisi' AND c.Docente = 'Biondi'


SELECT e.Matricola
FROM Corsi c
JOIN Esami e ON c.CodCorso = e.CodCorso
WHERE c.Titolo = 'Analisi' AND c.Docente = 'Biondi'




SELECT * FROM Studenti
SELECT * FROM Corsi
SELECT * FROM Esami

SELECT *
FROM Studenti s
JOIN Esami e ON e.Matricola = s.Matricola
JOIN Corsi c ON c.CodCorso = e.CodCorso

SELECT *
FROM Studenti s
JOIN Esami e ON e.Matricola = s.Matricola
JOIN Corsi c ON c.CodCorso = e.CodCorso
WHERE e.Voto = 30 AND e.Lode = 'SI' AND c.Titolo = 'Analisi'

SELECT s.Email
FROM Studenti s
JOIN Esami e ON e.Matricola = s.Matricola
JOIN Corsi c ON c.CodCorso = e.CodCorso
WHERE e.Voto = 30 AND e.Lode = 'SI' AND c.Titolo = 'Analisi'


SELECT DISTINCT s.Nome, s.Cognome
FROM Esami e
JOIN Studenti s ON s.Matricola = e.Matricola