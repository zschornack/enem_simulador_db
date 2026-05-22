create extension if not exists pgcrypto;

create or replace function create_profile()
returns trigger as $$
begin

    insert into profiles (auth_user_id, full_name, user_role, created_at)
    values (new.id, 'novo usuário', 'student', now());
    
    return new;
end;
$$ language plpgsql security definer; -- tem que contornar o problema que deu antes

create trigger trg_create_profile
after insert on auth_user
for each row
execute function create_profile();


create or replace function validate_school_admin()
returns trigger as $$
declare
    v_role text;
begin
    -- var aqui pq antes tava uma merda na moral nao dava pra ler nada
    select user_role into v_role from profiles where id = new.admin_id;

    -- v_role ser nulo perfil não encontrado ou algo bizarro
    if coalesce(v_role, '') <> 'school_admin' then
        raise exception 'O admin da instituição deve ter user_role = school_admin.';
    end if;
    
    return new;
end;
$$ language plpgsql security definer;

create trigger trg_validate_school_admin
before insert or update of admin_id on institutions
for each row
execute function validate_school_admin();