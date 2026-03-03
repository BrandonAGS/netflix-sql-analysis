# Netflix SQL Analysis

Proyecto de análisis de datos en SQL utilizando una base de datos simulada tipo Netflix.

## Objetivo
Analizar información de series, episodios y actores para extraer métricas de rendimiento, popularidad y consistencia, respondiendo a preguntas de negocio mediante consultas SQL optimizadas.

## Herramientas
* MySQL
* SQL

## Modelo de Datos
El proyecto utiliza un modelo relacional compuesto por:
* Series
* Episodios
* Actores
* Actuaciones

## Habilidades aplicadas
* Consultas SELECT y filtros avanzados (WHERE, HAVING)
* Múltiples JOINs (INNER JOIN) para modelos relacionales
* Agregaciones (COUNT, AVG, MAX, MIN)
* Subconsultas y Subconsultas Correlacionadas
* Common Table Expressions (CTEs) para estructuración y optimización de código
* Window Functions (RANK, ROW_NUMBER, PARTITION BY) para análisis de rankings y partición de datos
* Ordenamientos, LIMIT y resolución de empates (Tie-breakers)

## Ejemplos de análisis
* Series con mejor rating promedio y consistencia de calidad.
* Ranking del Top 3 de episodios mejor calificados por serie.
* Episodios más populares segmentados por año de estreno.
* Participación de actores y minutos totales en pantalla.

## Estructura del proyecto
* `schema.sql` → Creación de tablas
* `data.sql` → Inserción de datos
* `sql_basico.sql` → Consultas básicas con JOINs
* `sql_intermedio.sql` → Consultas intermedias con JOINs, agrupaciones y subconsultas
* `sql_avanzado.sql` → Consultas de nivel senior utilizando CTEs y Window Functions

## Notas
Algunas consultas pueden presentar empates en resultados (ej. múltiples episodios con el mismo rating perfecto); se implementaron criterios lógicos o funciones de ventana representativas para fines de análisis de negocio.
