-- =====================================================
-- 1. TABELAS: CRIAÇÃO & DELEÇÃO
-- =====================================================

-- Criação de tabela a partir de SELECT
SELECT 
    customer_id,
    datediff('y', birth_date, CURRENT_DATE) AS idade_cliente
INTO temp_tables.customers_age
FROM sales.customers;

-- Visualizar tabela criada
SELECT * FROM temp_tables.customers_age;


-- Criação de tabela do zero
CREATE TABLE temp_tables.profissoes (
    professional_status VARCHAR,
    status_profissional VARCHAR
);

-- Deleção de tabela
DROP TABLE IF EXISTS temp_tables.profissoes;
