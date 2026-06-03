-- =====================================================
-- Exercício S01 — SELECT, WHERE e ORDER BY
-- Banco: sakila
-- Data: 03/06/2026
-- =====================================================

USE sakila;

SELECT
    title,
    length,
    rating
FROM film
WHERE rating IN ('PG', 'PG-13')  
ORDER BY length DESC              
LIMIT 10;  

-- Resultado: 10 filmes retornados, todos com duração entre 180-185 min