-- Ejercicio 1: Obtén las series cuyo rating promedio sea mayor al rating promedio general de todas las series.
SELECT 
s.titulo AS Titulo_Serie,
AVG(e.rating_imdb) AS Rating_Promedio
FROM series AS s
JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY s.titulo
HAVING AVG(e.rating_imdb) > (SELECT AVG(promedio_por_serie) AS promedio_general FROM
(SELECT serie_id, AVG(rating_imdb) AS promedio_por_serie FROM episodios GROUP BY serie_id ) AS Todas_Promedio)

ORDER BY Rating_Promedio DESC;

-- Ejercicio 2: Muestra los episodios que tengan un rating mayor al promedio de su propia serie.
SELECT 
s_principal.titulo AS Titulo_Serie,
e_principal.titulo AS Titulo_Episodio,
e_principal.rating_imdb AS Rating_Episodios
FROM episodios AS e_principal
JOIN series AS s_principal
ON e_principal.serie_id = s_principal.serie_id
WHERE e_principal.rating_imdb > (
    SELECT AVG(e_sub.rating_imdb)
    FROM episodios AS e_sub
    WHERE e_sub.serie_id = e_principal.serie_id
)
ORDER BY Titulo_Serie ASC,  Rating_Episodios DESC;

-- Ejercicio 3: Obtén los actores que hayan participado en más episodios que el promedio de actores.
SELECT
a.nombre AS Actor,
COUNT(e.episodio_id) AS Episodios_Participado
FROM actuaciones ac
JOIN actores a 
    ON a.actor_id = ac.actor_id
JOIN episodios e
    ON ac.serie_id = e.serie_id
GROUP BY a.actor_id
HAVING COUNT(e.episodio_id) > (
    SELECT AVG(episodios_por_actor)
    FROM (
        SELECT COUNT(e2.episodio_id) AS episodios_por_actor
        FROM actuaciones ac2
        JOIN episodios e2
            ON ac2.serie_id = e2.serie_id
        GROUP BY ac2.actor_id
    ) AS sub
);

    
-- Ejercicio 4: Clasifica las series según su rating promedio: ≥ 8 → “Excelente”, 6–7.9 → “Buena, < 6 → “Regular”
SELECT 
s.titulo AS Titulo_Serie,
AVG(e.rating_imdb) AS Rating_Promedio,
CASE 
WHEN AVG(e.rating_imdb) >= 8 THEN 'Excelente'
WHEN AVG(e.rating_imdb) BETWEEN 6 AND 7.9 THEN 'Buena'
ELSE 'Regular'
END AS Clasificacion
FROM series AS s
JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY s.titulo
ORDER BY Rating_Promedio DESC;

-- Ejercicio 5: Usa IF para mostrar: "Larga” si una serie tiene más de 20 episodios, “Corta” si no.
SELECT 
s.titulo AS Serie,
COUNT(e.episodio_id) AS Cantidad_Episodios,
IF(COUNT(e.episodio_id)> 20, 'Larga', 'Corta') AS Categoria
FROM series AS s
JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY s.serie_id
ORDER BY COUNT(e.episodio_id) DESC;

-- Ejercicio 6: Obtén cuántas series se lanzaron por año.
SELECT 
Año_lanzamiento,
COUNT(*) AS Cantidad_Serie_Por_Año
FROM series
GROUP BY año_lanzamiento
ORDER BY año_lanzamiento ASC;

-- Ejercicio 7: Muestra las series lanzadas en los últimos 10 años usando CURDATE().
SELECT 
titulo AS Serie,
año_lanzamiento
FROM series
WHERE año_lanzamiento >= YEAR(CURDATE()) -  10;

-- Ejercicio 8: Muestra el título en: MAYÚSCULAS, y la longitud del título.
SELECT  
UPPER(titulo) AS Titulo_Mayusculas,
LENGTH(titulo) AS Longitud_Titulo
FROM series;

-- Ejercicio 9: Muestra los primeros 5 caracteres del título concatenados con el año.
SELECT
CONCAT(SUBSTR(titulo, 1, 5), ' - ', año_lanzamiento) AS Concatenado
FROM series;

-- Ejercicio 10: Muestra el rating promedio de cada serie: redondeado a 2 decimales, y hacia arriba.
SELECT 
s.titulo AS 'Serie', 
ROUND(AVG(e.rating_imdb),2) AS Promedio_Redondeado,
CEILING(AVG(e.rating_imdb)) AS Hacia_arriba
FROM series AS s
JOIN episodios AS e
ON s.serie_id = e.serie_id
GROUP BY s.serie_id
