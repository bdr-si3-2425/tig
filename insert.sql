INSERT INTO "Gare" ("nom", "localisation", "equipements", "nb_quais") VALUES
('Gare de Lyon', 'Paris', 'Extincteurs, Parking, Restaurants', 15),
('Gare du Nord', 'Paris', 'Extincteurs', 18),
('Gare Saint-Charles', 'Marseille', 'Extincteurs', 12),
('Gare Part-Dieu', 'Lyon', 'Extincteurs', 20),
('Gare de Bordeaux', 'Bordeaux', 'Extincteurs', 10),
('Gare de Nice', 'Nice', 'Extincteurs, Parking, Restaurants', 12),
('Gare d’Avignon', 'Avignon', 'Extincteurs, Distributeurs', 8),
('Gare de Montpellier', 'Montpellier', 'Extincteurs, Wifi', 10),
('Gare de Toulouse', 'Toulouse', 'Extincteurs, WC', 14);

INSERT INTO "Ligne" ("nom") VALUES
('Paris - Lyon'),
('Paris - Marseille'),
('Lyon - Bordeaux'),
('Bordeaux - Marseille'),
('Nice - Paris'),
('Montpellier - Paris');

INSERT INTO "TypeTrain" ("capacite", "annee_fabrication") VALUES
(500, 2015),
(600, 2018),
(450, 2012),
(550, 2020);

INSERT INTO "Train" ("type_train", "last_maintenance", "heures_cumulees") VALUES
(1, '2024-01-10', 12000),
(2, '2024-02-15', 15000),
(3, '2023-12-05', 10000),
(4, '2024-03-20', 18000);

INSERT INTO "Trajet" ("id_gare_depart", "id_gare_arrivee", "date_depart", "date_arrivee", "distance") VALUES
(1, 4, '2024-04-01 08:00:00', '2024-04-01 11:30:00', 450),
(1, 3, '2024-04-02 09:00:00', '2024-04-02 12:45:00', 750),
(2, 3, '2024-04-03 07:30:00', '2024-04-03 10:15:00', 775),
(4, 5, '2024-04-04 06:00:00', '2024-04-04 09:30:00', 600);

INSERT INTO "TrajetLigne" ("id_trajet", "id_ligne") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO "TrainLigne" ("id_ligne", "id_train", "date_affectation") VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02'),
(3, 3, '2024-04-03'),
(4, 4, '2024-04-04');

-- Ajout d'incidents généraux
INSERT INTO "Incident" ("gravite", "description", "date_incident", "resolu") VALUES
('Majeur', 'Panne électrique sur la ligne Paris - Lyon', '2024-04-02', FALSE),
('Critique', 'Déraillement mineur à la Gare du Nord', '2024-04-03', FALSE),
('Mineur', 'Problème de signalisation sur la ligne Lyon - Bordeaux', '2024-04-04', TRUE),
('Majeur', 'Train en panne sur la ligne Bordeaux - Marseille', '2024-04-05', FALSE);

-- Ajout d'un incident sur une gare (ex : Gare du Nord)
INSERT INTO "IncidentGare" ("id_incident", "id_gare") VALUES
(2, 2); -- Incident critique à la Gare du Nord

-- Ajout d'incidents sur des lignes (ex : Paris - Lyon, Lyon - Bordeaux, Bordeaux - Marseille)
INSERT INTO "IncidentLigne" ("id_incident", "id_ligne", "retard_estime") VALUES
(1, 1, 90),--retard estimé de 90 minutes
(3, 3, 45), -- retard de 45 minutes
(4, 4, 120); -- Train en panne , retard estimé de 120 minutes

-- Ajout d'un incident sur un train (ex : Train affecté à la ligne Bordeaux - Marseille)
INSERT INTO "IncidentTrain" ("id_incident", "id_train") VALUES
(4, 4); -- Train en panne sur la ligne 4


INSERT INTO "Ligne" ("nom") VALUES
('Nice - Paris');

-- Ajout de trajets pour la ligne Nice - Paris
INSERT INTO "Trajet" ("id_gare_depart", "id_gare_arrivee", "date_depart", "date_arrivee", "distance") VALUES
(6, 7, '2024-04-06 07:00:00', '2024-04-06 08:30:00', 250),  -- Nice -> Avignon
(7, 8, '2024-04-06 09:00:00', '2024-04-06 10:30:00', 200),  -- Avignon -> Montpellier
(8, 9, '2024-04-06 11:00:00', '2024-04-06 12:45:00', 300),  -- Montpellier -> Toulouse
(9, 4, '2024-04-06 13:30:00', '2024-04-06 15:00:00', 350),  -- Toulouse -> Lyon Part-Dieu
(4, 1, '2024-04-06 16:00:00', '2024-04-06 19:00:00', 450);  -- Lyon -> Paris

-- Associer ces trajets à la ligne "Nice - Paris"
INSERT INTO "TrajetLigne" ("id_trajet", "id_ligne") VALUES
(5, 5),
(6, 5),
(7, 5),
(8, 5),
(9, 5);


-- Incident sur la ligne "Nice - Paris"
INSERT INTO "Incident" ("gravite", "description", "date_incident", "resolu") VALUES
('Majeur', 'Incident technique sur la ligne Nice - Paris', '2024-04-08', FALSE);

-- Associer l’incident à la ligne
INSERT INTO "IncidentLigne" ("id_incident", "id_ligne", "retard_estime") VALUES
(5, 5,130);  -- Incident affectant la ligne Nice - Paris


--Ligne Nice-Bordeaux
INSERT INTO "Ligne" ("nom") VALUES
('Nice - Bordeaux');

-- Ajout de trajets pour la ligne Nice - Bordeaux
INSERT INTO "Trajet" ("id_gare_depart", "id_gare_arrivee", "date_depart", "date_arrivee", "distance") VALUES
(6, 7, '2024-04-07 07:00:00', '2024-04-07 08:30:00', 250),  -- Nice -> Avignon (même trajet que Nice - Paris)
(7, 8, '2024-04-07 09:00:00', '2024-04-07 10:30:00', 200),  -- Avignon -> Montpellier (même trajet que Nice - Paris)
(8, 5, '2024-04-07 11:00:00', '2024-04-07 13:00:00', 400), -- Montpellier -> Bordeaux (différent)
(5, 2, '2024-04-07 14:00:00', '2024-04-07 17:00:00', 600); -- Bordeaux -> Paris (différent)

-- Associer ces trajets à la ligne "Nice - Bordeaux"
INSERT INTO "TrajetLigne" ("id_trajet", "id_ligne") VALUES
(10, 6),
(11, 6),
(12, 6),
(13, 6);

-- Ajout de trajets pour la ligne Montpellier - Paris
--Trajet Montpellier-Toulouse-Lyon-Paris
INSERT INTO "Trajet" ("id_gare_depart", "id_gare_arrivee", "date_depart", "date_arrivee", "distance") VALUES
(8, 9, '2024-04-08 07:00:00', '2024-04-08 09:00:00', 400),  -- Montpellier -> Toulouse
(9, 4, '2024-04-08 10:00:00', '2024-04-08 13:00:00', 600), --  Toulouse -> Lyon 
(4, 1, '2024-04-08 14:00:00', '2024-04-08 17:00:00', 450);  -- Lyon -> Paris

INSERT INTO "Ligne" ("nom") VALUES
('Montpellier - Paris');

INSERT INTO "TrajetLigne" ("id_trajet", "id_ligne") VALUES
(14, 7),
(15, 7),
(16, 7);