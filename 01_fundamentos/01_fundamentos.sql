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
