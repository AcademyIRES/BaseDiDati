CREATE DATABASE Aeroporti
GO
USE Aeroporti
Go

CREATE TABLE Aeroporto(
Citt� NVARCHAR(50) PRIMARY KEY,
Nazione NVARCHAR(50) NOT NULL,
NumPiste INT NULL,
)

INSERT INTO Aeroporto VALUES (N'Bologna', N'Italia', 10)
INSERT INTO Aeroporto VALUES (N'Djerba', N'Tunisia', 5)
INSERT INTO Aeroporto VALUES (N'Milano', N'Italia', 20)
INSERT INTO Aeroporto VALUES (N'Parigi', N'Francia', 20)
INSERT INTO Aeroporto VALUES (N'Roma', N'Italia', 20)
INSERT INTO Aeroporto VALUES (N'Tolosa', N'Francia', 10)
INSERT INTO Aeroporto VALUES (N'Torino', N'Italia', NULL)
INSERT INTO Aeroporto VALUES (N'Tunisi', N'Tunisia', 10)
INSERT INTO Aeroporto VALUES (N'Venezia', N'Italia', 15)


CREATE TABLE Aereo(
TipoAereo VARCHAR(20) PRIMARY KEY,
NumPasseggeri INT DEFAULT 0 NOT NULL CHECK(NumPasseggeri >= 0),
QtaMerci INT DEFAULT 0 NOT NULL CHECK(QtaMerci >= 0),
)

INSERT INTO Aereo VALUES('Airbus_820', 380, 0);
INSERT INTO Aereo VALUES('Boing_747', 0, 500);
INSERT INTO Aereo VALUES('Boing_812', 200, 300);



CREATE TABLE Volo(
IdVolo NVARCHAR(10) PRIMARY KEY, 
GiornoSett NVARCHAR(20) NOT NULL CHECK(
	GiornoSett IN ('Luned�', 'Marted�', 'Mercoled�',
	 'Gioved�', 'Venerd�', 'Sabato', 'Domenica')), 
Citt�Part NVARCHAR(50) NOT NULL REFERENCES Aeroporto, 
OraPart TIME  NOT NULL,
Citt�Arr NVARCHAR(50) NOT NULL REFERENCES Aeroporto, 
OraArr TIME NOT NULL, 
TipoAereo VARCHAR(20) NOT NULL REFERENCES Aereo)

INSERT INTO Volo VALUES ('AZ274','Luned�', 'Bologna', '12:30:00', 'Tunisi', '13:50', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ275','Venerd�', 'Venezia', '10:00:00', 'Parigi', '12:00', 'Boing_747')
INSERT INTO Volo VALUES ('AZ276','Gioved�', 'Roma', '12:30:00', 'Milano', '13:50', 'Boing_812')
INSERT INTO Volo VALUES ('AZ277','Marted�', 'Djerba', '15:30:00', 'Tolosa', '17:15', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ278','Sabato', 'Bologna', '08:30:00', 'Milano', '09:30', 'Boing_812')
INSERT INTO Volo VALUES ('AZ279','Mercoled�', 'Tunisi', '17:30:00', 'Venezia', '18:50', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ280','Luned�', 'Bologna', '10:30:00', 'Venezia', '11:30', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ281','Sabato', 'Bologna', '20:30:00', 'Roma', '22:30', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ282','Marted�', 'Venezia', '20:30:00', 'Roma', '21:30', 'Boing_812')
INSERT INTO Volo VALUES ('AZ283','Venerd�', 'Bologna', '20:30:00', 'Roma', '22:30', 'Airbus_820')

SELECT * FROM Aeroporto
SELECT * FROM Aereo
SELECT * FROM Volo

SELECT *
FROM Aeroporto a
LEFT JOIN Volo v ON v.Citt�Part = a.Citt�

SELECT * 
FROM Volo v
RIGHT JOIN Aeroporto a ON  a.Citt� = v.Citt�Part



SELECT v.Citt�Part
FROM Volo v
WHERE v.Citt�Arr = 'Roma'
ORDER BY v.Citt�Part


SELECT *
FROM Volo v 
JOIN Aereo a ON a.TipoAereo = v.TipoAereo
WHERE a.QtaMerci =  
(
	SELECT Max(QtaMerci) 
	FROM Aereo
)



SELECT Citt�
FROM Aeroporto
WHERE NumPiste IS NULL

SELECT * --ap.Nazione AS NazionePartenza, aa.Nazione AS NazioneArrivo
FROM Volo v
JOIN Aeroporto ap ON ap.Citt� = v.Citt�Part
JOIN Aeroporto aa ON aa.Citt� = v.Citt�Arr
WHERE v.IdVolo = 'AZ274'

SELECT Citt�
FROM Aeroporto
WHERE Nazione='Italia' and
NumPiste >= ALL
(
	SELECT numPiste
	FROM AEROPORTO
	WHERE Nazione='Italia'
	AND NumPiste IS NOT NULL 
)

UPDATE Aeroporto SET NumPiste = 20 WHERE Citt� = 'Parigi'

SELECT Nazione, COUNT(NumPiste)
FROM Aeroporto
GROUP BY Nazione 
HAVING COUNT(NumPiste) > 20

SELECT * FROM Aeroporto WHERE Nazione = 'Italia' 

SELECT Nazione, SUM(NumPiste)
FROM Aeroporto
WHERE NumPiste >= 20
GROUP BY Nazione 

--------------------
SELECT Citt�, a.Nazione, s.PisteDisponibili
FROM Aeroporto a
JOIN 
(
	SELECT Nazione, MAX(NumPiste) PisteDisponibili
	FROM Aeroporto
	GROUP BY Nazione	 
) s ON a.Nazione = s.Nazione
WHERE a.NumPiste = s.PisteDisponibili
------
SELECT Citt�, b.Nazione, b.piste
FROM Aeroporto a
JOIN 
(
	SELECT Nazione, MAX(NumPiste) piste
	FROM Aeroporto
	GROUP BY Nazione
	HAVING MAX(NumPiste) > 15 
) b ON a.NumPiste = b.piste AND a.Nazione = b.Nazione

SELECT a.Nazione, MAX(a.numPiste) AS MaxPiste, (
SELECT TOP 1 a2.Citt�
FROM Aeroporto AS a2
WHERE a2.Nazione = a2.Nazione AND a2.NumPiste = MAX(a2.NumPiste)
) AS CittaMaxPiste
FROM Aeroporto AS a 
GROUP BY a.Nazione
HAVING MAX(a.NumPiste) >= 15

SELECT *
FROM Aeroporto A1
WHERE NumPiste IN
(
	SELECT max(NumPiste)
	FROM Aeroporto A2
	WHERE A2.Nazione= A1.Nazione
	GROUP BY Nazione
	HAVING max(NumPiste) > 15
)
