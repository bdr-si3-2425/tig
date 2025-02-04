-- 2. Quels trains nécessitent une maintenance basée sur leurs heures cumulées de trajet ou des 
-- incidents signalés ?

-- Creation d'une vue pour observer les trains ayant besoin d'une maintenance
-- Il est défini qu'un train nécéssite une maintenance lorsqu'il a voyagé plus de 3000 heures après sa dernière maintenance
-- ou lorsqu'il a eu au moins un incident signalé

CREATE OR REPLACE VIEW "Trains_Necessitant_Maintenance" AS
SELECT t."idTrain", 
       t."heuresCumulees",
       COUNT(it."idIncident") AS "nombre_incidents"
FROM "Train" t
JOIN "TypeTrain" tt ON t."typeTrain" = tt."idType"
LEFT JOIN "IncidentTrain" it ON t."idTrain" = it."idTrain"
GROUP BY t."idTrain", tt."capacite", tt."anneeFabrication", t."heuresCumulees", t."lastMaintenance"
HAVING (t."heuresCumulees" - t."lastMaintenance") > 3000 -- Le dépassement d'heures depuis la dernière maintenance
   OR COUNT(it."idIncident") > 0; -- Lorsqu'il existe au moins 1 incident relié

SELECT * FROM "Trains_Necessitant_Maintenance";