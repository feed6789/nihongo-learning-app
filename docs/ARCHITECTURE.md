# ARCHITECTURE.md

```markdown
# Architecture – LingoDual

**Clean Architecture** (simplified) + **feature-first** structure + **offline-first** design.

## Layer Overview
┌─────────────────────────────────────────────────────────────┐
│ PRESENTATION LAYER │
│ lib/features//presentation/ │
│ ├── Pages (VocabularyListPage, QuizPage, PhotoTranslatePage)│
│ └── Widgets (VocabularyCard, FilterChips, ProgressBar) │
│ State: setState (migrating to Riverpod) │
└─────────────────────────────────────────────────────────────┘
↓
┌─────────────────────────────────────────────────────────────┐
│ DOMAIN LAYER (thin – planned) │
│ lib/features//domain/ │
│ ├── Entities (Vocabulary, Category) │
│ └── UseCases (future: GetVocabulary, ToggleLearned) │
└─────────────────────────────────────────────────────────────┘
↓
┌─────────────────────────────────────────────────────────────┐
│ DATA LAYER │
│ lib/features/*/data/ │
│ ├── Repositories (VocabularyRepository) │
│ ├── Datasources (Remote + Local) │
│ │ ├── VocabularyRemoteDatasource (Supabase) │
│ │ └── VocabularyLocalDatasource (Drift) │
│ └── Models (VocabularyModel, CategoryModel) │
└─────────────────────────────────────────────────────────────┘

text

## Data Flow Examples

### Fetch Vocabulary (getAll)
[UI] VocabularyListPage
↓
[Repository] VocabularyRepository.getAll()
↓
[RemoteDS] VocabularyRemoteDatasource.getAll()
├─ If logged-in: SELECT vocabulary., user_vocabulary_progress.
└─ If guest: SELECT vocabulary.* (no progress)
↓
[Repository]
├─ If mobile + not guest: cache to Drift
└─ If offline: fallback to Drift
↓
[UI] Display vocabulary list with progress

text

### Toggle Learned / Favorite
[UI] User taps checkbox/star
↓ Optimistic UI update (setState)
[Repository] toggleLearned(id, value) / toggleFavorite(id, value)
↓
[RemoteDS] upsert to user_vocabulary_progress
↓ (future: queue if offline)
[Supabase] RLS ensures user_id matches auth.uid()
↓
[UI] (already updated – no refresh needed)

text

## Offline Strategy (Current)

| Platform | Cache | Sync on Login | Guest Mode |
|----------|-------|---------------|------------|
| Mobile | Drift SQLite | Partial (re-fetch) | Local-only (no sync) |
| Web | Disabled (WebSQL fallback) | — | Read-only |

**Implementation details:**
- `lib/core/local_db/native_db.dart` – mobile (SQLite)
- `lib/core/local_db/web_db.dart` – web (WebSQL)
- Conditional import using `if (dart.library.html)`

## Authentication & Security

### Supabase Auth
- Email/Password (implemented)
- Google Sign-in (ready – needs OAuth config)

### Row Level Security (RLS)
```sql
-- Users can only see their own progress
CREATE POLICY "Users can view own progress"
ON user_vocabulary_progress
FOR SELECT
USING (auth.uid() = user_id);
Guest Mode
No Supabase session

Local progress not synced

Full read access to vocabulary

Key Architectural Decisions
Decision	Rationale
Supabase over Firebase	PostgreSQL + RLS for complex queries and security
Drift over Hive/SharedPrefs	Type-safe SQL queries, scales with large vocabulary
Separate progress table	Multi-user support, easy to add fields (review_count, next_review)
On-device ML Kit	Privacy, offline capability, no cloud costs
Conditional web imports	Drift works on web via WebSQL (fallback)
Current Weak Points
No full Domain layer / UseCases yet

State mostly setState (no Riverpod providers for data)

No background sync queue for offline actions

Web lacks offline cache and ML Kit support

Future Improvements
Riverpod providers – list state, filter state, quiz state

Failure/Either pattern – better error handling

Background sync queue – store offline actions, sync when online

TTL cache – periodic remote refresh

Domain layer – UseCases for business logic

Database Schema Reference
Supabase Tables
categories – (id, title, type, order_index)

vocabulary – (id, category_id, kanji, hiragana, romaji, meaning_vn, meaning_en, word_type)

user_vocabulary_progress – (user_id, vocabulary_id, learned, favorite, last_reviewed)

Drift Local Tables
VocabularyTable – mirrors vocabulary + adds local progress fields

text

---

