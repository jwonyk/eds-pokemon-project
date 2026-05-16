-- Which Pokémon type has the highest average total base stats among non-legendary Pokémon?

SELECT 
    ppt.primary_type AS type_name, 
    COUNT(*) AS pokemon_count, 
    ROUND(AVG(pts.total_base_stats), 2) AS avg_total_base_stats
    FROM pokemon_primary_type ppt
        JOIN pokemon_total_stats pts ON ppt.pokemon_id = pts.pokemon_id
        JOIN pokemon p ON ppt.pokemon_id = p.pokemon_id
    WHERE p.is_default = 1
        AND p.species_id NOT IN (SELECT species_id FROM pokemon_species WHERE is_legendary = 1)
        AND p.species_id NOT IN (SELECT species_id FROM pokemon_species WHERE is_mythical = 1)
    GROUP BY ppt.primary_type
    HAVING COUNT(*) >= 5
    ORDER BY avg_total_base_stats DESC;