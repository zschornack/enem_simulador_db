alter table profiles     enable row level security;
alter table enrollments  enable row level security;
alter table institutions enable row level security;
alter table exam_session enable row level security;
alter table answers      enable row level security;
alter table questions    enable row level security;

alter table profiles     force row level security;
alter table enrollments  force row level security;
alter table institutions force row level security;
alter table exam_session force row level security;
alter table answers      force row level security;
alter table questions    force row level security;

create function is_global_admin()
returns boolean
language sql
stable
as $$
    select exists (
        select 1
        from profiles
        where auth_user_id = auth.uid()
        and user_role = 'global_admin'
    );
$$;

create policy student_select_own_profile
on profiles
for select
using (
    auth_user_id = auth.uid()
);

create policy student_update_own_profile
on profiles
for update
using (
    auth_user_id = auth.uid()
)
with check (
    auth_user_id = auth.uid()
);

create policy student_select_own_enrollments
on enrollments
for select
using (
    student_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
);

create policy student_select_own_sessions
on exam_session
for select
using (
    student_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
);

create policy student_insert_own_sessions
on exam_session
for insert
with check (
    student_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
);

create policy student_update_own_sessions
on exam_session
for update
using (
    student_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
)
with check (
    student_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
);

create policy student_select_own_answers
on answers
for select
using (
    session_id in (
        select id
        from exam_session
        where student_id = (
            select id
            from profiles
            where auth_user_id = auth.uid()
        )
    )
);

create policy student_insert_own_answers
on answers
for insert
with check (
    session_id in (
        select id
        from exam_session
        where student_id = (
            select id
            from profiles
            where auth_user_id = auth.uid()
        )
    )
);

create policy authenticated_read_questions
on questions
for select
using (true);

create policy school_admin_select_own_institution
on institutions
for select
using (
    admin_id = (
        select id
        from profiles
        where auth_user_id = auth.uid()
    )
);

create policy school_admin_select_sessions
on exam_session
for select
using (
    student_id in (
        select e.student_id
        from enrollments e
        inner join institutions i
            on e.school_id = i.id
        inner join profiles p
            on i.admin_id = p.id
        where p.auth_user_id = auth.uid()
    )
);

create policy school_admin_select_answers
on answers
for select
using (
    session_id in (
        select s.id
        from exam_session s
        inner join enrollments e
            on s.student_id = e.student_id
        inner join institutions i
            on e.school_id = i.id
        inner join profiles p
            on i.admin_id = p.id
        where p.auth_user_id = auth.uid()
    )
);

create policy global_admin_all_profiles
on profiles
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);

create policy global_admin_all_institutions
on institutions
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);

create policy global_admin_all_enrollments
on enrollments
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);

create policy global_admin_all_questions
on questions
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);

create policy global_admin_all_sessions
on exam_session
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);

create policy global_admin_all_answers
on answers
for all
using (
    is_global_admin()
)
with check (
    is_global_admin()
);