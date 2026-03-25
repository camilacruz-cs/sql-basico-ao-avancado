-- =====================================================
-- DESAFIO DO MÓDULO: UNION
-- =====================================================
-- Descrição: Combinação de múltiplas tabelas com mesma estrutura
-- Base: sales + temp_tables


-- =====================================================
-- Exercício 1: União de tabelas de produtos
-- Objetivo: consolidar dados de produtos de diferentes fontes
-- Técnica: UNION ALL
-- =====================================================

SELECT *
FROM sales.products

UNION ALL

SELECT *
FROM temp_tables.products_2;
