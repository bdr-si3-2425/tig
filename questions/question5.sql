-- 5.Gestion des infrastructures ferroviaires et des trajets interconnectés
--touver des trajets alternatifs en cas d'incident sur une ligne

WITH TrajetsImpactes AS (
    SELECT "T"."id_gare_depart", "T"."id_gare_arrivee"
    FROM "IncidentLigne" "IL"
    JOIN "TrajetLigne" "TL" ON "IL"."id_ligne" = "TL"."id_ligne"
    JOIN "Trajet" "T" ON "TL"."id_trajet" = "T"."id_trajet"
    WHERE "IL"."id_ligne" = 5 -- Ligne impactée (Nice - Paris)
)
SELECT DISTINCT "T"."id_trajet", "G1"."nom" AS "gare_depart", "G2"."nom" AS "gare_arrivee", "L"."nom" AS "ligne_alternative"
FROM "Trajet" "T"
JOIN "TrajetLigne" "TL" ON "T"."id_trajet" = "TL"."id_trajet"
JOIN "Ligne" "L" ON "TL"."id_ligne" = "L"."id_ligne"
JOIN "Gare" "G1" ON "T"."id_gare_depart" = "G1"."id_gare"
JOIN "Gare" "G2" ON "T"."id_gare_arrivee" = "G2"."id_gare"
WHERE ("T"."id_gare_depart", "T"."id_gare_arrivee") IN (
    SELECT "id_gare_depart", "id_gare_arrivee" FROM TrajetsImpactes
)
AND "TL"."id_ligne" != 5; -- Enlever la ligne impactée
