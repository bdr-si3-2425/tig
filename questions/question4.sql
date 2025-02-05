--Q.4 Comment intégrer une nouvelle ligne ferroviaire dans le réseau existant tout en optimisant
--les correspondances 🦧?

--trouver la gare desservie avec le max de lignes
WITH GareSelectionnee AS (
    SELECT "T"."id_gare_depart" AS "id_gare"
    FROM "Trajet" "T"
    JOIN "TrajetLigne" "TL" ON "T"."id_trajet" = "TL"."id_trajet"
    GROUP BY "T"."id_gare_depart"
    ORDER BY COUNT(DISTINCT "TL"."id_ligne") DESC
    LIMIT 1
),

--recupere les trajets les + empruntes par gare
TrajetsSelectionnes AS (
    SELECT "T"."id_trajet"
    FROM "Trajet" "T"
    WHERE "T"."id_gare_depart" = (SELECT "id_gare" FROM GareSelectionnee)
    ORDER BY RANDOM()
    LIMIT 5
),

-- ajout d'une nouvelle ligne
NouvelleLigne AS (
    INSERT INTO "Ligne" ("nom") VALUES ('Nouvelle Ligne Optimisée') RETURNING "id_ligne"
)

--Associer les trajets sélectionnés à la nouvelle ligne
INSERT INTO "TrajetLigne" ("id_trajet", "id_ligne")
SELECT "T"."id_trajet", (SELECT "id_ligne" FROM NouvelleLigne)
FROM TrajetsSelectionnes "T";












                                                                                                                                                                                                                                                    