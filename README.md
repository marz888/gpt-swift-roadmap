# GPT Swift Roadmap Tracker

A GitHub Pages-friendly roadmap tracker for learning Swift, Core ML, PyTorch, backend development, and fintech app delivery.

## What is included

- Static frontend in `docs/index.html`
- Supabase database schema in `sql/gpt-swift-schema.sql`
- Supabase Auth + Row Level Security
- Subject/task hierarchy
- 5-day learning schedule starting Tuesday 5 May 2026 because Monday 4 May 2026 is a UK bank holiday
- Skip-day schedule push
- Skip-task subject-only push
- Drag-and-drop task reordering
- Calendar view
- Timeline view
- Version display in browser title and UI
- Supabase changelog table

## GitHub Pages setup

1. Push this repo to GitHub.
2. Go to **Settings → Pages**.
3. Set source to branch `main`, folder `/docs`.
4. Open the published GitHub Pages URL.

## Supabase setup

1. Create a Supabase project.
2. Go to **SQL Editor**.
3. Run `sql/gpt-swift-schema.sql`.
4. Enable Email Auth in Supabase Auth settings.
5. Open the app.
6. Paste your Supabase project URL and anon key into the setup fields.
7. Sign up or sign in.
8. Click **Seed default roadmap**.

## Important security note

The Supabase anon key is safe to use in a browser app when Row Level Security is enabled. Do not use the Supabase service-role key in this HTML file.

## Current app version

v1.2
