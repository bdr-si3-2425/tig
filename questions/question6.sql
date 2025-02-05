WITH TrainsAffectes AS (
    -- On cherche à trouver les trains affectés en effectuant une jointure avec incidentLigne
    SELECT DISTINCT tl."id_train"
    FROM "TrainLigne" tl
    JOIN "IncidentLigne" il ON tl."id_ligne" = il."id_ligne"
    WHERE il."id_incident" IS NOT NULL -- On prend uniquement les trains appartenant à une ligne ayant une correspondance dans incidentLigne
),
TrainsDisponibles AS (
    -- De manière analogue, on cherche les trains disponibles
    SELECT t."id_train", t."id_type_train", t."heures_cumulees", t."last_maintenance"
    FROM "Train" t
    LEFT JOIN "IncidentTrain" it ON t."id_train" = it."id_train"
    WHERE it."id_incident" IS NULL 
)
-- Liste des trains qui ne sont pas affectés par tous les incidentsLigne
SELECT td.*
FROM TrainsDisponibles td
LEFT JOIN TrainsAffectes ta ON td."id_train" = ta."id_train"
WHERE ta."id_train" IS NULL ORDER BY td."id_train";