# Foody

A smart kitchen companion app built with Flutter, Supabase, and AI-powered recipe suggestions.

## Features

- User authentication (Supabase)
- Manage your ingredients
- Browse and add recipes
- Get AI-generated recipe suggestions based on your ingredients

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) (3.10 or newer recommended)
- [Supabase](https://supabase.com/) project (free tier is fine)
- [Groq API Key](https://console.groq.com/keys) for AI suggestions

### Supabase Setup

1. **Create a Supabase project** at [supabase.com](https://supabase.com/).
2. **Enable authentication** (email/password).
3. **Set up the database schema:**
   - Open the Supabase SQL Editor.
   - Copy the contents of [`supabase/tables.sql`](supabase/tables.sql) from this repo.
   - Paste and run it in the SQL editor to create all required tables, types, and policies.

4. **Get your Supabase credentials:**
   - In your Supabase dashboard, go to Project Settings → API.
   - Copy the `Project URL` and `anon` public key.

5. **Exporting your schema (optional, for backup):**
   - You can export your schema using the Supabase CLI or from the dashboard.
   - To export from local (if using the CLI):
     ```sh
     supabase db dump --schema public --file supabase/tables.sql
     ```

## Getting Started

### 1. Clone the repository

```sh
git clone <repository>
cd foody_app
```

### 2. Install dependencies

```sh
flutter pub get
```

### 3. Set up environment variables

Copy `.env.example` to `.env` and fill in your keys:

```sh
cp .env.example .env
```

Edit `.env` and set:

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `GROQ_API_KEY` (for AI suggestions)

### 4. Run the app

```sh
flutter run
```

### 5. Build for release

```sh
flutter build apk --release
# or for iOS
flutter build ios --release
```

## Folder Structure

- `lib/core/` - Data models and services
- `lib/presentation/` - UI screens and app entrypoint
- `supabase/` - Database schema and SQL policies

## Notes

- For Supabase setup, see [supabase.com](https://supabase.com/)
- For Groq API, see [groq.com](https://groq.com/)

---

## License

MIT