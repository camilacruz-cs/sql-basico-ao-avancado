-- ARQUIVO: fundamentos.sql
-- DESCRIÇÃO: Exemplos de comandos básicos em SQL
-- BASE: schema sales

-- =====================================================
-- SELECT
-- =====================================================

-- Exemplo 1: Seleção de uma coluna
-- Objetivo: listar os e-mails dos clientes

SELECT email
FROM sales.customers;


-- Exemplo 2: Seleção de múltiplas colunas
-- Objetivo: listar e-mail e nome dos clientes

SELECT email, first_name, last_name
FROM sales.customers;


-- Exemplo 3: Seleção de todas as colunas

SELECT *
FROM sales.customers;


-- =====================================================
-- DISTINCT
-- =====================================================

-- Exemplo 1: Sem DISTINCT

SELECT brand
FROM sales.products;


-- Exemplo 2: Com DISTINCT

SELECT DISTINCT brand
FROM sales.products;


-- Exemplo 3: DISTINCT com múltiplas colunas

SELECT DISTINCT model_year, brand
FROM sales.products;


-- =====================================================
-- WHERE
-- =====================================================

-- Exemplo 1: Filtro simples

SELECT email, state
FROM sales.customers
WHERE state = 'SC';


-- Exemplo 2: Múltiplas condições

SELECT email, state
FROM sales.customers
WHERE state = 'SC' OR state = 'MS';


-- Exemplo 3: Filtro com data

SELECT email, state, birth_date
FROM sales.customers
WHERE (state = 'SC' OR state = 'MS')
  AND birth_date < '1991-08-17';


-- =====================================================
-- ORDER BY
-- =====================================================

-- Exemplo 1: Ordenação por preço (decrescente)

SELECT *
FROM sales.products
ORDER BY price DESC;


-- Exemplo 2: Ordenação de texto

SELECT DISTINCT state
FROM sales.customers
ORDER BY state;


-- =====================================================
-- LIMIT
-- =====================================================

-- Exemplo 1: Primeiras linhas

SELECT *
FROM sales.funnel
LIMIT 10;


-- Exemplo 2: Top 10 produtos mais caros

SELECT *
FROM sales.products
ORDER BY price DESC
LIMIT 10;

-- =====================================================
-- OPERADORES
-- =====================================================
-- Descrição: Uso de operadores para filtragem e manipulação de dados

-- =====================================================
-- Exemplo 1: BETWEEN
-- Objetivo: selecionar veículos com preço entre 100k e 200k
-- Técnica: BETWEEN para melhorar legibilidade
-- =====================================================

-- Forma tradicional
SELECT *
FROM sales.products
WHERE price >= 100000 AND price <= 200000;

-- Forma recomendada
SELECT *
FROM sales.products
WHERE price BETWEEN 100000 AND 200000;


-- =====================================================
-- Exemplo 2: NOT + BETWEEN
-- Objetivo: selecionar veículos fora da faixa de preço
-- Técnica: NOT BETWEEN
-- =====================================================

-- Forma tradicional
SELECT *
FROM sales.products
WHERE price < 100000 OR price > 200000;

-- Forma recomendada
SELECT *
FROM sales.products
WHERE price NOT BETWEEN 100000 AND 200000;


-- =====================================================
-- Exemplo 3: IN e NOT IN
-- Objetivo: filtrar por múltiplos valores
-- Técnica: IN para simplificar múltiplos OR
-- =====================================================

-- Forma tradicional
SELECT *
FROM sales.products
WHERE brand = 'HONDA' OR brand = 'TOYOTA' OR brand = 'RENAULT';

-- Forma recomendada
SELECT *
FROM sales.products
WHERE brand IN ('HONDA', 'TOYOTA', 'RENAULT');

-- Exclusão de valores
SELECT *
FROM sales.products
WHERE brand NOT IN ('HONDA', 'TOYOTA', 'RENAULT');


-- =====================================================
-- Exemplo 4: LIKE
-- Objetivo: buscar padrões em texto
-- Técnica: uso de curingas (%)
-- =====================================================

-- Começa com 'ANA'
SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name LIKE 'ANA%';

-- Termina com 'ANA'
SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name LIKE '%ANA';


-- =====================================================
-- Exemplo 5: ILIKE
-- Objetivo: busca sem diferenciar maiúsculas/minúsculas
-- =====================================================

SELECT DISTINCT first_name
FROM sales.customers
WHERE first_name ILIKE 'ana%';


-- =====================================================
-- Exemplo 6: IS NULL
-- Objetivo: identificar valores nulos
-- =====================================================

SELECT *
FROM temp_tables.regions
WHERE population IS NULL;
