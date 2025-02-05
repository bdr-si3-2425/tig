-- 3. Quelles sont les gares ayant une saturation de trafic selon les heures de pointe ?
-- Ici, on considère les heures de pointe comme étant entre 7h et 9h et entre 17h et 19h.

CREATE OR REPLACE FUNCTION gares_saturation_trafic()
RETURNS TABLE (
    -- On va retourner toutes les informations de la gare
    id_gare INTEGER,
    nom_gare VARCHAR(100),
    localisation_gare VARCHAR(100),
    equipements_gare VARCHAR(255),
    nb_quais_gare INTEGER,
    nb_trains INTEGER
) AS $$
BEGIN
    RETURN QUERY -- Necessaire pour pouvoir retourner une requete sql
    WITH "trains_heures_pointe" AS ( -- On va récupérer tous les trains qui circulent pendant les heures de pointe
        SELECT 
            tl.id_ligne,
            t.id_train,
            t.id_type_train,
            t.last_maintenance,
            t.heures_cumulees,
            tt.capacite
        FROM "TrainLigne" tlt
        JOIN "Train" t ON tlt.id_train = t.id_train
        JOIN "TypeTrain" tt ON t.id_type_train = tt.id_type
        JOIN "TrajetLigne" tl ON tlt.id_ligne = tl.id_ligne
        JOIN "Trajet" tr ON tl.id_trajet = tr.id_trajet -- Cela signifie donc que le train est affecté à un trajet dont la date de départ/arrivée est dans les heures de pointe
        WHERE EXTRACT(HOUR FROM tr.date_depart) BETWEEN 7 AND 9
            OR EXTRACT(HOUR FROM tr.date_arrivee) BETWEEN 17 AND 19
    )
    SELECT  -- On récupère les informations des gares
        g.id_gare,
        g.nom AS nom_gare,
        g.localisation AS localisation_gare,
        g.equipements AS equipements_gare,
        g.nb_quais AS nb_quais_gare,
        COUNT(thp.id_train)::INTEGER AS nb_trains
    FROM "Gare" g
    JOIN "Trajet" tr ON g.id_gare = tr.id_gare_depart
    JOIN "trains_heures_pointe" thp ON tr.id_trajet = thp.id_ligne
    GROUP BY g.id_gare
    ORDER BY COUNT(thp.id_train) DESC;
END;
$$ LANGUAGE plpgsql;

-- Test de la fonction
SELECT * FROM gares_saturation_trafic();