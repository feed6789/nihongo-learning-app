README.md
markdown
# LingoDual – Japanese Learning App (JLPT N5–N1)

[![Flutter](https://img.shields.io/badge/Flutter-3.7+-blue.svg)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-2.12+-green.svg)](https://supabase.com)
[![Drift](https://img.shields.io/badge/Drift-2.16+-orange.svg)](https://pub.dev/packages/drift)
[![ML Kit](https://img.shields.io/badge/ML%20Kit-OCR%20%7C%20Translation-purple.svg)](https://developers.google.com/ml-kit)

Modern **offline-first** Japanese vocabulary trainer with photo translation (OCR + on-device JP→VN), progress tracking, and quiz — built for JLPT learners (N5–N1).

## ✨ Key Features

### Core Learning
- **JLPT-themed vocabulary** with category filtering (N5–N1)
- **Search** by kanji, hiragana, or meaning (Vietnamese/English)
- **Mark words** as Learned / Favorite with optimistic UI updates
- **Progress bar** showing overall learning completion
- **4-choice random quiz** with instant feedback

### Special Tools
- **Photo Translation**: Camera / gallery → Japanese OCR → Vietnamese translation (Google ML Kit – on-device)
- **Offline-first** (mobile): Drift SQLite cache with automatic fallback
- **Guest mode** – try without login, progress saved locally

### Auth & Sync
- Email login / register (Vietnamese error messages)
- Google Sign-in (ready – requires Supabase OAuth config)
- **RLS-protected** user progress sync across devices

## 🛠 Tech Stack

| Layer | Technology |
|-------|------------|
| UI | Flutter 3.7+ • Material 3 |
| State Management | setState (migrating to Riverpod) |
| Backend | Supabase (Auth + PostgreSQL + RLS) |
| Local DB | Drift (SQLite – mobile) / WebSQL fallback (web) |
| OCR & Translation | Google ML Kit (on-device – Japanese → Vietnamese) |
| Image | image_picker |

## 📁 Folder Structure (Feature-first + Clean Architecture)
lib/
├── core/ # Shared components
│ ├── constants/ # App strings, Supabase keys
│ ├── local_db/ # Drift database setup (native/web)
│ ├── services/ # Supabase service
│ └── utils/ # Auth helper, logger
├── features/
│ ├── auth/ # Login, register, auth gate
│ │ ├── data/ # AuthService
│ │ └── presentation/ # LoginPage, RegisterPage, AuthGate
│ └── vocabulary/ # Main learning module
│ ├── data/ # Models, datasources, repositories
│ └── presentation/ # List, quiz, photo translate, form pages
└── shared/ # Reusable widgets & themes

text

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.7
- Supabase project (run `database_schema.sql` to create tables)

### Installation

```bash
git clone https://github.com/yourusername/lingodual.git
cd lingodual

flutter pub get
# Generate Drift files (if you modify tables)
dart run build_runner build --delete-conflicting-outputs

# Run on device/emulator
flutter run
Supabase Setup
Create project on Supabase

Copy your URL and anon key

Update lib/core/services/supabase_service.dart:

dart
url: 'YOUR_SUPABASE_URL',
anonKey: 'YOUR_SUPABASE_ANON_KEY',
Run database_schema.sql in Supabase SQL editor to create:

categories table

vocabulary table

user_vocabulary_progress table (with RLS policies)

📱 Features in Detail
Vocabulary List
Filter by category (JLPT level)

Filter by status: All / Unlearned / Learned / Favorite

Search across kanji, hiragana, Vietnamese, English

Progress bar showing % completed

Quiz Mode
Random 4-option multiple choice

Tests meaning (English)

Instant correct/incorrect feedback

Next question button

Photo Translation
Take photo or pick from gallery

Japanese text recognition (OCR)

On-device Japanese → Vietnamese translation

Copy results to clipboard

🗺 Roadmap 2026
Q2 2026
Complete Riverpod state management migration

Vocabulary Detail Page (examples, audio)

Delete vocabulary (long-press)

Q3 2026
Spaced Repetition System (SRS)

Flashcard mode with swipe

Grammar module (reuse quiz + progress)

Q4 2026
Kanji module (stroke order, radicals)

Dark mode

Import/export CSV/Excel

🤝 Contributing
Fork the repo

Create feature branch (git checkout -b feature/amazing-feature)

Commit changes (git commit -m 'Add amazing feature')

Push (git push origin feature/amazing-feature)

Open Pull Request

📄 License
MIT License – see LICENSE file.

Questions? → Open an issue!


---
