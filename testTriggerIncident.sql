INSERT INTO Incident (gravite, description, dateIncident, resolu)
VALUES ('Majeur', 'Test incident sur ligne', '2024-04-10', FALSE)
RETURNING idIncident;

INSERT INTO IncidentLigne (idIncident, idLigne, retard_estime)
VALUES ((SELECT idIncident FROM Incident ORDER BY idIncident DESC LIMIT 1), 1, 10);

SELECT * FROM Trajet WHERE idTrajet IN (SELECT idTrajet FROM TrajetLigne WHERE idLigne = 1);