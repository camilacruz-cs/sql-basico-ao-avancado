-- =====================================================
-- DESAFIO DO MÓDULO: SUBQUERIES
-- =====================================================
-- Descrição: Uso de subqueries em diferentes contextos (WHERE, WITH, FROM, SELECT)
-- Base: schema sales


-- =====================================================
-- Exercício 1: Veículo mais barato
-- Objetivo: identificar o produto com menor preço
-- Técnica: subquery no WHERE
-- =====================================================

SELECT *
FROM sales.products
WHERE price = (
    SELECT MIN(price) 
    FROM sales.products
);


-- =====================================================
-- Exercício 2: Idade média por status profissional (WITH)
-- Objetivo: analisar perfil etário por segmento
-- Técnica: CTE (Common Table Expression)
-- =====================================================

WITH base_idades AS (
    SELECT
        professional_status,
        (CURRENT_DATE - birth_date) / 365 AS idade
    FROM sales.customers
)

SELECT 
    professional_status, 
    AVG(idade) AS idade_media
FROM base_idades
GROUP BY professional_status
ORDER BY idade_media DESC;


-- =====================================================
-- Exercício 3: Idade média por status profissional (subquery no FROM)
-- Objetivo: mesma análise sem CTE
-- Técnica: subquery inline
-- =====================================================

SELECT 
    professional_status, 
    AVG(idade) AS idade_media
FROM (
    SELECT
        professional_status,
        (CURRENT_DATE - birth_date) / 365 AS idade
    FROM sales.customers
) AS base_idades
GROUP BY professional_status
ORDER BY idade_media DESC;


-- =====================================================
-- Exercício 4: Visitas acumuladas por loja
-- Objetivo: calcular crescimento de visitas ao longo do tempo
-- Técnica: subquery correlacionada
-- =====================================================

SELECT
    fun.visit_id,
    fun.visit_page_date,
    sto.store_name,
    (
        SELECT COUNT(*)
        FROM sales.funnel AS fun2
        WHERE fun2.visit_page_date <= fun.visit_page_date
          AND fun2.store_id = fun.store_id
    ) AS visitas_acumuladas
FROM sales.funnel AS fun
LEFT JOIN sales.stores AS sto
    ON fun.store_id = sto.store_id
ORDER BY sto.store_name, fun.visit_page_date;

-- =====================================================
-- Exercício 5: Análise de recorrência dos leads
-- Objetivo: separar primeiras visitas de visitas recorrentes
-- Técnica: CTE + lógica booleana
-- =====================================================

WITH primeira_visita AS (
    SELECT 
        customer_id, 
        MIN(visit_page_date) AS data_primeira_visita
    FROM sales.funnel
    GROUP BY customer_id
)

SELECT	
    fun.visit_page_date, 
    (fun.visit_page_date <> pv.data_primeira_visita) AS lead_recorrente,
    COUNT(*) AS total_visitas
FROM sales.funnel AS fun
LEFT JOIN primeira_visita AS pv
    ON fun.customer_id = pv.customer_id
GROUP BY fun.visit_page_date, lead_recorrente
ORDER BY fun.visit_page_date DESC, lead_recorrente;


-- =====================================================
-- Exercício 6: Preço vs preço médio da marca
-- Objetivo: analisar se o veículo visitado está caro ou barato
-- Técnica: CTE + JOIN + cálculo
-- =====================================================

WITH preco_medio AS ( 
    SELECT 
        brand, 
        AVG(price) AS preco_medio_marca
    FROM sales.products 
    GROUP BY brand
)

SELECT 	
    fun.visit_id,
    fun.visit_page_date,
    pro.brand,
    (pro.price * (1 + fun.discount)) AS preco_final,
    pm.preco_medio_marca,
    
    -- diferença absoluta
    (pro.price * (1 + fun.discount)) - pm.preco_medio_marca AS diferenca_preco,
    
    -- classificação (nível negócio)
    CASE 
        WHEN (pro.price * (1 + fun.discount)) > pm.preco_medio_marca THEN 'acima da média'
        WHEN (pro.price * (1 + fun.discount)) < pm.preco_medio_marca THEN 'abaixo da média'
        ELSE 'na média'
    END AS classificacao_preco

FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
    ON fun.product_id = pro.product_id
LEFT JOIN preco_medio AS pm
    ON pro.brand = pm.brand;
