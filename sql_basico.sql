-- Pregunta 1: Lista todas las series disponibles
SELECT titulo, año_lanzamiento, genero FROM series;

-- Pregunta 2: Muestra los títulos de series ordenados por año de lanzamiento (más recientes primero)
SELECT titulo, año_lanzamiento FROM series ORDER BY año_lanzamiento DESC;

-- Pregunta 3: ¿Qué series son del género “Ciencia ficción”?
SELECT * FROM series WHERE genero = 'Ciencia ficción';

-- Pregunta 4: Lista todos los episodios de la serie Breaking Bad
SELECT titulo, temporada, rating_imdb FROM episodios WHERE serie_id = 1;

-- Pregunta 5: Muestra todos los episodios con rating mayor o igual a 9
SELECT * FROM episodios WHERE rating_imdb >= 9;

-- Pregunta 6: ¿Cuántos episodios tiene cada serie?
SELECT 
s.titulo AS 'Titulo_Serie',
COUNT(e.episodio_id) AS 'Total_episodios'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1;

-- Pregunta 7: ¿Cuál es el rating promedio por serie?
SELECT 
s.titulo AS 'Titulo_Serie',
AVG(e.rating_imdb) AS 'Promedio_rating'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1;

-- Pregunta 8: ¿Qué series tienen más de 10 episodios registrados?
SELECT
s.titulo AS 'Titulo_Serie', 
COUNT(e.episodio_id) AS 'Total_episodios'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1
HAVING total_episodios > 10;

-- Pregunta 9: ¿Cuántos episodios hay por temporada en cada serie? 
SELECT
s.titulo AS 'Titulo_Serie',
e.temporada AS 'Temporada',
COUNT(e.episodio_id) AS 'Total_Episodios'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1, 2;

-- Pregunta 10: Muestra: nombre del actor, título de la serie, personaje
SELECT 
a.nombre AS 'Nombre_Actor',
s.titulo AS 'Titulo_Serie',
aca.personaje AS 'Personaje'
FROM actuaciones AS aca
INNER JOIN series AS s
ON aca.serie_id = s.serie_id
INNER JOIN actores AS a
ON a.actor_id = aca.actor_id;

-- Pregunta 11: ¿Cuántos actores tiene cada serie? 
SELECT
s.titulo AS 'Titulo_Serie',
COUNT(a.actor_id) AS 'Total_Actores'
FROM series AS s
INNER JOIN actuaciones AS a
ON s.serie_id = a.serie_id
GROUP BY 1;

-- Pregunta 12: Lista todas las series en las que ha participado Henry Cavill
SELECT 
a.nombre AS 'Nombre_Actor',
s.titulo AS 'Titulo_Serie'
FROM actuaciones AS aca
INNER JOIN series AS s
ON aca.serie_id = s.serie_id
INNER JOIN actores AS a
ON a.actor_id = aca.actor_id
WHERE a.nombre = 'Henry Cavill';

-- Pregunta 13: ¿Qué actores han participado en más de una serie? 
-- Nota: No hay ningun actor que haya participado en mas de una.
SELECT
s.titulo AS 'Titulo_Serie',
a.nombre AS 'Nombre_Actor',
COUNT(DISTINCT aca.serie_id) AS 'Total_Series'
FROM actuaciones AS aca
INNER JOIN series AS s
ON aca.serie_id = s.serie_id
INNER JOIN actores AS a
ON a.actor_id = aca.actor_id
GROUP BY 1,2
HAVING total_series > 1;

-- Pregunta 14: ¿Cuáles son las 5 series con mejor rating promedio?
SELECT
s.titulo AS 'Titulo',
AVG(e.rating_imdb) AS 'Promedio_rating'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1
ORDER BY promedio_rating DESC
LIMIT 5;

-- Pregunta 15:¿Qué géneros tienen mejor rating promedio?
SELECT 
s.genero AS 'Genero',
AVG(e.rating_imdb) AS 'Promedio_rating'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY 1
ORDER BY promedio_rating DESC;

-- Pregunta 16: ¿Cuál es la serie con el episodio mejor calificado?
-- Nota: Se utiliza LIMIT 5 debido a empates en el rating.
SELECT 
s.titulo AS 'Titulo_Serie',
e.titulo AS 'Titulo_Episodio',
e.rating_imdb AS 'Rating'
FROM series AS s
INNER JOIN episodios AS e
ON s.serie_id = e.serie_id
-- GROUP BY 1,2
ORDER BY Rating DESC
LIMIT 5;

-- Pregunta 17: ¿Qué actor participa en la serie con más episodios?
-- Nota: Se utiliza LIMIT 4 debido a empates en el Total episodios.
SELECT 
a.nombre AS 'Nombre_Actor',
s.titulo AS 'Titulo_Serie',
COUNT(e.episodio_id) AS 'Total_episodios'
FROM actuaciones AS aca
INNER JOIN actores AS a
ON a.actor_id = aca.actor_id
INNER JOIN series AS s
ON s.serie_id = aca.serie_id
INNER JOIN episodios AS e
ON e.serie_id = s.serie_id
GROUP BY 1, 2
ORDER BY total_episodios DESC
LIMIT 4;
