
DROP FUNCTION IF EXISTS "update_trajet_arrival_time"() CASCADE;


CREATE OR REPLACE FUNCTION "update_trajet_arrival_time"()
RETURNS TRIGGER AS $$
BEGIN
    -- Vérifier que la "date_arrivee" n'est pas NULL avant d'ajouter du "retard_estime"
    UPDATE "Trajet"
    SET "date_arrivee" = COALESCE("date_arrivee", "date_depart" + INTERVAL '2 hours') + INTERVAL '1 minute' * NEW."retard_estime"
    WHERE "id_trajet" IN (
        SELECT "id_trajet" FROM "TrajetLigne" WHERE "id_ligne" = NEW."id_ligne"
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Supprimer le trigger s'il existe avant de le recréer
DROP TRIGGER IF EXISTS "trigger_update_trajet_arrival" ON "IncidentLigne";

-- Créer le trigger
CREATE TRIGGER "trigger_update_trajet_arrival"
AFTER INSERT ON "IncidentLigne"
FOR EACH ROW
EXECUTE FUNCTION "update_trajet_arrival_time"();
