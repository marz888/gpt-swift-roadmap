-- gpt-swift roadmap tracker schema for Supabase.
-- Run this once in Supabase SQL Editor.
-- Designed for a static GitHub Pages HTML app using Supabase Auth + RLS.

create extension if not exists pgcrypto;

create table if not exists public.subjects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  description text default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  subject_id uuid not null references public.subjects(id) on delete cascade,
  title text not null,
  description text default '',
  task_order integer not null default 0,
  duration_minutes integer not null default 60,
  planned_date date not null,
  status text not null default 'pending'
    check (status in ('pending', 'in_progress', 'done', 'skipped')),
  notes text default '',
  blockers text default '',
  time_spent_minutes integer not null default 0,
  skipped_count integer not null default 0,
  completed_at timestamptz,
  created_at timestamptz not null default now()
);

create table if not exists public.study_days (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  date date not null,
  status text not null default 'scheduled'
    check (status in ('scheduled', 'skipped')),
  notes text default '',
  created_at timestamptz not null default now(),
  unique (user_id, date)
);

create index if not exists subjects_user_sort_idx on public.subjects(user_id, sort_order);
create index if not exists tasks_user_date_idx on public.tasks(user_id, planned_date);
create index if not exists tasks_subject_order_idx on public.tasks(subject_id, task_order);
create index if not exists study_days_user_date_idx on public.study_days(user_id, date);

alter table public.subjects enable row level security;
alter table public.tasks enable row level security;
alter table public.study_days enable row level security;

drop policy if exists "subjects_select_own" on public.subjects;
drop policy if exists "subjects_insert_own" on public.subjects;
drop policy if exists "subjects_update_own" on public.subjects;
drop policy if exists "subjects_delete_own" on public.subjects;

create policy "subjects_select_own" on public.subjects for select using ((select auth.uid()) = user_id);
create policy "subjects_insert_own" on public.subjects for insert with check ((select auth.uid()) = user_id);
create policy "subjects_update_own" on public.subjects for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "subjects_delete_own" on public.subjects for delete using ((select auth.uid()) = user_id);

drop policy if exists "tasks_select_own" on public.tasks;
drop policy if exists "tasks_insert_own" on public.tasks;
drop policy if exists "tasks_update_own" on public.tasks;
drop policy if exists "tasks_delete_own" on public.tasks;

create policy "tasks_select_own" on public.tasks for select using ((select auth.uid()) = user_id);
create policy "tasks_insert_own" on public.tasks for insert with check ((select auth.uid()) = user_id);
create policy "tasks_update_own" on public.tasks for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "tasks_delete_own" on public.tasks for delete using ((select auth.uid()) = user_id);

drop policy if exists "study_days_select_own" on public.study_days;
drop policy if exists "study_days_insert_own" on public.study_days;
drop policy if exists "study_days_update_own" on public.study_days;
drop policy if exists "study_days_delete_own" on public.study_days;

create policy "study_days_select_own" on public.study_days for select using ((select auth.uid()) = user_id);
create policy "study_days_insert_own" on public.study_days for insert with check ((select auth.uid()) = user_id);
create policy "study_days_update_own" on public.study_days for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "study_days_delete_own" on public.study_days for delete using ((select auth.uid()) = user_id);

-- App version changelog. Each deployed HTML version records itself here after sign-in.
create table if not exists public.app_changelog (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  app_name text not null default 'gpt-swift-roadmap-tracker',
  major integer not null,
  minor integer not null,
  version text generated always as (major::text || '.' || minor::text) stored,
  title text not null,
  changes jsonb not null default '[]'::jsonb,
  released_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (user_id, app_name, major, minor)
);

create index if not exists app_changelog_user_version_idx on public.app_changelog(user_id, app_name, major desc, minor desc);

alter table public.app_changelog enable row level security;

drop policy if exists "app_changelog_select_own" on public.app_changelog;
drop policy if exists "app_changelog_insert_own" on public.app_changelog;
drop policy if exists "app_changelog_update_own" on public.app_changelog;
drop policy if exists "app_changelog_delete_own" on public.app_changelog;

create policy "app_changelog_select_own" on public.app_changelog for select using ((select auth.uid()) = user_id);
create policy "app_changelog_insert_own" on public.app_changelog for insert with check ((select auth.uid()) = user_id);
create policy "app_changelog_update_own" on public.app_changelog for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "app_changelog_delete_own" on public.app_changelog for delete using ((select auth.uid()) = user_id);
