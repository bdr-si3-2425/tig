INSERT INTO "Incident" ("gravite", "description", "date_incident", "resolu")
VALUES ('Majeur', 'Test incident sur ligne', '2024-04-01', FALSE)
RETURNING "id_incident";

INSERT INTO "IncidentLigne" ("id_incident", "id_ligne", "retard_estime")
VALUES ((SELECT "id_incident" FROM "Incident" ORDER BY "id_incident" DESC LIMIT 1), 1, 10);


SELECT * FROM "Trajet" ORDER BY "date_depart";
