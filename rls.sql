alter table profiles     enable row level security;
alter table enrollments  enable row level security;
alter table institutions enable row level security;
alter table exam_session enable row level security;
alter table answers      enable row level security;
alter table questions    enable row level security;

create policy student_select_own_profile
on profiles for select
using (auth_users_id = auth.uid());

create policy student_update_own_profile
on profiles for update
using (auth_users_id = auth.uid());

create policy student_select_own_enrollments
on enrollments for select
using (
    student_id in (
        select id from profiles where auth_users_id = auth.uid()
    )
);

create policy student_select_own_sessions
on exam_session for select
using (
    student_id in (
        select id from profiles where auth_users_id = auth.uid()
    )
);

create policy student_insert_own_sessions
on exam_session for insert
with check (
    student_id in (
        select id from profiles where auth_users_id = auth.uid()
    )
);

create policy student_select_own_answers
on answers for select
using (
    session_id in (
        select id from exam_session
        where student_id in (
            select id from profiles where auth_users_id = auth.uid()
        )
    )
);

create policy authenticated_read_questions
on questions for select
using (true);

create policy school_admin_select_own_institution
on institutions for select
using (
    admin_id in (
        select id from profiles where auth_users_id = auth.uid()
    )
);

create policy school_admin_select_sessions
on exam_session for select
using (
    student_id in (
        select e.student_id from enrollments e
        inner join institutions i on e.school_id = i.id
        inner join profiles p on i.admin_id = p.id
        where p.auth_users_id = auth.uid()
    )
);

create policy school_admin_select_answers
on answers for select
using (
    session_id in (
        select s.id from exam_session s
        inner join enrollments e on s.student_id = e.student_id
        inner join institutions i on e.school_id = i.id
        inner join profiles p on i.admin_id = p.id
        where p.auth_users_id = auth.uid()
    )
);

create policy global_admin_all_profiles
on profiles for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);

create policy global_admin_all_institutions
on institutions for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);

create policy global_admin_all_enrollments
on enrollments for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);

create policy global_admin_all_questions
on questions for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);

create policy global_admin_all_sessions
on exam_session for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);

create policy global_admin_all_answers
on answers for all
using (
    (select user_role from profiles where auth_users_id = auth.uid()) = 'global_admin'
);
