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

INSERT INTO Esami VALUES('29323', 483, 28, 'NO'), 
						('39654', 729, 30, 'SI'),
						('29323', 913, 26, 'NO'),
						('35467', 913, 30, 'NO')

SELECT * FROM Studenti
SELECT * FROM Corsi
SELECT * FROM Esami
