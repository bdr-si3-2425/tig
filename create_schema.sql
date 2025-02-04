DROP TABLE IF EXISTS "IncidentTrain" CASCADE;
DROP TABLE IF EXISTS "IncidentLigne" CASCADE;
DROP TABLE IF EXISTS "IncidentGare" CASCADE;
DROP TABLE IF EXISTS "Incident" CASCADE;
DROP TABLE IF EXISTS "TrajetLigne" CASCADE;
DROP TABLE IF EXISTS "Trajet" CASCADE;
DROP TABLE IF EXISTS "TrainLigne" CASCADE;
DROP TABLE IF EXISTS "Train" CASCADE;
DROP TABLE IF EXISTS "TypeTrain" CASCADE;
DROP TABLE IF EXISTS "Ligne" CASCADE;
DROP TABLE IF EXISTS "Gare" CASCADE;

-- Création des tables 

CREATE TABLE "Gare" (
    "id_gare" SERIAL PRIMARY KEY,
    "nom" VARCHAR(100),
    "localisation" VARCHAR(100),
    "equipements" VARCHAR(255),
    "nb_quais" INTEGER CHECK ("nb_quais" >= 0) 
);

CREATE TABLE "Ligne" (
    "id_ligne" SERIAL PRIMARY KEY,
    "nom" VARCHAR(100) NOT NULL
);

CREATE TABLE "TypeTrain" (
    "id_type" SERIAL PRIMARY KEY,
    "capacite" INTEGER CHECK ("capacite" > 0),
    "annee_fabrication" INTEGER 
);

CREATE TABLE "Train" (
    "id_train" SERIAL PRIMARY KEY,
    "type_train" INTEGER NOT NULL,
    "last_maintenance" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "heures_cumulees" INTEGER CHECK ("heures_cumulees" >= 0),
    FOREIGN KEY ("type_train") REFERENCES "TypeTrain"("id_type") ON DELETE CASCADE
);

CREATE TABLE "Trajet" (
    "id_trajet" SERIAL PRIMARY KEY,
    "id_gare_depart" INTEGER NOT NULL,
    "id_gare_arrivee" INTEGER NOT NULL,
    "date_depart" TIMESTAMP NOT NULL,
    "date_arrivee" TIMESTAMP,
    "distance" INTEGER CHECK ("distance" >= 0),
    FOREIGN KEY ("id_gare_depart") REFERENCES "Gare"("id_gare") ON DELETE CASCADE,
    FOREIGN KEY ("id_gare_arrivee") REFERENCES "Gare"("id_gare") ON DELETE CASCADE
);

CREATE TABLE "TrajetLigne" (
    "id_trajet" INTEGER NOT NULL,
    "id_ligne" INTEGER NOT NULL,
    PRIMARY KEY ("id_trajet", "id_ligne"),
    FOREIGN KEY ("id_trajet") REFERENCES "Trajet"("id_trajet") ON DELETE CASCADE,
    FOREIGN KEY ("id_ligne") REFERENCES "Ligne"("id_ligne") ON DELETE CASCADE
);

CREATE TABLE "TrainLigne" (
    "id_ligne" INTEGER NOT NULL,
    "id_train" INTEGER NOT NULL,
    "date_affectation" DATE,
    PRIMARY KEY ("id_ligne", "id_train"),
    FOREIGN KEY ("id_ligne") REFERENCES "Ligne"("id_ligne") ON DELETE CASCADE,
    FOREIGN KEY ("id_train") REFERENCES "Train"("id_train") ON DELETE CASCADE
);

CREATE TABLE "Incident" (
    "id_incident" SERIAL PRIMARY KEY,
    "gravite" VARCHAR(50) CHECK ("gravite" IN ('Mineur', 'Majeur', 'Critique')),
    "description" VARCHAR(255) NOT NULL,
    "date_incident" DATE NOT NULL,
    "resolu" BOOLEAN DEFAULT FALSE
);

CREATE TABLE "IncidentGare" (
    "id_incident" INTEGER PRIMARY KEY,
    "id_gare" INTEGER NOT NULL,
    FOREIGN KEY ("id_incident") REFERENCES "Incident"("id_incident") ON DELETE CASCADE,
    FOREIGN KEY ("id_gare") REFERENCES "Gare"("id_gare") ON DELETE CASCADE
);

CREATE TABLE "IncidentLigne" (
    "id_incident" INTEGER PRIMARY KEY,
    "id_ligne" INTEGER NOT NULL,
    "retard_estime" INTEGER CHECK ("retard_estime" >= 0),
    FOREIGN KEY ("id_incident") REFERENCES "Incident"("id_incident") ON DELETE CASCADE,
    FOREIGN KEY ("id_ligne") REFERENCES "Ligne"("id_ligne") ON DELETE CASCADE
);

CREATE TABLE "IncidentTrain" (
    "id_incident" INTEGER PRIMARY KEY,
    "id_train" INTEGER NOT NULL,
    FOREIGN KEY ("id_incident") REFERENCES "Incident"("id_incident") ON DELETE CASCADE,
    FOREIGN KEY ("id_train") REFERENCES "Train"("id_train") ON DELETE CASCADE
);