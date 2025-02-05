-- 1. Quels trajets reliant deux gares données minimisent les correspondances ou les temps
-- d’attente ?

DROP FUNCTION IF EXISTS trajets_minimisant_correspondances_ou_attente( VARCHAR, VARCHAR );

CREATE OR REPLACE FUNCTION trajets_minimisant_correspondances_ou_attente( 
    -- Utilisation d'une fonction pour pouvoir etre plus flexible 
    -- sur la requete qui va etre faite au niveau des arguments qui vont
    -- pouvoir etre dynamiques
    gare_depart VARCHAR(50), -- Nom de la gare de départ (plus parlant et facile a obtenir que l'id)
    gare_arrivee VARCHAR(50)
)
RETURNS TABLE (
    -- On va retourner les informations du trajet
    id_trajet INTEGER, 
    id_gare_depart INTEGER,
    id_gare_arrivee INTEGER,
    date_depart TIMESTAMP,
    date_arrivee TIMESTAMP,
    nb_correspondances INTEGER
) AS $$
BEGIN
    RETURN QUERY -- Necessaire pour pouvoir retourner une requete sql
    WITH RECURSIVE "trajets_mini" AS (
        SELECT 
            t.id_trajet,
            t.id_gare_depart,
            t.id_gare_arrivee,
            t.date_depart,
            t.date_arrivee,
            0 AS nb_correspondances -- On initialise le nombre de correspondances à 0 (Initialisation)
        FROM "Trajet" t
        JOIN "Gare" g1 ON t.id_gare_depart = g1.id_gare
        JOIN "Gare" g2 ON t.id_gare_arrivee = g2.id_gare
        WHERE g1.nom = gare_depart -- On commence par la gare de départ
        
        UNION ALL
        
        SELECT 
            t.id_trajet,
            tm.id_gare_depart,
            t.id_gare_arrivee,
            tm.date_depart,
            t.date_arrivee,
            tm.nb_correspondances + 1 -- On incrémente le nombre de correspondances
        FROM "Trajet" t
        JOIN "trajets_mini" tm ON t.id_gare_depart = tm.id_gare_arrivee -- On fait une jointure avec les trajets précédents
    )
    SELECT tm.id_trajet, tm.id_gare_depart, tm.id_gare_arrivee, tm.date_depart, tm.date_arrivee, tm.nb_correspondances
    FROM "trajets_mini" tm
    WHERE tm.id_gare_arrivee = (SELECT g.id_gare FROM "Gare" g WHERE g.nom = gare_arrivee) -- On filtre sur la gare d'arrivée
    ORDER BY tm.nb_correspondances ASC, tm.date_arrivee - tm.date_depart ASC
    LIMIT 1; -- Retourne le trajet le plus optimisé vu que la table est triée et qu'on en retourne qu'un seul
END;
$$ LANGUAGE plpgsql;


-- Tests

-- Attendu : 4 | 1 | 5 | 2024-04-01 08:00:00 | 2024-04-04 09:30:00 | 1
-- Trajet depuis Gare de Lyon vers Gare de Part-Dieu
-- Trajet depuis Gare de Part-Dieu vers Gare de Bordeaux
-- 1 correspondance

SELECT * FROM trajets_minimisant_correspondances_ou_attente('Gare de Lyon', 'Gare de Bordeaux');


-- Attendu : 3 | 2 | 3 | 2024-04-03 07:30:00 | 2024-04-03 10:15:00 | 0
-- Trajet depuis Gare du Nord vers Gare Saint-Charles
-- Pas de correspondance

SELECT * FROM trajets_minimisant_correspondances_ou_attente('Gare du Nord', 'Gare Saint-Charles');