-- Optional Supabase Realtime publication setup.
-- Run only if you want multi-device live sync.

alter publication supabase_realtime add table public.subjects;
alter publication supabase_realtime add table public.tasks;
alter publication supabase_realtime add table public.study_days;
alter publication supabase_realtime add table public.app_changelog;
