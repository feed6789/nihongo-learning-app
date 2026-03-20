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

README.md
Markdown# LingoDual – Japanese Learning App (JLPT N5–N1)

[![Flutter](https://img.shields.io/badge/Flutter-3.24+-blue.svg)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-2.12+-green.svg)](https://supabase.com)
[![Drift](https://img.shields.io/badge/Drift-SQLite-orange.svg)](https://pub.dev/packages/drift)
[![Riverpod](https://img.shields.io/badge/Riverpod-planned-red.svg)](https://riverpod.dev)

Modern **offline-first** Japanese vocabulary trainer with photo translation (OCR + on-device JP→VN), progress tracking, and basic quiz — built for JLPT learners.

![App Screenshot Placeholder](https://via.placeholder.com/800x500?text=LingoDual+Screenshots+Here)  
*(Add real screenshots / demo GIF here later)*

## ✨ Key Features

### Core Learning
- JLPT-themed vocabulary list (search, category & status filter)
- Mark words **Learned** / **Favorite** with optimistic UI
- Simple 4-choice random quiz
- Progress overview bar

### Special Tools
- **Photo Translation**: Camera / gallery → Japanese OCR → Vietnamese translation (Google ML Kit – on-device)
- **Offline-first** (mobile): Drift SQLite cache + fallback
- Guest mode (no login required)

### Auth & Sync
- Email login / register
- Planned: Google Sign-in + multi-device progress sync

## 🛠 Tech Stack

| Layer              | Technology                          |
|--------------------|-------------------------------------|
| UI                 | Flutter 3.24+ • Material 3          |
| State Management   | setState (planned → Riverpod 2.x)   |
| Backend            | Supabase (Auth + PostgreSQL + RLS)  |
| Local DB           | Drift (SQLite – mobile) / Web fallback |
| OCR & Translation  | Google ML Kit (on-device)           |
| Image              | image_picker                        |

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.7
- Supabase project (tables: `vocabulary`, `categories`, `user_vocabulary_progress`)

### Installation

```bash
git clone https://github.com/yourusername/lingodual.git
cd lingodual

flutter pub get
# Generate Drift files (if needed)
dart run build_runner build --delete-conflicting-outputs

# Run on device/emulator
flutter run
Supabase Setup

Create project → copy URL & anon key
Paste into lib/core/services/supabase_service.dart
Run database_schema.sql in Supabase SQL editor

📂 Folder Structure (Feature-first + Clean Arch inspired)
textlib/
├── core/                  # shared (constants, services, drift, utils)
├── features/
│   ├── auth/              # login/register/gate
│   └── vocabulary/        # main module (list, quiz, photo translate, form)
└── shared/                # themes, common widgets
🗺 Roadmap 2026

 Full Riverpod migration
 Spaced Repetition System (SRS)
 Grammar & Kanji modules (reuse quiz + progress)
 Flashcard mode
 Dark mode + animations
 Import/export CSV/Excel
 Daily streak & weak words analysis

🤝 Contributing

Fork the repo
Create feature branch (git checkout -b feature/amazing-feature)
Commit (git commit -m 'Add amazing feature')
Push (git push origin feature/amazing-feature)
Open Pull Request

📄 License
MIT License – see LICENSE file.
Built with ❤️ in Pleiku, Gia Lai, Vietnam
Questions? → Open an issue!
text### ARCHITECTURE.md

```markdown
# Architecture – LingoDual

Simplified **Clean Architecture** + **feature-first** structure + **offline-first** design.

## Layers
┌──────────────────────────────┐
│ Presentation                 │  ← Pages, Widgets, UI logic
│   (features/*/presentation) │     (setState → planned Riverpod)
└──────────────────────────────┘
│
▼
┌──────────────────────────────┐
│ Domain (thin – planned)      │  ← Entities, future UseCases
└──────────────────────────────┘
│
▼
┌──────────────────────────────┐
│ Data                         │
│   Repository                 │  ← VocabularyRepository
│   ├─ Remote Datasource       │      (Supabase + RLS join)
│   └─ Local Datasource        │      (Drift SQLite – mobile only)
└──────────────────────────────┘
text## Data Flow Examples

**Fetch Vocabulary (getAll)**
UI (VocabularyListPage)
↓
Repository.getAll()
├─► Remote → Supabase (JOIN user_progress if logged-in)
│    ↓ success → cache to Drift (mobile only)
└─► Offline / error → fallback to Drift (mobile)
↓
Map Model → Entity → UI
text**Toggle Learned / Favorite**
UI → optimistic update (setState)
↓
Repository.toggleLearned(id, value)
↓
Remote → Supabase upsert to user_vocabulary_progress
↓ (future: queue if offline)
text## Offline Strategy (March 2026)

| Platform | Cache           | Sync on login | Guest mode     |
|----------|-----------------|---------------|----------------|
| Mobile   | Drift SQLite    | Partial       | Local-only     |
| Web      | Disabled        | —             | Read-only      |

## Authentication & Security

- Supabase Auth (email + Google planned)
- RLS on `user_vocabulary_progress` → only own rows
- Guest → no session, local progress only

## Key Decisions

- **Supabase** over Firebase → SQL + strong RLS
- **Drift** over Hive/SharedPrefs → type-safe queries + scale
- **Separate progress table** → multi-user + scalable
- **On-device ML Kit** → privacy + offline

## Weak Points (current)

- No full Domain layer / UseCases yet
- State still mostly setState (no Riverpod providers)
- No conflict resolution on sync
- Web lacks offline & ML support

## Future Improvements

- Riverpod providers (list, filter, quiz)
- Failure/Either pattern
- Background sync queue
- TTL / diff sync
CONTEXT.md
Markdown# Project Context – LingoDual

## Goals

Build a modern, **offline-capable** Japanese learning companion for Vietnamese JLPT learners (N5–N1) with:

- Strong vocabulary foundation
- Real-world photo translation (signs, manga, menus…)
- Personalized progress tracking
- Future expansion to grammar, kanji, SRS

## Target Users

- Vietnamese students / self-learners preparing JLPT
- People living/working in Japan needing quick reading help
- Anyone wanting free, no-barrier Japanese study tool

## Core Problems Solved

- Most apps lack good offline support
- Progress usually not synced across devices
- Few Vietnamese-friendly photo → meaning tools
- UX often outdated or cluttered

## Design Philosophy

- **Mobile-first, offline-first**
- **Simple & fast UX** > perfect architecture (early stage)
- **Guest mode** lowers entry barrier
- **Scale later**: start with vocabulary, reuse patterns for grammar/kanji

## Constraints

- Solo/small-team development
- Free-tier Supabase + on-device ML (no cloud costs)
- Focus on vocabulary + translation first

## Long-term Vision

Personalized Japanese learning assistant:

- Adaptive SRS scheduling
- Weak-point analysis & recommendations
- Multi-skill (reading/listening/speaking)
- Community features (shared sets, leaderboards)
TODO.md
Markdown# TODO – LingoDual (March 2026)

## High Priority (Next 1–2 months)

- [ ] Migrate state management to **Riverpod 2.x** (start with vocabulary list/filter)
- [ ] Secure Supabase anon key (use --dart-define or .env)
- [ ] Complete **Vocabulary Detail Page** (examples, audio placeholder, notes)
- [ ] Add **delete vocabulary** (long-press + confirm – admin only)
- [ ] Implement **global error handling** + user-friendly toasts
- [ ] Fix remaining bugs:
  - Filter chips not resetting after login
  - Progress bar not always in sync
  - Quiz edge case (<4 words)

## Medium Priority

- [ ] Basic **SRS engine** (next_review_date, interval, EF)
- [ ] **Flashcard mode** (swipe + flip animation)
- [ ] Category / JLPT-level quiz modes
- [ ] **Dark mode** support
- [ ] Streak counter + daily goal
- [ ] **Import/export** vocabulary (CSV/Excel – admin)

## Lower Priority / Future

- Grammar module (reuse quiz & progress system)
- Kanji module (stroke order, radicals, readings)
- Audio pronunciation (TTS fallback)
- Achievement badges / gamification
- Push notifications (daily review reminder)
- Leaderboard & social sharing

## Technical Debt

- [ ] Unify / clarify Vocabulary vs VocabularyModel
- [ ] Add structured logging (console + optional Sentry)
- [ ] Unit tests for repository & datasource
- [ ] Better loading/error skeletons in list
- [ ] Web: graceful degradation (no offline, no ML)

Priority order: **Riverpod → SRS → Detail page → Polish**
PROGRESS.md
Markdown# Development Progress – LingoDual (March 20, 2026)

## Overall Status

- **Stage**: MVP+ (solid vocabulary core + photo translate)
- **Architecture**: 7/10 (Clean-inspired, but Domain thin)
- **Feature depth**: 6.5/10
- **Offline readiness**: 8/10 (mobile)
- **Polish & stability**: 7/10

## Completed (Milestone 1 – Core)

### Auth & Access
- [x] Email login/register (Vietnamese error messages)
- [x] Guest mode + AuthGate
- [x] Logout + reload on auth change

### Vocabulary
- [x] List with search, category filter, status chips
- [x] Toggle Learned / Favorite (optimistic UI + API)
- [x] Progress bar & learned count
- [x] Basic random 4-choice quiz

### Offline & Data
- [x] Drift cache (mobile) + offline fallback
- [x] Conditional native/web DB import
- [x] Supabase RLS-aware queries (progress join)

### Photo Translate
- [x] Camera/gallery pick
- [x] Japanese OCR (ML Kit)
- [x] On-device JP → VN translation

## In Progress / Needs Polish

- [ ] Riverpod migration
- [ ] Vocabulary Detail screen
- [ ] Delete vocabulary UI
- [ ] Error/loading states improvement
- [ ] Quiz scoring & review wrong answers

## Not Started / Planned

- SRS algorithm & review scheduling
- Flashcard UI + swipe
- Grammar & Kanji modules
- Dark mode
- Audio (TTS)
- Import/export flow
- Push notifications

## Bug & Polish Backlog

Fixed recently:
- [x] Quiz crash when <4 words
- [x] Search with Vietnamese diacritics

Still open:
- [ ] Progress bar sync after toggle
- [ ] Filter state after login
- [ ] Drift web release issues

## Next Sprint Goals (2 weeks)

1. Start Riverpod refactor (vocabulary list provider)
2. Finish Vocabulary Detail page
3. Add delete vocabulary (admin)
4. Improve error handling & toasts

Good foundation — ready for SRS & module expansion!