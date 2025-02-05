SELECT i."id_incident",
       i."gravite",
       i."description",
       i."date_incident",
       SUM(il."retard_estime") AS "retard_total",
       COUNT(DISTINCT tl."id_trajet") AS "trajets_affectés"
FROM "Incident" i
JOIN "IncidentLigne" il ON i."id_incident" = il."id_incident" -- jointure entre l'incident et la ligne où elle il intervient
JOIN "TrajetLigne" tl ON il."id_ligne" = tl."id_ligne" --jointure entre la ligne et tous les trajets qui y appartiennent
GROUP BY i."id_incident", i."gravite", i."description", i."date_incident"
ORDER BY "trajets_affectés" DESC, "retard_total" DESC
LIMIT 10;
