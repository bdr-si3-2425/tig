INSERT INTO "Gare" ("nom", "localisation", "equipements", "nbQuais") VALUES
('Gare de Lyon', 'Paris', 'WiFi, Parking, Restaurants', 15),
('Gare du Nord', 'Paris', 'WiFi, Restaurants', 18),
('Gare Saint-Charles', 'Marseille', 'Parking, Ascenseurs, Consignes', 12),
('Gare Part-Dieu', 'Lyon', 'WiFi, Parking, Commerces', 20),
('Gare de Bordeaux', 'Bordeaux', 'WiFi, Consignes, Loueurs de voitures', 10);

INSERT INTO "Ligne" ("nom") VALUES
('Paris - Lyon'),
('Paris - Marseille'),
('Lyon - Bordeaux'),
('Bordeaux - Marseille');

INSERT INTO "TypeTrain" ("capacite", "anneeFabrication") VALUES
(500, 2015),
(600, 2018),
(450, 2012),
(550, 2020);

INSERT INTO "Train" ("typeTrain", "lastMaintenance", "heuresCumulees") VALUES
(1, '2024-01-10', 12000),
(2, '2024-02-15', 15000),
(3, '2023-12-05', 10000),
(4, '2024-03-20', 18000);

INSERT INTO "Trajet" ("idGareDepart", "idGareArrivee", "dateDepart", "dateArrivee", "distance") VALUES
(1, 4, '2024-04-01 08:00:00', '2024-04-01 11:30:00', 450),
(1, 3, '2024-04-02 09:00:00', '2024-04-02 12:45:00', 750),
(2, 3, '2024-04-03 07:30:00', '2024-04-03 10:15:00', 775),
(4, 5, '2024-04-04 06:00:00', '2024-04-04 09:30:00', 600);

INSERT INTO "TrajetLigne" ("idTrajet", "idLigne") VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

INSERT INTO "TrainLigne" ("idLigne", "idTrain", "dateAffectation") VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02'),
(3, 3, '2024-04-03'),
(4, 4, '2024-04-04');

