create extension if not exists pgcrypto;

create or replace function create_profile()
returns trigger as $$
begin
    insert into profiles (id, auth_users_id, full_name, user_role, created_at)
    values (gen_random_uuid(), new.id, 'novo usuário', 'student', now());
    return new;
end;
$$ language plpgsql;

create trigger trg_create_profile
after insert on auth_users
for each row
execute function create_profile();

create or replace function validate_school_admin()
returns trigger as $$
begin
    if (select user_role from profiles where id = new.admin_id) <> 'school_admin' then
        raise exception 'o admin da instituição deve ter user_role = school_admin.';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_validate_school_admin
before insert or update of admin_id on institutions
for each row
execute function validate_school_admin();