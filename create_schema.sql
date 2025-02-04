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

-- Table des gares
CREATE TABLE "Gare" (
    "id_gare" INTEGER PRIMARY KEY, -- identifiant de la gare
    "nom" VARCHAR(100), -- nom de la gare
    "localisation" VARCHAR(100), -- localisation de la gare par le nom de la ville dans laquelle elle se trouve
    "equipements" VARCHAR(255), -- equipements de la gare
    "nb_quais" INTEGER CHECK ("nb_quais" >= 0)  -- nombre de quais de la gare, contrainte de positivité
);

-- Table des lignes
CREATE TABLE "Ligne" (
    "id_ligne" INTEGER PRIMARY KEY, -- identifiant de la ligne
    "nom" VARCHAR(100) NOT NULL -- nom de la ligne
);

-- Table des types de train
CREATE TABLE "TypeTrain" (
    "id_type" INTEGER PRIMARY KEY, -- identifiant du type de train
    "nom" VARCHAR(100), -- nom du type de train (ex: TGV, TER, ...)
    "capacite" INTEGER CHECK ("capacite" > 0), -- capacité du train, contrainte de positivité
);

-- Table des trains
CREATE TABLE "Train" (
    "id_train" INTEGER PRIMARY KEY, -- identifiant du train
    "id_type_train" INTEGER NOT NULL, -- identifiant du type de train
    "last_maintenance" TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- date de la dernière maintenance
    "heures_cumulees" INTEGER CHECK ("heures_cumulees" >= 0), -- heures totales de trajet du train, contrainte de positivité
    FOREIGN KEY ("id_type_train") REFERENCES "TypeTrain"("id_type") ON DELETE CASCADE -- clé étrangère vers le type de train
);

CREATE TABLE "Trajet" (
    "id_trajet" INTEGER PRIMARY KEY, -- identifiant du trajet
    "id_gare_depart" INTEGER NOT NULL, -- identifiant de la gare de départ
    "id_gare_arrivee" INTEGER NOT NULL, -- identifiant de la gare d'arrivée
    "date_depart" TIMESTAMP NOT NULL, -- date de départ
    "date_arrivee" TIMESTAMP, -- date d'arrivée
    "distance" INTEGER CHECK ("distance" >= 0),
    FOREIGN KEY ("id_gare_depart") REFERENCES "Gare"("id_gare") ON DELETE CASCADE, -- clé étrangère vers la gare de départ
    FOREIGN KEY ("id_gare_arrivee") REFERENCES "Gare"("id_gare") ON DELETE CASCADE -- clé étrangère vers la gare d'arrivée
);

CREATE TABLE "TrajetLigne" (
    "id_trajet" INTEGER NOT NULL, -- identifiant du trajet
    "id_ligne" INTEGER NOT NULL, -- identifiant de la ligne
    PRIMARY KEY ("id_trajet", "id_ligne"), -- clé primaire composée
    FOREIGN KEY ("id_trajet") REFERENCES "Trajet"("id_trajet") ON DELETE CASCADE, -- clé étrangère vers le trajet
    FOREIGN KEY ("id_ligne") REFERENCES "Ligne"("id_ligne") ON DELETE CASCADE -- clé étrangère vers la ligne
);

CREATE TABLE "TrainLigne" (
    "id_ligne" INTEGER NOT NULL, -- identifiant de la ligne
    "id_train" INTEGER NOT NULL, -- identifiant du train
    PRIMARY KEY ("id_ligne", "id_train"), -- clé primaire composée
    FOREIGN KEY ("id_ligne") REFERENCES "Ligne"("id_ligne") ON DELETE CASCADE, -- clé étrangère vers la ligne
    FOREIGN KEY ("id_train") REFERENCES "Train"("id_train") ON DELETE CASCADE -- clé étrangère vers le train
);

CREATE TABLE "Incident" (
    "id_incident" SERIAL PRIMARY KEY, -- identifiant de l'incident
    "gravite" VARCHAR(50) CHECK ("gravite" IN ('Mineur', 'Majeur', 'Critique')), -- gravité de l'incident (Mineur, Majeur, Critique)
    "description" VARCHAR(255) NOT NULL, -- description de l'incident
    "date_incident" DATE NOT NULL, -- date de l'incident
    "resolu" BOOLEAN DEFAULT FALSE -- indique si l'incident est résolu ou non
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