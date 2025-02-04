DROP TABLE IF EXISTS IncidentTrain CASCADE;
DROP TABLE IF EXISTS IncidentLigne CASCADE;
DROP TABLE IF EXISTS IncidentGare CASCADE;
DROP TABLE IF EXISTS Incident CASCADE;
DROP TABLE IF EXISTS TrajetLigne CASCADE;
DROP TABLE IF EXISTS Trajet CASCADE;
DROP TABLE IF EXISTS TrainLigne CASCADE;
DROP TABLE IF EXISTS Train CASCADE;
DROP TABLE IF EXISTS TypeTrain CASCADE;
DROP TABLE IF EXISTS Ligne CASCADE;
DROP TABLE IF EXISTS Gare CASCADE;

-- Création des tables 

CREATE TABLE Gare (
    id_gare SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    localisation VARCHAR(100),
    equipements VARCHAR(255),
    nbQuais INTEGER CHECK (nbQuais >= 0) 
);

CREATE TABLE Ligne (
    id_ligne SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL
);

CREATE TABLE TypeTrain (
    idType SERIAL PRIMARY KEY,
    capacite INTEGER CHECK (capacite > 0),
    anneeFabrication INTEGER 
);

CREATE TABLE Train (
    idTrain SERIAL PRIMARY KEY,
    typeTrain INTEGER NOT NULL,
    lastMaintenance TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    heuresCumulees INTEGER CHECK (heuresCumulees >= 0),
    FOREIGN KEY (typeTrain) REFERENCES TypeTrain(idType) ON DELETE CASCADE
);

CREATE TABLE Trajet (
    idTrajet SERIAL PRIMARY KEY,
    idGareDepart INTEGER NOT NULL,
    idGareArrivee INTEGER NOT NULL,
    dateDepart TIMESTAMP NOT NULL,
    dateArrivee TIMESTAMP,
    distance INTEGER CHECK (distance >= 0),
    FOREIGN KEY (idGareDepart) REFERENCES Gare(id_gare) ON DELETE CASCADE,
    FOREIGN KEY (idGareArrivee) REFERENCES Gare(id_gare) ON DELETE CASCADE
);

CREATE TABLE TrajetLigne (
    idTrajet INTEGER NOT NULL,
    idLigne INTEGER NOT NULL,
    PRIMARY KEY (idTrajet, idLigne),
    FOREIGN KEY (idTrajet) REFERENCES Trajet(idTrajet) ON DELETE CASCADE,
    FOREIGN KEY (idLigne) REFERENCES Ligne(id_ligne) ON DELETE CASCADE
);

CREATE TABLE TrainLigne (
    idLigne INTEGER NOT NULL,
    idTrain INTEGER NOT NULL,
    dateAffectation DATE,
    PRIMARY KEY (idLigne, idTrain),
    FOREIGN KEY (idLigne) REFERENCES Ligne(id_ligne) ON DELETE CASCADE,
    FOREIGN KEY (idTrain) REFERENCES Train(idTrain) ON DELETE CASCADE
);

CREATE TABLE Incident (
    idIncident SERIAL PRIMARY KEY,
    gravite VARCHAR(50) CHECK (gravite IN ('Mineur', 'Majeur', 'Critique')),
    description VARCHAR(255) NOT NULL,
    dateIncident TIMESTAMP NOT NULL,
    resolu BOOLEAN DEFAULT FALSE
);

CREATE TABLE IncidentGare (
    idIncident INTEGER PRIMARY KEY,
    idGare INTEGER NOT NULL,
    FOREIGN KEY (idIncident) REFERENCES Incident(idIncident) ON DELETE CASCADE,
    FOREIGN KEY (idGare) REFERENCES Gare(id_gare) ON DELETE CASCADE
);

CREATE TABLE IncidentLigne (
    idIncident INTEGER PRIMARY KEY,
    idLigne INTEGER NOT NULL,
    retard_estime INTEGER CHECK (retard_estime >= 0),
    FOREIGN KEY (idIncident) REFERENCES Incident(idIncident) ON DELETE CASCADE,
    FOREIGN KEY (idLigne) REFERENCES Ligne(id_ligne) ON DELETE CASCADE
);

CREATE TABLE IncidentTrain (
    idIncident INTEGER PRIMARY KEY,
    idTrain INTEGER NOT NULL,
    FOREIGN KEY (idIncident) REFERENCES Incident(idIncident) ON DELETE CASCADE,
    FOREIGN KEY (idTrain) REFERENCES Train(idTrain) ON DELETE CASCADE
);
