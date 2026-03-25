# 📊 Projeto 1 - Dashboard de Vendas

## 🎯 Objetivo

Criar um dashboard de vendas com os principais indicadores de desempenho e com os principais drivers dos resultados do mês.

---

## 📁 Base de Dados

As análises foram realizadas a partir das seguintes tabelas:

* `sales.funnel` → eventos do funil (visitas e compras)
* `sales.products` → informações dos produtos
* `sales.customers` → dados dos clientes
* `sales.stores` → informações das lojas

---

## 📊 Métricas Principais

* Leads (#)
* Vendas (#)
* Receita (R$)
* Conversão (%)
* Ticket médio (R$)

---

## 🧠 Query 1 - Performance Mensal

WITH 
leads AS (
    SELECT
        DATE_TRUNC('month', visit_page_date)::DATE AS mes,
        COUNT(*) AS leads
    FROM sales.funnel
    GROUP BY mes
),

payments AS (
    SELECT
        DATE_TRUNC('month', fun.paid_date)::DATE AS mes,
        COUNT(fun.paid_date) AS vendas,
        SUM(pro.price * (1 + fun.discount)) AS receita
    FROM sales.funnel AS fun
    LEFT JOIN sales.products AS pro
        ON fun.product_id = pro.product_id
    WHERE fun.paid_date IS NOT NULL
    GROUP BY mes
)

SELECT
    l.mes,
    l.leads,
    COALESCE(p.vendas, 0) AS vendas,
    COALESCE(p.receita, 0) / 1000 AS receita_k,
    
    CASE 
        WHEN l.leads > 0 THEN p.vendas::FLOAT / l.leads
        ELSE 0
    END AS conversao,
    
    CASE 
        WHEN p.vendas > 0 THEN p.receita / p.vendas / 1000
        ELSE 0
    END AS ticket_medio_k

FROM leads l
LEFT JOIN payments p
    ON l.mes = p.mes
ORDER BY l.mes;


## 🌍 Query 2 - Estados que Mais Venderam

SELECT
    'Brazil' AS pais,
    cus.state AS estado,
    COUNT(*) AS vendas

FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id

WHERE fun.paid_date BETWEEN DATE '2021-08-01' AND DATE '2021-08-31'

GROUP BY pais, estado
ORDER BY vendas DESC
LIMIT 5;


## 🚗 Query 3 - Marcas que Mais Venderam


SELECT
    pro.brand AS marca,
    COUNT(*) AS vendas

FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
    ON fun.product_id = pro.product_id

WHERE fun.paid_date BETWEEN DATE '2021-08-01' AND DATE '2021-08-31'

GROUP BY marca
ORDER BY vendas DESC
LIMIT 5;

## 🏪 Query 4 - Lojas que Mais Venderam


SELECT
    sto.store_name AS loja,
    COUNT(*) AS vendas

FROM sales.funnel AS fun
LEFT JOIN sales.stores AS sto
    ON fun.store_id = sto.store_id

WHERE fun.paid_date BETWEEN DATE '2021-08-01' AND DATE '2021-08-31'

GROUP BY loja
ORDER BY vendas DESC
LIMIT 5;




## 📅 Query 5 - Dias da Semana com Mais Visitas


SELECT
    EXTRACT(DOW FROM visit_page_date) AS dia_semana_num,
    
    CASE 
        WHEN EXTRACT(DOW FROM visit_page_date) = 0 THEN 'domingo'
        WHEN EXTRACT(DOW FROM visit_page_date) = 1 THEN 'segunda'
        WHEN EXTRACT(DOW FROM visit_page_date) = 2 THEN 'terça'
        WHEN EXTRACT(DOW FROM visit_page_date) = 3 THEN 'quarta'
        WHEN EXTRACT(DOW FROM visit_page_date) = 4 THEN 'quinta'
        WHEN EXTRACT(DOW FROM visit_page_date) = 5 THEN 'sexta'
        WHEN EXTRACT(DOW FROM visit_page_date) = 6 THEN 'sábado'
    END AS dia_semana,

    COUNT(*) AS visitas

FROM sales.funnel
WHERE visit_page_date BETWEEN DATE '2021-08-01' AND DATE '2021-08-31'

GROUP BY dia_semana_num, dia_semana
ORDER BY dia_semana_num;


---

## 📊 Insights de Negócio

A partir das análises, é possível responder:

* 📈 Como a receita evolui ao longo do tempo
* 🔄 Qual a taxa de conversão do funil
* 💰 Qual o ticket médio por venda
* 🌍 Quais estados concentram mais vendas
* 🏪 Quais lojas e marcas performam melhor
* 📅 Em quais dias há maior volume de visitas


