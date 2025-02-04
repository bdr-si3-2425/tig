CREATE OR REPLACE FUNCTION update_trajet_arrival_time()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la date d'arrivée n'est pas NULL avant d'ajouter du retard
    UPDATE Trajet
    SET dateArrivee = COALESCE(dateArrivee, dateDepart + INTERVAL '2 hours') + INTERVAL '1 minute' * NEW.retard_estime
    WHERE idTrajet IN (
        SELECT idTrajet FROM TrajetLigne WHERE idLigne = NEW.idLigne
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_trajet_arrival
AFTER INSERT ON IncidentLigne
FOR EACH ROW
EXECUTE FUNCTION update_trajet_arrival_time();
