# TODO – LingoDual (March 2026)

## Priority Legend
- 🔴 **High** – Next 1-2 months
- 🟡 **Medium** – Q2-Q3 2026
- 🟢 **Low** – Q4 2026+

---

## 🔴 High Priority (Next 1-2 Months)

### State Management
- [ ] **Migrate to Riverpod 2.x** – start with vocabulary list and filters
  - [ ] Create `vocabularyRepositoryProvider`
  - [ ] Create `vocabularyListProvider` (FutureProvider)
  - [ ] Create `filterStateProvider` (StateProvider)
  - [ ] Replace setState in VocabularyListPage

### Security & Configuration
- [ ] **Secure Supabase anon key** – use `--dart-define` or `.env` file
- [ ] **Add structured logging** – replace `print()` with proper logger

### UI Improvements
- [ ] **Complete Vocabulary Detail Page**
  - [ ] Basic layout with all fields
  - [ ] Example sentences (mock data)
  - [ ] Audio placeholder (TTS button)
  - [ ] Notes section for user
- [ ] **Add delete vocabulary** – long-press + confirmation (admin only)
- [ ] **Improve error/loading states**
  - [ ] Skeleton loader for list
  - [ ] Better empty states

### Bug Fixes
- [ ] Fix filter chips not resetting after login
- [ ] Fix progress bar not updating after toggle
- [ ] Fix quiz edge case (<4 words) – show warning

---

## 🟡 Medium Priority (Q2-Q3 2026)

### Learning Features
- [ ] **Spaced Repetition System (SRS) – Basic**
  - [ ] Add `next_review_date`, `review_count`, `ease_factor` to progress table
  - [ ] `DueToday` filter in vocabulary list
  - [ ] SRS queue with priority sorting
- [ ] **Flashcard Mode**
  - [ ] Card flip animation
  - [ ] Swipe left/right gestures
  - [ ] Keyboard shortcuts
  - [ ] Auto-advance option
- [ ] **Quiz Enhancements**
  - [ ] Category-based quiz selection
  - [ ] JLPT level quiz
  - [ ] Scoring system (points per correct answer)
  - [ ] Streak counter
  - [ ] Review incorrect answers after quiz

### Grammar Module
- [ ] Create `grammar` table in Supabase
- [ ] Grammar models and datasources
- [ ] Grammar list page (reuse vocabulary list pattern)
- [ ] Grammar detail page
- [ ] Grammar quiz (reuse quiz logic)

### UI/UX
- [ ] **Dark mode** support
- [ ] **Daily goal** setting (e.g., 10 words/day)
- [ ] **Streak counter** with calendar view
- [ ] **Animations** for toggle actions

### Data Import/Export
- [ ] Import vocabulary from CSV/Excel
- [ ] Export progress to CSV
- [ ] Bulk delete vocabulary

---

## 🟢 Low Priority (Q4 2026+)

### Kanji Module
- [ ] Kanji table with radicals, stroke order, readings
- [ ] Kanji list by JLPT level
- [ ] Stroke order animation
- [ ] Writing practice with canvas

### Audio & Pronunciation
- [ ] Text-to-speech (TTS) fallback
- [ ] Native audio recordings for common words
- [ ] Pronunciation practice (voice input)

### Gamification
- [ ] Achievement badges
- [ ] Leaderboard (friends/global)
- [ ] Weekly challenges

### Social Features
- [ ] Share progress
- [ ] Study groups
- [ ] User-generated vocabulary sets

### Platform Features
- [ ] Push notifications (daily review reminder)
- [ ] iOS home screen widget
- [ ] Android app bundle optimization
- [ ] PWA support

---

## 🧹 Technical Debt

### Code Quality
- [ ] Unify `Vocabulary` vs `VocabularyModel` (reduce duplication)
- [ ] Add `Either` or `Result` type for error handling
- [ ] Unit tests for repositories and datasources
- [ ] Widget tests for vocabulary list and quiz

### Documentation
- [ ] API documentation (Supabase RLS policies)
- [ ] Developer setup guide
- [ ] User guide (in-app help)

### Infrastructure
- [ ] CI/CD with GitHub Actions
- [ ] Automatic deployment to TestFlight/Play Store
- [ ] Sentry/Crashlytics integration

---

## 🐛 Known Bugs (To Fix)

| Bug | Status |
|-----|--------|
| Quiz crashes when <4 vocabulary words | ✅ Fixed |
| Search with Vietnamese diacritics | ✅ Fixed |
| Progress bar not updating after toggle | 🔄 In progress |
| Filter chips state after login | 🔄 In progress |
| Drift web release issues (sql.js) | 🔄 In progress |
| Memory leak in PhotoTranslatePage (multiple scans) | 📋 Reported |
| Quiz sometimes shows same word multiple times | 📋 Reported |

---

## ✅ Completed (Milestone 1)

### Auth
- [x] Email login/register
- [x] Vietnamese error messages
- [x] Guest mode
- [x] Logout + reload
- [x] Google Sign-in (code ready, needs config)

### Vocabulary
- [x] List with search, category filter, status chips
- [x] Toggle Learned / Favorite (optimistic UI)
- [x] Progress bar & learned count
- [x] Basic random 4-choice quiz

### Offline
- [x] Drift cache (mobile)
- [x] Offline fallback
- [x] Conditional native/web DB import
- [x] RLS-aware Supabase queries

### Photo Translate
- [x] Camera/gallery pick
- [x] Japanese OCR
- [x] On-device JP→VN translation
- [x] Copy results

---

## 📊 Progress Summary

| Area | Progress | Status |
|------|----------|--------|
| Vocabulary Core | 95% | ✅ Done |
| Auth | 90% | ✅ Done |
| Offline Support | 80% | ✅ Done |
| Photo Translate | 100% | ✅ Done |
| State Management | 20% | 🔄 Riverpod pending |
| SRS | 0% | 📋 Planned |
| Grammar Module | 0% | 📋 Planned |
| Kanji Module | 0% | 📋 Planned |
| Tests | 10% | 📋 Planned |