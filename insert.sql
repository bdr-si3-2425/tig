INSERT INTO "Gare" ("nom", "localisation", "equipements", "nb_quais") VALUES
('Gare de Lyon', 'Paris', 'Extincteurs', 15), -- Cette gare va etre utilisée pour la question 1, elle sera le départ
('Gare du Nord', 'Paris', 'Extincteurs', 18),
('Gare Saint-Charles', 'Marseille', 'Extincteurs', 12),
('Gare Part-Dieu', 'Lyon', 'Extincteurs', 20),
('Gare de Bordeaux', 'Bordeaux', 'Extincteurs', 10); -- Cette gare va etre utilisée pour la question 1, elle sera l'arrivée

INSERT INTO "Ligne" ("nom") VALUES
('Paris - Lyon'),
('Paris - Marseille'),
('Lyon - Bordeaux'),
('Bordeaux - Marseille');

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
(1, 4, '2024-04-01 08:00:00', '2024-04-01 11:30:00', 450), -- Ce trajet va nous servir pour le test de la question 1
(1, 3, '2024-04-02 09:00:00', '2024-04-02 12:45:00', 750),
(2, 3, '2024-04-03 07:30:00', '2024-04-03 10:15:00', 775),
(4, 5, '2024-04-04 06:00:00', '2024-04-04 09:30:00', 600); -- lui aussi

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
