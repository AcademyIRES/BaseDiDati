SELECT * FROM Volo
SELECT * FROM Aeroporto
SELECT * FROM Aereo

--Definire la logica
DECLARE @tipoAereo VARCHAR(20) 
SELECT @tipoAereo = TipoAereo FROM Aereo WHERE TipoAereo = 'Airbus_820' 
PRINT 'Aereo in esame: ' + @tipoAereo
IF NOT EXISTS(SELECT 1 FROM Aereo WHERE TipoAereo = @tipoAereo AND QtaMerci > 0)
	PRINT 'Questo Aereo non è adatto'
ELSE
	PRINT 'Questo Aereo è adatto'

--Creazione del trigger
CREATE TRIGGER TR_QTA_Merci ON Volo
FOR INSERT, UPDATE
AS
DECLARE @tipoAereo VARCHAR(20)
DECLARE @cittaPar NVARCHAR(50)
SELECT @tipoAereo = TipoAereo, @cittaPar = CittàPart FROM inserted
IF NOT EXISTS(SELECT 1 FROM Aereo WHERE TipoAereo = @tipoAereo AND QtaMerci > 0) AND @cittaPar = 'Bologna'
BEGIN
	ROLLBACK TRAN
END


-- Fare delle prove
INSERT INTO Volo VALUES ('AZ285','Venerdì', 'Venezia', '20:30:00', 'Roma', '22:30', 'Airbus_820')
UPDATE Volo SET TipoAereo = 'Airbus_820' WHERE IdVolo = 'AZ284'
DELETE FROM Volo WHERE IdVolo = 'AZ284'

