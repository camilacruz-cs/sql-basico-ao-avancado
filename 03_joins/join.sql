-- Descrição: Integração de múltiplas tabelas para geração de insights
-- Base: schema sales + temp_tables

-- =====================================================
-- Exercício 1: Perfil profissional dos compradores
-- Objetivo: identificar o status profissional mais comum entre clientes que realizaram compras
-- Técnica: JOIN + COUNT
-- =====================================================

SELECT 
    cus.professional_status,
    COUNT(fun.paid_date) AS total_pagamentos
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id
WHERE fun.paid_date IS NOT NULL
GROUP BY cus.professional_status
ORDER BY total_pagamentos DESC;


-- =====================================================
-- Exercício 2: Gênero dos compradores
-- Objetivo: identificar o gênero mais frequente entre clientes que compraram
-- Técnica: múltiplos JOINs + tratamento de texto
-- =====================================================

SELECT 
    ibge.gender,
    COUNT(fun.paid_date) AS total_pagamentos
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.ibge_genders AS ibge
    ON LOWER(cus.first_name) = LOWER(ibge.first_name)
WHERE fun.paid_date IS NOT NULL
GROUP BY ibge.gender
ORDER BY total_pagamentos DESC;


-- =====================================================
-- Exercício 3: Região com mais visitas
-- Objetivo: identificar de quais regiões vêm os usuários mais engajados
-- Técnica: JOIN + GROUP BY
-- =====================================================

SELECT 
    reg.region,
    COUNT(fun.visit_page_date) AS total_visitas
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.regions AS reg 
    ON LOWER(cus.city) = LOWER(reg.city) 
   AND LOWER(cus.state) = LOWER(reg.state)
GROUP BY reg.region 
ORDER BY total_visitas DESC;
