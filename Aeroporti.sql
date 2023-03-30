CREATE DATABASE Aeroporti
GO
USE Aeroporti
Go

CREATE TABLE Aeroporto(
Città NVARCHAR(50) PRIMARY KEY,
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
	GiornoSett IN ('Lunedì', 'Martedì', 'Mercoledì',
	 'Giovedì', 'Venerdì', 'Sabato', 'Domenica')), 
CittàPart NVARCHAR(50) NOT NULL REFERENCES Aeroporto, 
OraPart TIME  NOT NULL,
CittàArr NVARCHAR(50) NOT NULL REFERENCES Aeroporto, 
OraArr TIME NOT NULL, 
TipoAereo VARCHAR(20) NOT NULL REFERENCES Aereo)

INSERT INTO Volo VALUES ('AZ274','Lunedì', 'Bologna', '12:30:00', 'Tunisi', '13:50', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ275','Venerdì', 'Venezia', '10:00:00', 'Parigi', '12:00', 'Boing_747')
INSERT INTO Volo VALUES ('AZ276','Giovedì', 'Roma', '12:30:00', 'Milano', '13:50', 'Boing_812')
INSERT INTO Volo VALUES ('AZ277','Martedì', 'Djerba', '15:30:00', 'Tolosa', '17:15', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ278','Sabato', 'Bologna', '08:30:00', 'Milano', '09:30', 'Boing_812')
INSERT INTO Volo VALUES ('AZ279','Mercoledì', 'Tunisi', '17:30:00', 'Venezia', '18:50', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ280','Lunedì', 'Bologna', '10:30:00', 'Venezia', '11:30', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ281','Sabato', 'Bologna', '20:30:00', 'Roma', '22:30', 'Airbus_820')
INSERT INTO Volo VALUES ('AZ282','Martedì', 'Venezia', '20:30:00', 'Roma', '21:30', 'Boing_812')
INSERT INTO Volo VALUES ('AZ283','Venerdì', 'Bologna', '20:30:00', 'Roma', '22:30', 'Airbus_820')

SELECT * FROM Aeroporto
SELECT * FROM Aereo
SELECT * FROM Volo
