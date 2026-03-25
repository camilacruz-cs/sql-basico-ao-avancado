-- =====================================================
-- 2. LINHAS: INSERT, UPDATE, DELETE
-- =====================================================

-- Inserção de dados
INSERT INTO temp_tables.profissoes
(professional_status, status_profissional)
VALUES
('freelancer', 'freelancer'),
('retired', 'aposentado(a)'),
('clt', 'clt'),
('self_employed', 'autônomo(a)'),
('other', 'outro'),
('businessman', 'empresário(a)'),
('civil_servant', 'funcionário público(a)'),
('student', 'estudante');

-- Inserção adicional
INSERT INTO temp_tables.profissoes
(professional_status, status_profissional)
VALUES
('unemployed', 'desempregado(a)'),
('trainee', 'estagiário(a)');

-- Atualização de dados
UPDATE temp_tables.profissoes
SET professional_status = 'intern'
WHERE status_profissional = 'estagiário(a)';

-- Deleção de linhas
DELETE FROM temp_tables.profissoes
WHERE status_profissional IN ('desempregado(a)', 'estagiário(a)');

-- Visualização final
SELECT * FROM temp_tables.profissoes;
