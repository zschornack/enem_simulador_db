-- 1) povoar a tabela (feito no arquivo inserts_bd.sql)

-- 2) Escreva uma consulta que liste o nome de todas as escolas cadastradas e a quantidade total de alunos vinculados a cada uma delas. o Regra: Ordene o resultado da escola com mais alunos para a escola com menos alunos

select
  i.name,
  count(e.student_id)
from institutions i
join enrollments e
  on e.school_id = i.id

group by i.id, i.name;

-- 3) Liste o nome completo e o ID de todos os usuários com o perfil de estudante (role = 'student') que nunca iniciaram uma sessão de simulado.

select 
  p.full_name, p.id
from profiles p
left join exam_session es
  on es.student_id = p.id
where p.user_role = 'student'
  and es.id is null;

-- 4) A Tarefa: Crie uma consulta que retorne o nome do aluno, a alternativa escolhida por ele e se a resposta foi considerada correta (is_correct). o Regras: A busca deve trazer apenas as respostas dadas para a questão número 45, e deve ser filtrada exclusivamente para os alunos matriculados na escola cujo CNPJ é '12.345.678/0001-99'.

select
    p.full_name,
    a.selected_alternative,
    a.is_correct
from answers a
join exam_session es
    on es.id = a.session_id
join profiles p
    on p.id = es.student_id
join enrollments e
    on e.student_id = p.id
join institutions i
    on i.id = e.school_id
join questions q
    on q.id = a.question_id
where q.internal_number = 45
    and i.cnpj = '12.345.678/0001-99';

-- 5) A Tarefa: Calcule a taxa média de acerto global por escola. A consulta deve retornar o nome da escola e o percentual de acerto (Total de Acertos / Total de Questões Respondidas). o Regra: Considere apenas as sessões de simulado que já possuem o status de 'completed'

select
    i.name as nome_da_escola,
        (
            sum(es.total_correct)::numeric
            /
            nullif(sum(es.total_questions), 0)
        ) * 100 as taxa_acerto
from exam_session es
join profiles p
    on p.id = es.student_id
join enrollments e
    on e.student_id = p.id
join institutions i
    on i.id = e.school_id
where es.session_status = 'completed'
group by i.id, i.name
order by taxa_acerto desc;


-- 6)  Escreva uma consulta de auditoria que identifique sessões "concluídas" que possuam inconsistência em qualquer um dos totalizadores. A consulta deve cruzar os dados da sessão com a tabela de respostas e retornar a linha caso o total_questions armazenado seja diferente da contagem real de respostas daquela sessão, OU caso o correct_count armazenado seja diferente da contagem real de respostas corretas (is_correct = true). o Retorno Esperado: O ID da sessão, o total_questions armazenado, a contagem real de respostas, o correct_count armazenado e a contagem real de acertos.

-- NOTA PARA O PROFESSOR: nosso gabarito vs respostas tinha algumas incosistencias, e deixamos tudo 100%. caso queira, da para alterar a resposta de alguma sessao para false/true e ver que o codigo abaixo puxa a inconsistencia. 

select
    es.id as session_id,
    es.total_questions as stored_total_questions,
    count(a.id) as real_total_answers,
    es.total_correct as stored_total_correct,
    count(*) filter (
        where a.is_correct = true
    ) as real_total_correct
from exam_session es
left join answers a
    on a.session_id = es.id
where es.session_status = 'completed'
group by
    es.id,
    es.total_questions,
    es.total_correct
having
    es.total_questions <> count(a.id)
    or
    es.total_correct <> count(*) filter (
        where a.is_correct = true
    );


-- 7) A Tarefa: Liste os nomes dos 5 alunos que possuem o maior número absoluto de respostas corretas acumuladas em todo o histórico da plataforma. o Regra de Qualificação: Para evitar que alunos que fizeram poucas questões com 100% de acerto dominem o ranking, inclua apenas alunos que já responderam a um total mínimo de 100 questões (somando todas as suas sessões concluídas). Ordene do maior número de acertos para o menor.

select
    p.full_name,
    count(*) filter (
        where a.is_correct = true
    ) as total_correct_answers,
    count(a.id) as total_answered
from profiles p
join exam_session es
    on es.student_id = p.id
join answers a
    on a.session_id = es.id
where es.session_status = 'completed'
group by p.id, p.full_name
having count(a.id) >= 100
order by total_correct_answers desc
limit 5;
