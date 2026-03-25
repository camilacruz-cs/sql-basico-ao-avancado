-- =====================================================
-- FUNÇÕES AGREGADORAS: EXEMPLOS PRÁTICOS
-- =====================================================
-- Descrição: Uso de funções agregadoras e agrupamentos para análise de dados
-- Base: schema sales


-- =====================================================
-- CONTAGENS
-- =====================================================

-- Exemplo 1: Contagem total de visitas
-- Objetivo: entender o volume total de acessos ao site

SELECT COUNT(*) AS total_visitas
FROM sales.funnel;


-- Exemplo 2: Contagem de pagamentos
-- Objetivo: identificar quantos pagamentos foram realizados
-- Observação: COUNT(coluna) ignora valores nulos

SELECT COUNT(paid_date) AS total_pagamentos
FROM sales.funnel;


-- Exemplo 3: Contagem distinta
-- Objetivo: identificar quantos produtos diferentes foram visitados em jan/2021

SELECT COUNT(DISTINCT product_id) AS produtos_distintos
FROM sales.funnel
WHERE visit_page_date BETWEEN '2021-01-01' AND '2021-01-31';


-- =====================================================
-- OUTRAS FUNÇÕES (MIN, MAX, AVG)
-- =====================================================

-- Exemplo 4: Estatísticas de preço
-- Objetivo: entender a distribuição de preços dos produtos

SELECT 
    MIN(price) AS preco_minimo,
    MAX(price) AS preco_maximo,
    AVG(price) AS preco_medio
FROM sales.products;


-- Exemplo 5: Produto mais caro
-- Objetivo: identificar o veículo de maior valor

SELECT *
FROM sales.products
WHERE price = (
    SELECT MAX(price) 
    FROM sales.products
);


-- =====================================================
-- GROUP BY
-- =====================================================

-- Exemplo 6: Clientes por estado
-- Objetivo: analisar distribuição geográfica da base

SELECT 
    state, 
    COUNT(*) AS total_clientes
FROM sales.customers
GROUP BY state
ORDER BY total_clientes DESC;


-- Exemplo 7: Clientes por estado e status profissional
-- Objetivo: segmentar clientes por perfil

SELECT 
    state, 
    professional_status, 
    COUNT(*) AS total_clientes
FROM sales.customers
GROUP BY state, professional_status
ORDER BY total_clientes DESC;


-- Observação: evitar uso de GROUP BY por posição (ex: GROUP BY 1,2)
-- pois reduz a legibilidade da query


-- =====================================================
-- DISTINCT vs GROUP BY
-- =====================================================

-- Exemplo 8: Estados distintos com DISTINCT

SELECT DISTINCT state
FROM sales.customers;

-- Exemplo 9: Estados distintos com GROUP BY

SELECT state
FROM sales.customers
GROUP BY state;


-- =====================================================
-- HAVING
-- =====================================================

-- Exemplo 10: Filtro em agregação
-- Objetivo: identificar estados com mais de 100 clientes

SELECT 
    state,
    COUNT(*) AS total_clientes
FROM sales.customers
GROUP BY state
HAVING COUNT(*) > 100;


-- Exemplo 11: Filtro com múltiplas condições no HAVING
-- Objetivo: excluir estados específicos da análise

SELECT 
    state,
    COUNT(*) AS total_clientes
FROM sales.customers
GROUP BY state
HAVING COUNT(*) > 100
   AND state <> 'MG';
