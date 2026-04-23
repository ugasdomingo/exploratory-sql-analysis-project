-- PLEASE READ THIS BEFORE RUNNING THE EXERCISE

-- ⚠️ IMPORTANT: This SQL file may crash due to two common issues: comments and missing semicolons.

-- ✅ Suggestions:
-- 1) Always end each SQL query with a semicolon `;`
-- 2) Ensure comments are well-formed:
--    - Use `--` for single-line comments only
--    - Avoid inline comments after queries
--    - Do not use `/* */` multi-line comments, as they may break execution

-- -----------------------------------------------
-- queries.sql
-- Complete each mission by writing your SQL query
-- directly below the corresponding instruction
-- -----------------------------------------------

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- Your query here;
-- ¿Cuáles son las primeras 10 observaciones registradas?
SELECT * FROM observations LIMIT 10;

-- MISSION 2
-- Your query here;
-- ¿Qué identificadores de región (region_id) aparecen en los datos?
SELECT DISTINCT region_id FROM observations;

-- MISSION 3
-- Your query here;
-- ¿Cuántas especies distintas (species_id) se han observado?
SELECT COUNT(DISTINCT species_id) AS distinct_species_count FROM observations;

-- MISSION 4
-- Your query here;
-- ¿Cuántas observaciones hay para la región con region_id = 2?
SELECT COUNT(*) AS observations_in_region_2 FROM observations WHERE region_id = 2;

-- MISSION 5
-- Your query here;
-- ¿Cuántas observaciones se registraron el día 1998-08-08?
SELECT COUNT(*) AS observations_on_1998_08_08 FROM observations WHERE observation_date = '1998-08-08';

-- MISSION 6
-- Your query here;
-- ¿Cuál es el region_id con más observaciones?
SELECT region_id, COUNT(*) AS observation_count
FROM observations   
GROUP BY region_id
ORDER BY observation_count DESC
LIMIT 1;

-- MISSION 7
-- Your query here;
-- ¿Cuáles son los 5 species_id más frecuentes?
SELECT species_id, COUNT(*) AS frequency
FROM observations
GROUP BY species_id
ORDER BY frequency DESC
LIMIT 5;

-- MISSION 8
-- Your query here;
-- ¿Qué especies (species_id) tienen menos de 5 registros?
SELECT species_id
FROM observations
GROUP BY species_id
HAVING COUNT(*) < 5;

-- MISSION 9
-- Your query here;
-- ¿Qué observadores (observer) registraron más observaciones?
SELECT observer, COUNT(*) AS observation_count
FROM observations
GROUP BY observer
ORDER BY observation_count DESC
LIMIT 1;

-- MISSION 10
-- Your query here;
-- Muestra el nombre de la región (regions.name) para cada observación.
SELECT observations.id, regions.name AS region_name, observations.observation_date
FROM observations
JOIN regions ON observations.region_id = regions.id;

-- MISSION 11
-- Your query here;
-- Muestra el nombre científico de cada especie registrada (species.scientific_name).
SELECT s.scientific_name
FROM species s;

-- MISSION 12
-- Your query here;
-- ¿Cuál es la especie más observada por cada región?
SELECT regions.name AS region, species.scientific_name, COUNT(*) AS total
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY region, species.scientific_name
ORDER BY region, total DESC;

-- MISSION 13
-- Your query here;
-- Inserta una nueva observación ficticia en la tabla observations.
INSERT INTO observations (species_id, region_id, observer, observation_date, count)
VALUES (200, 200, 'test_observer', '2024-01-01', 1);

-- MISSION 14
-- Your query here;
-- Corrige el nombre científico de una especie con error tipográfico.
UPDATE species
SET scientific_name = 'Corrected Tipographical Name'
WHERE scientific_name = 'Incorrect Tipographical Name';

-- MISSION 15
-- Your query here;
-- Elimina una observación de prueba (usa su id).
DELETE FROM observations
WHERE id = 999;