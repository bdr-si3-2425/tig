-- 2. Quels trains nécessitent une maintenance basée sur leurs heures cumulées de trajet ou des 
-- incidents signalés ?

-- Creation d'une vue pour observer les trains ayant besoin d'une maintenance
-- Il est défini qu'un train nécéssite une maintenance lorsqu'il a voyagé plus de 3000 heures après sa dernière maintenance
-- ou lorsqu'il a eu au moins un incident signalé

CREATE OR REPLACE VIEW "Trains_Necessitant_Maintenance" AS
SELECT t."id_train", 
       t."heures_cumulees",
       COUNT(it."id_incident") AS "nombre_incidents"
FROM "Train" t
JOIN "TypeTrain" tt ON t."id_type_train" = tt."id_type"
LEFT JOIN "IncidentTrain" it ON t."id_train" = it."id_train"
GROUP BY t."id_train", tt."capacite", t."heures_cumulees", t."last_maintenance"
HAVING (t."heures_cumulees" - EXTRACT(EPOCH FROM (CURRENT_TIMESTAMP - t."last_maintenance")) / 3600) > 3000 -- Le dépassement d'heures depuis la dernière maintenance
   OR COUNT(it."id_incident") > 0; -- Lorsqu'il existe au moins 1 incident relié

SELECT * FROM "Trains_Necessitant_Maintenance";