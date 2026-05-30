INSERT INTO auth_user (id, email, password_hash) VALUES
  -- admins
  ('a1000000-0000-0000-0000-000000000001', 'martim.dietterle@alphas.edu.br',  crypt('Alphas@2025!',  gen_salt('bf'))),
  ('a1000000-0000-0000-0000-000000000002', 'andrei.carniel@instituto.edu.br', crypt('Betas@2025!',   gen_salt('bf'))),
  -- amin global
  ('a1000000-0000-0000-0000-000000000003', 'admin@plataforma.com',            crypt('Global@2025!',  gen_salt('bf'))),
  -- alunos Escola dos Alphas (6 alunos)
  ('b2000000-0000-0000-0000-000000000001', 'gabriel.souza@alphas.edu.br',     crypt('Aluno@001',     gen_salt('bf'))),
  ('b2000000-0000-0000-0000-000000000002', 'isabela.ferreira@alphas.edu.br',  crypt('Aluno@002',     gen_salt('bf'))),
  ('b2000000-0000-0000-0000-000000000003', 'lucas.mendes@alphas.edu.br',      crypt('Aluno@003',     gen_salt('bf'))),
  ('b2000000-0000-0000-0000-000000000004', 'mariana.costa@alphas.edu.br',     crypt('Aluno@004',     gen_salt('bf'))),
  ('b2000000-0000-0000-0000-000000000005', 'pedro.oliveira@alphas.edu.br',    crypt('Aluno@005',     gen_salt('bf'))),
  ('b2000000-0000-0000-0000-000000000006', 'julia.lima@alphas.edu.br',        crypt('Aluno@006',     gen_salt('bf'))),
  -- alunos Instituto só para Betas (6 alunos)
  ('c3000000-0000-0000-0000-000000000001', 'rafael.alves@instituto.edu.br',   crypt('Aluno@007',     gen_salt('bf'))),
  ('c3000000-0000-0000-0000-000000000002', 'camila.rocha@instituto.edu.br',   crypt('Aluno@008',     gen_salt('bf'))),
  ('c3000000-0000-0000-0000-000000000003', 'thiago.nunes@instituto.edu.br',   crypt('Aluno@009',     gen_salt('bf'))),
  ('c3000000-0000-0000-0000-000000000004', 'amanda.barbosa@instituto.edu.br', crypt('Aluno@010',     gen_salt('bf'))),
  ('c3000000-0000-0000-0000-000000000005', 'bruno.cardoso@instituto.edu.br',  crypt('Aluno@011',     gen_salt('bf'))),
  -- aluno sem sessão (para tarefa 3 - nunca iniciou simulado)
  ('c3000000-0000-0000-0000-000000000006', 'fernanda.dias@instituto.edu.br',  crypt('Aluno@012',     gen_salt('bf')));


-- 2. UPDATE PROFILES  (é pra corrigir nome e role dos perfis criados automaticamente pelo trigger)

-- Admin Escola dos Alphas
UPDATE profiles SET full_name = 'Martim Dietterle', user_role = 'school_admin'
WHERE auth_user_id = 'a1000000-0000-0000-0000-000000000001';

-- Coordenador Instituto só para Betas
UPDATE profiles SET full_name = 'Andrei Carniel', user_role = 'school_admin'
WHERE auth_user_id = 'a1000000-0000-0000-0000-000000000002';

-- Admin global da plataforma
UPDATE profiles SET full_name = 'Ana Paula Ramos', user_role = 'global_admin'
WHERE auth_user_id = 'a1000000-0000-0000-0000-000000000003';

-- Alunos Escola dos Alphas
UPDATE profiles SET full_name = 'Gabriel Souza'    WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000001';
UPDATE profiles SET full_name = 'Isabela Ferreira' WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000002';
UPDATE profiles SET full_name = 'Lucas Mendes'     WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000003';
UPDATE profiles SET full_name = 'Mariana Costa'    WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000004';
UPDATE profiles SET full_name = 'Pedro Oliveira'   WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000005';
UPDATE profiles SET full_name = 'Julia Lima'       WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000006';

-- Alunos Instituto só para Betas
UPDATE profiles SET full_name = 'Rafael Alves'    WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000001';
UPDATE profiles SET full_name = 'Camila Rocha'    WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000002';
UPDATE profiles SET full_name = 'Thiago Nunes'    WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000003';
UPDATE profiles SET full_name = 'Amanda Barbosa'  WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000004';
UPDATE profiles SET full_name = 'Bruno Cardoso'   WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000005';
UPDATE profiles SET full_name = 'Fernanda Dias'   WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000006';

-- 3. INSTITUTIONS

INSERT INTO institutions (id, name, cnpj, admin_id) VALUES
  (
    'e5000000-0000-0000-0000-000000000001',
    'Escola dos Alphas',
    '12.345.678/0001-99',                         -- CNPJ usado na tarefa 4
    (SELECT id FROM profiles WHERE auth_user_id = 'a1000000-0000-0000-0000-000000000001')
  ),
  (
    'e5000000-0000-0000-0000-000000000002',
    'Instituto só para Betas',
    '98.765.432/0001-11',
    (SELECT id FROM profiles WHERE auth_user_id = 'a1000000-0000-0000-0000-000000000002')
  );

-- 4. QUESTIONS  // questoes feitas com IA

INSERT INTO questions (id, internal_number, statement, alternatives, correct_answer) VALUES

-- Q45 essa aqui vai ser feita com o gabarito errado de proposito
('f6000000-0000-0000-0000-000000000045',
 45,
 '{"texto": "Qual é o resultado de SELECT COUNT(*) FROM tabela WHERE 1=0?"}',
 '{"1": "Erro de sintaxe", "2": "NULL", "3": "0", "4": "1", "5": "Depende do SGBD"}',
 3),   -- gabarito correto = alternativa 3

-- demais questões
('f6000000-0000-0000-0000-000000000001',  1, '{"texto": "Qual comando SQL é usado para recuperar dados?"}',               '{"1":"SELECT","2":"INSERT","3":"UPDATE","4":"DELETE"}', 1),
('f6000000-0000-0000-0000-000000000002',  2, '{"texto": "Qual cláusula filtra resultados em SQL?"}',                       '{"1":"ORDER BY","2":"GROUP BY","3":"WHERE","4":"HAVING"}', 3),
('f6000000-0000-0000-0000-000000000003',  3, '{"texto": "Qual tipo de JOIN retorna apenas registros com correspondência?"}','{"1":"LEFT JOIN","2":"RIGHT JOIN","3":"FULL JOIN","4":"INNER JOIN"}', 4),
('f6000000-0000-0000-0000-000000000004',  4, '{"texto": "O que significa ACID em bancos de dados?"}',                      '{"1":"Atomicidade, Consistência, Isolamento, Durabilidade","2":"Automação, Cache, Índice, Dados","3":"Acesso, Controle, Integridade, Deploy","4":"Nenhuma das anteriores"}', 1),
('f6000000-0000-0000-0000-000000000005',  5, '{"texto": "Qual função SQL retorna o maior valor de uma coluna?"}',           '{"1":"SUM","2":"COUNT","3":"AVG","4":"MAX"}', 4),
('f6000000-0000-0000-0000-000000000006',  6, '{"texto": "O que faz o comando ROLLBACK?"}',                                  '{"1":"Confirma transação","2":"Desfaz transação","3":"Exclui tabela","4":"Cria índice"}', 2),
('f6000000-0000-0000-0000-000000000007',  7, '{"texto": "Qual constraint garante valores únicos em uma coluna?"}',          '{"1":"PRIMARY KEY","2":"FOREIGN KEY","3":"UNIQUE","4":"CHECK"}', 3),
('f6000000-0000-0000-0000-000000000008',  8, '{"texto": "O que é normalização em banco de dados?"}',                        '{"1":"Aumentar redundância","2":"Reduzir redundância e dependências","3":"Criar backups","4":"Encriptar dados"}', 2),
('f6000000-0000-0000-0000-000000000009',  9, '{"texto": "Qual comando cria uma nova tabela?"}',                             '{"1":"ALTER TABLE","2":"DROP TABLE","3":"CREATE TABLE","4":"INSERT INTO"}', 3),
('f6000000-0000-0000-0000-000000000010', 10, '{"texto": "O que é uma chave primária?"}',                                   '{"1":"Coluna que pode ter valores nulos","2":"Coluna que identifica unicamente cada registro","3":"Coluna com valores repetidos","4":"Coluna de texto longo"}', 2),
('f6000000-0000-0000-0000-000000000011', 11, '{"texto": "Qual é a forma correta de comentário em SQL?"}',                  '{"1":"// comentário","2":"<!-- comentário -->","3":"-- comentário","4":"# comentário"}', 3),
('f6000000-0000-0000-0000-000000000012', 12, '{"texto": "O que faz o operador LIKE em SQL?"}',                             '{"1":"Compara valores exatos","2":"Filtra por padrão de texto","3":"Faz junção de tabelas","4":"Agrupa resultados"}', 2),
('f6000000-0000-0000-0000-000000000013', 13, '{"texto": "Qual cláusula é usada para agrupar resultados?"}',                '{"1":"WHERE","2":"ORDER BY","3":"GROUP BY","4":"DISTINCT"}', 3),
('f6000000-0000-0000-0000-000000000014', 14, '{"texto": "O que é uma VIEW em SQL?"}',                                      '{"1":"Tabela física","2":"Índice","3":"Consulta armazenada","4":"Procedure"}', 3),
('f6000000-0000-0000-0000-000000000015', 15, '{"texto": "Qual função retorna o número de registros?"}',                    '{"1":"SUM","2":"MAX","3":"AVG","4":"COUNT"}', 4),
('f6000000-0000-0000-0000-000000000016', 16, '{"texto": "O que é um índice em banco de dados?"}',                          '{"1":"Cópia da tabela","2":"Estrutura que acelera consultas","3":"Tipo de JOIN","4":"Restrição de integridade"}', 2),
('f6000000-0000-0000-0000-000000000017', 17, '{"texto": "O que significa DDL?"}',                                          '{"1":"Data Definition Language","2":"Data Display Language","3":"Dynamic Data Link","4":"Database Drive Layer"}', 1),
('f6000000-0000-0000-0000-000000000018', 18, '{"texto": "Qual comando remove todos os registros de uma tabela sem log?"}', '{"1":"DELETE","2":"DROP","3":"TRUNCATE","4":"REMOVE"}', 3),
('f6000000-0000-0000-0000-000000000019', 19, '{"texto": "O que é um trigger?"}',                                           '{"1":"Tipo de índice","2":"Ação automática disparada por evento","3":"Tipo de chave","4":"Função de agregação"}', 2),
('f6000000-0000-0000-0000-000000000020', 20, '{"texto": "Qual operador verifica se um valor está em uma lista?"}',         '{"1":"BETWEEN","2":"LIKE","3":"IN","4":"EXISTS"}', 3),
('f6000000-0000-0000-0000-000000000021', 21, '{"texto": "O que é uma stored procedure?"}',                                 '{"1":"Tipo de tabela","2":"Bloco de código SQL armazenado no banco","3":"Tipo de restrição","4":"Tipo de JOIN"}', 2),
('f6000000-0000-0000-0000-000000000022', 22, '{"texto": "Qual é o resultado de NULL + 5 em SQL?"}',                        '{"1":"5","2":"0","3":"Erro","4":"NULL"}', 4),
('f6000000-0000-0000-0000-000000000023', 23, '{"texto": "O que faz o HAVING em SQL?"}',                                   '{"1":"Filtra antes do GROUP BY","2":"Filtra após o GROUP BY","3":"Ordena resultados","4":"Faz junção"}', 2),
('f6000000-0000-0000-0000-000000000024', 24, '{"texto": "O que é Row Level Security?"}',                                   '{"1":"Criptografia de linhas","2":"Controle de acesso a nível de linha","3":"Índice por linha","4":"Backup de linhas"}', 2),
('f6000000-0000-0000-0000-000000000025', 25, '{"texto": "Qual keyword elimina duplicatas em SELECT?"}',                    '{"1":"UNIQUE","2":"DISTINCT","3":"DIFFERENT","4":"FILTER"}', 2),
('f6000000-0000-0000-0000-000000000026', 26, '{"texto": "O que é um schema em banco de dados?"}',                          '{"1":"Tipo de backup","2":"Namespace que organiza objetos do banco","3":"Tipo de índice","4":"Arquivo de configuração"}', 2),
('f6000000-0000-0000-0000-000000000027', 27, '{"texto": "Qual operador compara intervalos de valores?"}',                  '{"1":"IN","2":"LIKE","3":"BETWEEN","4":"EXISTS"}', 3),
('f6000000-0000-0000-0000-000000000028', 28, '{"texto": "O que é JSONB no PostgreSQL?"}',                                  '{"1":"Tipo de índice","2":"Formato de armazenamento binário de JSON","3":"Extensão de segurança","4":"Tipo de JOIN"}', 2),
('f6000000-0000-0000-0000-000000000029', 29, '{"texto": "O que faz o ON DELETE CASCADE?"}',                               '{"1":"Impede exclusão do pai","2":"Exclui filhos quando o pai é excluído","3":"Atualiza filhos","4":"Define valor padrão"}', 2),
('f6000000-0000-0000-0000-000000000030', 30, '{"texto": "Qual é a diferença entre CHAR e VARCHAR?"}',                     '{"1":"Sem diferença","2":"CHAR tem tamanho fixo, VARCHAR variável","3":"VARCHAR é mais lento","4":"CHAR aceita nulos, VARCHAR não"}', 2);

-- 5. ENROLLMENTS 

-- Alunos  Alphas
INSERT INTO enrollments (student_id, school_id)
SELECT p.id, 'e5000000-0000-0000-0000-000000000001'
FROM profiles p
JOIN auth_user a ON p.auth_user_id = a.id
WHERE a.email IN (
  'gabriel.souza@alphas.edu.br',
  'isabela.ferreira@alphas.edu.br',
  'lucas.mendes@alphas.edu.br',
  'mariana.costa@alphas.edu.br',
  'pedro.oliveira@alphas.edu.br',
  'julia.lima@alphas.edu.br'
);

-- Alunos Betas
INSERT INTO enrollments (student_id, school_id)
SELECT p.id, 'e5000000-0000-0000-0000-000000000002'
FROM profiles p
JOIN auth_user a ON p.auth_user_id = a.id
WHERE a.email IN (
  'rafael.alves@instituto.edu.br',
  'camila.rocha@instituto.edu.br',
  'thiago.nunes@instituto.edu.br',
  'amanda.barbosa@instituto.edu.br',
  'bruno.cardoso@instituto.edu.br',
  'fernanda.dias@instituto.edu.br' 
);

-- 6. EXAM_SESSION  +  ANSWERS   /  necessario para as questoes que o martin pediu: Cada aluno tem sessões com questões suficientes para atingir mínimo de 100 questões no histórico, Fernanda Dias NÃO tem sessão, questão 45 respondida pelos alunos da Escola dos Alphas

DO $$
DECLARE
  -- profile ids
  p_gabriel   uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000001');
  p_isabela   uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000002');
  p_lucas     uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000003');
  p_mariana   uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000004');
  p_pedro     uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000005');
  p_julia     uuid := (SELECT id FROM profiles WHERE auth_user_id = 'b2000000-0000-0000-0000-000000000006');
  p_rafael    uuid := (SELECT id FROM profiles WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000001');
  p_camila    uuid := (SELECT id FROM profiles WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000002');
  p_thiago    uuid := (SELECT id FROM profiles WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000003');
  p_amanda    uuid := (SELECT id FROM profiles WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000004');
  p_bruno     uuid := (SELECT id FROM profiles WHERE auth_user_id = 'c3000000-0000-0000-0000-000000000005');

  -- session ids 
  -- Alphas - cada aluno tem 4 sessões 
  s_gabriel_1 uuid := 'd7000001-0000-0000-0000-000000000001';
  s_gabriel_2 uuid := 'd7000001-0000-0000-0000-000000000002';
  s_gabriel_3 uuid := 'd7000001-0000-0000-0000-000000000003';
  s_gabriel_4 uuid := 'd7000001-0000-0000-0000-000000000004';

  s_isabela_1 uuid := 'd7000002-0000-0000-0000-000000000001';
  s_isabela_2 uuid := 'd7000002-0000-0000-0000-000000000002';
  s_isabela_3 uuid := 'd7000002-0000-0000-0000-000000000003';
  s_isabela_4 uuid := 'd7000002-0000-0000-0000-000000000004';

  s_lucas_1   uuid := 'd7000003-0000-0000-0000-000000000001';
  s_lucas_2   uuid := 'd7000003-0000-0000-0000-000000000002';
  s_lucas_3   uuid := 'd7000003-0000-0000-0000-000000000003';
  s_lucas_4   uuid := 'd7000003-0000-0000-0000-000000000004';

  s_mariana_1 uuid := 'd7000004-0000-0000-0000-000000000001';
  s_mariana_2 uuid := 'd7000004-0000-0000-0000-000000000002';
  s_mariana_3 uuid := 'd7000004-0000-0000-0000-000000000003';
  s_mariana_4 uuid := 'd7000004-0000-0000-0000-000000000004';

  s_pedro_1   uuid := 'd7000005-0000-0000-0000-000000000001';
  s_pedro_2   uuid := 'd7000005-0000-0000-0000-000000000002';
  s_pedro_3   uuid := 'd7000005-0000-0000-0000-000000000003';
  s_pedro_4   uuid := 'd7000005-0000-0000-0000-000000000004';

  s_julia_1   uuid := 'd7000006-0000-0000-0000-000000000001';
  s_julia_2   uuid := 'd7000006-0000-0000-0000-000000000002';
  s_julia_3   uuid := 'd7000006-0000-0000-0000-000000000003';
  s_julia_4   uuid := 'd7000006-0000-0000-0000-000000000004';

  --  Betas - cada aluno 4 sessões
  s_rafael_1  uuid := 'd7000007-0000-0000-0000-000000000001';
  s_rafael_2  uuid := 'd7000007-0000-0000-0000-000000000002';
  s_rafael_3  uuid := 'd7000007-0000-0000-0000-000000000003';
  s_rafael_4  uuid := 'd7000007-0000-0000-0000-000000000004';

  s_camila_1  uuid := 'd7000008-0000-0000-0000-000000000001';
  s_camila_2  uuid := 'd7000008-0000-0000-0000-000000000002';
  s_camila_3  uuid := 'd7000008-0000-0000-0000-000000000003';
  s_camila_4  uuid := 'd7000008-0000-0000-0000-000000000004';

  s_thiago_1  uuid := 'd7000009-0000-0000-0000-000000000001';
  s_thiago_2  uuid := 'd7000009-0000-0000-0000-000000000002';
  s_thiago_3  uuid := 'd7000009-0000-0000-0000-000000000003';
  s_thiago_4  uuid := 'd7000009-0000-0000-0000-000000000004';

  s_amanda_1  uuid := 'd7000010-0000-0000-0000-000000000001';
  s_amanda_2  uuid := 'd7000010-0000-0000-0000-000000000002';
  s_amanda_3  uuid := 'd7000010-0000-0000-0000-000000000003';
  s_amanda_4  uuid := 'd7000010-0000-0000-0000-000000000004';

  s_bruno_1   uuid := 'd7000011-0000-0000-0000-000000000001';
  s_bruno_2   uuid := 'd7000011-0000-0000-0000-000000000002';
  s_bruno_3   uuid := 'd7000011-0000-0000-0000-000000000003';
  s_bruno_4   uuid := 'd7000011-0000-0000-0000-000000000004';

BEGIN

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_gabriel_1, p_gabriel, 'completed', 27, 24, now() - interval '10 days'),
  (s_gabriel_2, p_gabriel, 'completed', 27, 23, now() - interval '7 days'),
  (s_gabriel_3, p_gabriel, 'completed', 27, 22, now() - interval '4 days'),
  (s_gabriel_4, p_gabriel, 'completed', 27, 23, now() - interval '1 day');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_isabela_1, p_isabela, 'completed', 27, 20, now() - interval '12 days'),
  (s_isabela_2, p_isabela, 'completed', 27, 21, now() - interval '8 days'),
  (s_isabela_3, p_isabela, 'completed', 27, 20, now() - interval '5 days'),
  (s_isabela_4, p_isabela, 'completed', 27, 20, now() - interval '2 days');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_lucas_1, p_lucas, 'completed', 27, 25, now() - interval '15 days'),
  (s_lucas_2, p_lucas, 'completed', 27, 24, now() - interval '10 days'),
  (s_lucas_3, p_lucas, 'completed', 27, 24, now() - interval '6 days'),
  (s_lucas_4, p_lucas, 'completed', 27, 24, now() - interval '2 days');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_mariana_1, p_mariana, 'completed', 27, 19, now() - interval '14 days'),
  (s_mariana_2, p_mariana, 'completed', 27, 19, now() - interval '9 days'),
  (s_mariana_3, p_mariana, 'completed', 27, 19, now() - interval '5 days'),
  (s_mariana_4, p_mariana, 'completed', 27, 19, now() - interval '1 day');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_pedro_1, p_pedro, 'completed', 27, 18, now() - interval '20 days'),
  (s_pedro_2, p_pedro, 'completed', 27, 17, now() - interval '13 days'),
  (s_pedro_3, p_pedro, 'completed', 27, 18, now() - interval '7 days'),
  (s_pedro_4, p_pedro, 'completed', 27, 17, now() - interval '2 days');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_julia_1, p_julia, 'completed', 27, 22, now() - interval '11 days'),
  (s_julia_2, p_julia, 'completed', 27, 21, now() - interval '7 days'),
  (s_julia_3, p_julia, 'completed', 27, 22, now() - interval '4 days'),
  (s_julia_4, p_julia, 'completed', 27, 21, now() - interval '1 day');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_rafael_1, p_rafael, 'completed', 27, 24, now() - interval '13 days'),
  (s_rafael_2, p_rafael, 'completed', 27, 24, now() - interval '9 days'),
  (s_rafael_3, p_rafael, 'completed', 27, 23, now() - interval '5 days'),
  (s_rafael_4, p_rafael, 'completed', 27, 24, now() - interval '1 day');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_camila_1, p_camila, 'completed', 27, 20, now() - interval '16 days'),
  (s_camila_2, p_camila, 'completed', 27, 19, now() - interval '11 days'),
  (s_camila_3, p_camila, 'completed', 27, 20, now() - interval '6 days'),
  (s_camila_4, p_camila, 'completed', 27, 19, now() - interval '2 days');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_thiago_1, p_thiago, 'completed', 27, 16, now() - interval '18 days'),
  (s_thiago_2, p_thiago, 'completed', 27, 16, now() - interval '12 days'),
  (s_thiago_3, p_thiago, 'completed', 27, 17, now() - interval '6 days'),
  (s_thiago_4, p_thiago, 'completed', 27, 16, now() - interval '2 days');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_amanda_1, p_amanda, 'completed', 27, 22, now() - interval '14 days'),
  (s_amanda_2, p_amanda, 'completed', 27, 22, now() - interval '9 days'),
  (s_amanda_3, p_amanda, 'completed', 27, 23, now() - interval '5 days'),
  (s_amanda_4, p_amanda, 'completed', 27, 22, now() - interval '1 day');

INSERT INTO exam_session (id, student_id, session_status, total_questions, total_correct, finished_at) VALUES
  (s_bruno_1, p_bruno, 'completed', 27, 21, now() - interval '17 days'),
  (s_bruno_2, p_bruno, 'completed', 27, 20, now() - interval '11 days'),
  (s_bruno_3, p_bruno, 'completed', 27, 21, now() - interval '5 days'),
  (s_bruno_4, p_bruno, 'completed', 27, 21, now() - interval '1 day');

-- RESPOSTAS

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000024',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000025',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000026',2,true),  -- CORRIGIDO: alt=2=gabarito → true
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_gabriel_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_gabriel_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000023',1,false), -- erra
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000027',2,false), -- erra
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_gabriel_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_gabriel_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- ISABELA FERREIRA
-- Perfil: acerta Q1-Q23, Q28, Q29 | erra Q24(alt=1), Q25(alt=3), Q26(alt=1), Q27(alt=2), Q30(alt=4), Q45(alt=2)
-- Sessões 1 e 2: ~22-23 acertos | Sessões 3 e 4: ~22 acertos
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_isabela_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_isabela_1,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_isabela_1,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_isabela_1,'f6000000-0000-0000-0000-000000000027',2,false), -- erra
  (s_isabela_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_isabela_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_isabela_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_isabela_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000024',2,true),  -- acerta (melhora na sessão 2)
  (s_isabela_2,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_isabela_2,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_isabela_2,'f6000000-0000-0000-0000-000000000027',2,false), -- erra
  (s_isabela_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_isabela_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_isabela_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_isabela_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_isabela_3,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_isabela_3,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_isabela_3,'f6000000-0000-0000-0000-000000000027',2,false), -- erra
  (s_isabela_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_isabela_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_isabela_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_isabela_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000024',1,false), -- erra
  (s_isabela_4,'f6000000-0000-0000-0000-000000000025',3,false), -- erra
  (s_isabela_4,'f6000000-0000-0000-0000-000000000026',1,false), -- erra
  (s_isabela_4,'f6000000-0000-0000-0000-000000000027',2,false), -- erra
  (s_isabela_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_isabela_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_isabela_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- LUCAS MENDES
-- Perfil: muito bom. Acerta Q28, Q29, Q30.
-- Erra Q25(alt=4), Q26(alt=4) em todas as sessões
-- Q45: acerta APENAS sessão 1 (alt=3,true); demais erra
-- Sessão 1: 28 acertos | Sessões 2/3/4: 27 acertos
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_lucas_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000024',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_lucas_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_lucas_1,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_lucas_1,'f6000000-0000-0000-0000-000000000045',3,true);  -- ACERTA Q45 (única exceção)

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_lucas_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000024',2,true), -- erra
  (s_lucas_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_lucas_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_lucas_2,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_lucas_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_lucas_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000024',2,true), -- erra
  (s_lucas_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_lucas_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_lucas_3,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_lucas_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_lucas_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000024',2,true), -- erra
  (s_lucas_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_lucas_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_lucas_4,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_lucas_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- MARIANA COSTA
-- Perfil: fraco. Erra Q19-Q27, Q28, Q29, Q30, Q45.
-- Sessões 1-4: 19 acertos cada
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_mariana_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_mariana_1,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_mariana_1,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_mariana_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_mariana_2,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_mariana_2,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_mariana_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_mariana_3,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_mariana_3,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_mariana_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_mariana_4,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_mariana_4,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

-- ============================================================
-- PEDRO OLIVEIRA
-- Perfil: fraco. Erra a partir de Q18/Q19 em diante + Q28/Q29/Q30/Q45
-- Sessão 1: 18 | Sessão 2: 17 | Sessão 3: 18 | Sessão 4: 17
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_pedro_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_pedro_1,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_pedro_1,'f6000000-0000-0000-0000-000000000045',5,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_pedro_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_pedro_2,'f6000000-0000-0000-0000-000000000017',2,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_pedro_2,'f6000000-0000-0000-0000-000000000045',5,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_pedro_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_pedro_3,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_pedro_3,'f6000000-0000-0000-0000-000000000045',5,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_pedro_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_pedro_4,'f6000000-0000-0000-0000-000000000017',2,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_pedro_4,'f6000000-0000-0000-0000-000000000045',5,false); -- erra Q45

-- ============================================================
-- JULIA LIMA
-- Perfil: bom. Acerta Q28, Q29. Erra Q30, Q45 (exceto sessão 1 acerta Q45).
-- Sessão 1: 24 | Sessões 2/3/4: 23
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_julia_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000022',1,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_julia_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_julia_1,'f6000000-0000-0000-0000-000000000045',3,true);  -- ACERTA Q45!

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_julia_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000022',1,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_julia_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_julia_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_julia_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000022',1,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_julia_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_julia_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_julia_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000022',1,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_julia_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_julia_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- RAFAEL ALVES (Betas)
-- Perfil: bom. Acerta Q28, Q29, Q30. Erra Q25(alt=4), Q26(alt=4), Q27(alt=1).
-- Sessão 3 erra mais: Q23(alt=1), Q24(alt=3) também
-- Sessões 1,2,4: 27 | Sessão 3: 25
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_rafael_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000024',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_rafael_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_rafael_1,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_rafael_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_rafael_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_rafael_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000024',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_rafael_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_rafael_2,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_rafael_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_rafael_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_rafael_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000023',1,false), -- erra
  (s_rafael_3,'f6000000-0000-0000-0000-000000000024',3,false), -- erra
  (s_rafael_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_rafael_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_rafael_3,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_rafael_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_rafael_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_rafael_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000023',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000024',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_rafael_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_rafael_4,'f6000000-0000-0000-0000-000000000027',1,false), -- erra
  (s_rafael_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000030',2,true),
  (s_rafael_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- CAMILA ROCHA (Betas)
-- Perfil: médio. Acerta Q28, Q29. Erra Q21-Q27, Q30, Q45.
-- Sessões 1,3: 22 | Sessões 2,4: 21
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_camila_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_camila_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_camila_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_camila_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000019',2,true), 
  (s_camila_2,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_camila_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_camila_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_camila_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_camila_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_camila_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_camila_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000019',2,true), 
  (s_camila_4,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000027',3,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_camila_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_camila_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- THIAGO NUNES (Betas)
-- Perfil: fraco. Erra Q16 em diante + Q28/Q29/Q30/Q45.
-- Sessões 1,2,3: 16 | Sessão 4: 15
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_thiago_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_thiago_1,'f6000000-0000-0000-0000-000000000016',3,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000017',3,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_thiago_1,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_thiago_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_thiago_2,'f6000000-0000-0000-0000-000000000016',3,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000017',3,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_thiago_2,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_thiago_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_thiago_3,'f6000000-0000-0000-0000-000000000016',2,true),  -- acerta Q16 (melhora pontual)
  (s_thiago_3,'f6000000-0000-0000-0000-000000000017',3,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_thiago_3,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_thiago_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_thiago_4,'f6000000-0000-0000-0000-000000000016',3,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000017',3,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000018',2,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000019',3,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000020',1,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000028',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000029',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_thiago_4,'f6000000-0000-0000-0000-000000000045',4,false); -- erra Q45

-- ============================================================
-- AMANDA BARBOSA (Betas)
-- Perfil: bom. Acerta Q28, Q29. Erra Q23/Q24 (varia), Q25-Q27, Q30, Q45.
-- Sessões 1,2,4: 24 | Sessão 3: 25
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_amanda_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000023',1,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_amanda_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_amanda_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_amanda_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000023',1,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_amanda_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_amanda_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_amanda_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000023',2,true),  -- acerta Q23 (melhor sessão)
  (s_amanda_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_amanda_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_amanda_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_amanda_3,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_amanda_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_amanda_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_amanda_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_amanda_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000022',4,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000023',1,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_amanda_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_amanda_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

-- ============================================================
-- BRUNO CARDOSO (Betas)
-- Perfil: médio. Acerta Q28, Q29. Erra Q22-Q27, Q30, Q45.
-- Sessões 1,3,4: 23 | Sessão 2: 21 (erra Q20 e Q21 também)
-- ============================================================
INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_bruno_1,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_bruno_1,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_bruno_1,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_bruno_2,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000020',2,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000021',3,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_bruno_2,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_bruno_2,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_bruno_3,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_bruno_3,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_bruno_3,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

INSERT INTO answers (session_id, question_id, selected_alternative, is_correct) VALUES
  (s_bruno_4,'f6000000-0000-0000-0000-000000000001',1,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000002',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000003',4,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000004',1,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000005',4,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000006',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000007',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000008',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000009',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000010',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000011',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000012',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000013',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000014',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000015',4,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000016',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000017',1,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000018',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000019',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000020',3,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000021',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000022',3,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000023',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000024',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000025',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000026',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000027',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000028',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000029',2,true),
  (s_bruno_4,'f6000000-0000-0000-0000-000000000030',4,false), -- erra
  (s_bruno_4,'f6000000-0000-0000-0000-000000000045',2,false); -- erra Q45

END $$;
