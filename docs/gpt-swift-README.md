# gpt-swift Roadmap Tracker

A static GitHub Pages web app backed by Supabase for tracking the iOS + PyTorch + Core ML trading-app learning roadmap.

## Files

- `gpt-swift-index.html` — the web app. Can be opened directly from GitHub Pages, for example `/gpt-swift-index.html`.
- `gpt-swift-schema.sql` — run once in Supabase SQL Editor.

## Setup

1. Create a Supabase project.
2. Run `gpt-swift-schema.sql` in Supabase SQL Editor.
3. In Supabase Auth, enable Email provider / magic links.
4. Add your GitHub Pages URL to Supabase Auth redirect URLs.
5. Push `gpt-swift-index.html` to your GitHub repo.
6. Enable GitHub Pages.
7. Open the page, paste your Supabase project URL and anon public key, then save config.
8. Sign in and click **Seed default roadmap**.

## Main features

- Subject hierarchy, e.g. Swift / iOS, ML / PyTorch, Backend, Integration.
- Tasks under each subject, e.g. Swift basics.
- Start date: Tuesday 5 May 2026, because Monday 4 May 2026 is a UK bank holiday.
- Weekends and configured UK bank holidays are excluded.
- Skip a learning day: pushes all incomplete tasks on/after that date forward by one valid working day.
- Skip a task: pushes that task and later tasks in the same subject forward by one valid working day.
- Drag-and-drop task reordering inside the Subject Tasks tab.
- Calendar month view.
- Roadmap timeline view.
- Visual pulse effect for tasks shifted by skip/reorder actions.

## Notes

The app stores the Supabase URL and anon key in browser localStorage. This is normal for a static Supabase browser app. Security comes from Supabase Auth and Row Level Security policies in the schema.

## Versioning and Supabase changelog

Current app version: **v1.2**.

The HTML title is set to `gpt-swift Roadmap Tracker v1.2`, so you can confirm which deployed version is loaded in the browser tab.

The app writes the current version to Supabase table `app_changelog` after sign-in. Run the latest `gpt-swift-schema.sql` before opening the app so that table and RLS policies exist.

To make future changes:

1. Update `APP_MAJOR` or `APP_MINOR` near the top of `gpt-swift-index.html`.
2. Update `APP_CHANGELOG` with the new change descriptions.
3. Deploy the HTML file.
4. Open the app and sign in; the new version will be logged automatically.
