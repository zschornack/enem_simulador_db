create table auth_users (
  id            uuid        primary key default gen_random_uuid(),
  email         text        not null unique,
  hash_password text        not null,
  created_at    timestamptz not null default now()
);

create table profiles (
  id            uuid        primary key default gen_random_uuid(),
  full_name     text        not null,
  user_role     text        not null default 'student' check (user_role in ('student', 'school_admin', 'global_admin')),
  auth_users_id uuid        not null unique references auth_users(id) on delete cascade,
  created_at    timestamptz not null default now()
);

create table institutions (
  id         uuid        primary key default gen_random_uuid(),
  name       text        not null,
  cnpj       text        not null unique,
  admin_id   uuid        not null references profiles(id) on delete restrict,
  created_at timestamptz not null default now()
);

create table questions (
  id              uuid        primary key default gen_random_uuid(),
  internal_number int         not null,
  statement       jsonb       not null,
  alternatives    jsonb       not null,
  correct_answer  text        not null,
  created_at      timestamptz not null default now()
);

create table enrollments (
  id         uuid        primary key default gen_random_uuid(),
  student_id uuid        not null references profiles(id) on delete cascade,
  school_id  uuid        not null references institutions(id) on delete cascade,
  created_at timestamptz not null default now(),
  constraint uq_enrollment unique (student_id, school_id)
);

create table session (
  id              uuid        primary key default gen_random_uuid(),
  student_id      uuid        not null references profiles(id) on delete cascade,
  session_status  text        not null default 'in_progress' check (session_status in ('in_progress', 'completed')),
  total_questions int         not null default 0,
  total_correct   int         not null default 0,
  started_at      timestamptz not null default now(),
  finished_at     timestamptz
);

create table answers (
  id                   uuid        primary key default gen_random_uuid(),
  selected_alternative int         not null,
  is_correct           boolean     not null,
  answered_at          timestamptz not null default now(),
  session_id           uuid        not null references session(id) on delete cascade,
  question_id          uuid        not null references questions(id) on delete cascade,
  constraint uq_answer unique (session_id, question_id)
);