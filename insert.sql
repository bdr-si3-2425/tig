INSERT INTO "Gare" ("nom", "localisation", "equipements", "nb_quais") VALUES
('Gare de Lyon', 'Paris', 'Extincteurs, Parking, Restaurants', 15),
('Gare du Nord', 'Paris', 'Extincteurs', 18),
('Gare Saint-Charles', 'Marseille', 'Extincteurs', 12),
('Gare Part-Dieu', 'Lyon', 'Extincteurs', 20),
('Gare de Bordeaux', 'Bordeaux', 'Extincteurs', 10);

INSERT INTO "Ligne" ("nom") VALUES
('Paris - Lyon'),
('Paris - Marseille'),
('Lyon - Bordeaux'),
('Bordeaux - Marseille');

INSERT INTO "TypeTrain" ("nom","capacite") VALUES
('TGV',500),
('TER',600),
('TGV',450),
('TER',550);

INSERT INTO "Train" ("id_type_train", "last_maintenance", "heures_cumulees") VALUES
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

INSERT INTO "TrainLigne" ("id_ligne", "id_train") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);