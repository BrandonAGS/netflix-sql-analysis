-- Ejercicio 1: Ranking por serie, Obtén los episodios mejor calificados por cada serie.
SELECT 
s.titulo AS Titulo_Serie,
e.titulo AS Titulo_Episodio,
e.rating_imdb AS Rating_IMDB,
ROW_NUMBER() OVER(PARTITION BY s.serie_id ORDER BY e.rating_imdb DESC) AS Ranking
FROM series s 
JOIN episodios e 
ON s.serie_id = e.serie_id;

-- Ejercicio 2: Top 3 episodios por serie (RANK)
WITH Ranking_Episodios AS (
SELECT 
s.titulo AS Titulo_Serie,
e.titulo AS Titulo_Episodio,
e.rating_imdb AS Rating_IMDB,
RANK() OVER(PARTITION BY s.serie_id ORDER BY e.rating_imdb DESC) AS Ranking_top3
FROM series s 
JOIN episodios e 
ON s.serie_id = e.serie_id
)
SELECT * FROM Ranking_Episodios 
WHERE Ranking_top3 <= 3;

-- Ejercicio 3: Series más consistentes. Definición: Una serie consistente es la que tiene poco cambio entre su mejor y peor episodio.
WITH stats_series AS (
SELECT
serie_id,
MAX(rating_imdb) AS Mejor_Rating,
MIN(rating_imdb) AS Peor_Rating
FROM episodios
GROUP BY serie_id
)

SELECT 
s.titulo AS Serie,
st.Mejor_Rating,
st.Peor_Rating,
(st.Mejor_Rating - st.Peor_Rating) AS Diferencia_Rating
FROM series s
JOIN stats_series st
ON s.serie_id = st.serie_id
ORDER BY Diferencia_Rating ASC;

-- Ejercicio 4: Episodio más popular por año
WITH ranking AS (
    SELECT
        YEAR(e.fecha_estreno) AS Año,
        e.titulo AS Episodio,
        s.titulo AS Serie,
        e.rating_imdb,
        ROW_NUMBER() OVER (
            PARTITION BY YEAR(e.fecha_estreno)
            ORDER BY e.rating_imdb DESC
        ) AS lugar
    FROM series s 
    JOIN episodios e
        ON s.serie_id = e.serie_id
)
SELECT 
    Año,
    Episodio,
    Serie,
    rating_imdb
FROM ranking
WHERE lugar = 1;

-- Ejercicio 5: Buscar títulos con REGEXP
-- Encuentra episodios cuyo título: Contengan palabras como: Love, Death, War.

SELECT
titulo AS Episodio
FROM episodios
WHERE titulo REGEXP '(?i)love|war|death';

-- Ejercicio 6: Series con tendencia a mejorar. 
-- Definición: Series cuyo rating promedio de sus últimos 3 episodios sea mayor que el promedio general.
WITH ultimos_3 AS (
SELECT
s.titulo AS Serie,
e.fecha_estreno,
e.rating_imdb AS rating,
ROW_NUMBER() OVER(PARTITION BY e.serie_id ORDER BY e.fecha_estreno DESC) AS lista,
AVG(e.rating_imdb) OVER(PARTITION BY e.serie_id) AS Promedio_Total
FROM series s
JOIN episodios e
ON s.serie_id = e.serie_id
)
SELECT 
Serie,
AVG(rating) AS promedio_ultimos_3,
Promedio_Total
FROM ultimos_3
WHERE lista IN (1,2,3)
GROUP BY Serie, Promedio_Total
HAVING AVG(rating) > Promedio_Total;

-- Ejercicio 7: Encuentra la serie que tiene más episodios, Pero con rating promedio mayor a 8.
SELECT
s.titulo AS Serie,
COUNT(e.episodio_id) AS Total_episodios,
AVG(e.rating_imdb) AS Rating_Promedio
FROM series s 
JOIN episodios e 
ON s.serie_id = e.serie_id
GROUP BY s.serie_id
HAVING Rating_Promedio > 8
ORDER BY Total_Episodios DESC
LIMIT 1;














