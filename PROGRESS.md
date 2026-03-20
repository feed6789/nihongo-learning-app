# Development Progress – LingoDual (March 20, 2026)

## Overall Status

| Metric | Score | Notes |
|--------|-------|-------|
| **Stage** | MVP+ | Solid vocabulary core + photo translate |
| **Architecture** | 7/10 | Clean-inspired, domain layer thin |
| **Feature Depth** | 6.5/10 | Core features solid, SRS/grammar pending |
| **Offline Readiness** | 8/10 | Mobile works well, web limited |
| **Polish & Stability** | 7/10 | Some bugs, UI could be smoother |
| **Test Coverage** | 2/10 | Minimal automated tests |

---

## ✅ Completed (Milestone 1 – Core Features)

### Authentication
- [x] Email login/register with Vietnamese error messages
- [x] Guest mode (no login required)
- [x] AuthGate – automatic routing based on session
- [x] Logout with state refresh
- [x] Google Sign-in code (ready – needs Supabase OAuth config)

### Vocabulary Management
- [x] Fetch from Supabase with RLS join for user progress
- [x] Display list with Material 3 ListTile
- [x] Category filter dropdown (JLPT levels)
- [x] Status filter chips: All / Unlearned / Learned / Favorite
- [x] Search across kanji, hiragana, Vietnamese, English
- [x] Toggle Learned (checkbox icon)
- [x] Toggle Favorite (star icon)
- [x] Optimistic UI updates (immediate visual feedback)
- [x] Progress bar with percentage
- [x] Basic random 4-choice quiz
- [x] Vocabulary form page (add/edit)

### Offline & Data Layer
- [x] Drift SQLite cache (mobile)
- [x] Offline fallback when network unavailable
- [x] Conditional native/web DB import
- [x] Supabase RLS-aware queries
- [x] VocabularyRepository with remote + local datasources

### Photo Translate Feature
- [x] Camera pick with image_picker
- [x] Gallery pick
- [x] Japanese OCR (Google ML Kit Text Recognition)
- [x] On-device Japanese → Vietnamese translation
- [x] Copy results to clipboard
- [x] Loading states during processing

### UI/UX
- [x] Material 3 theming with blue primary
- [x] AppBar with photo scan and quiz buttons
- [x] Login/Logout buttons (conditional)
- [x] Snackbar error messages
- [x] Loading indicators
- [x] Empty states for search/filter

---

## 🚧 In Progress

### State Management Migration (20%)
- [x] Riverpod added to pubspec
- [ ] Provider setup for repositories
- [ ] Provider for vocabulary list
- [ ] Provider for filter state
- [ ] Replace setState in VocabularyListPage

### Vocabulary Detail Page (30%)
- [x] Basic page scaffold
- [ ] Full vocabulary fields display
- [ ] Example sentences
- [ ] Audio button (TTS placeholder)
- [ ] User notes section
- [ ] Related words

### Bug Fixes
- [ ] Progress bar sync after toggle (80%)
- [ ] Filter chips reset after login (60%)
- [ ] Drift web production issues (40%)
- [ ] Quiz occasional duplicate words (20%)

---

## 📋 Planned (Milestone 2)

### Q2 2026
| Feature | Priority | Estimate |
|---------|----------|----------|
| Riverpod migration | 🔴 High | 2 weeks |
| Vocabulary Detail Page | 🔴 High | 1 week |
| Delete vocabulary (admin) | 🔴 High | 3 days |
| Error handling improvements | 🔴 High | 1 week |
| SRS basic algorithm | 🟡 Medium | 2 weeks |
| Flashcard mode | 🟡 Medium | 1 week |
| Category quiz selection | 🟡 Medium | 1 week |
| Dark mode | 🟡 Medium | 3 days |

### Q3 2026
| Feature | Priority |
|---------|----------|
| Grammar module | 🟡 Medium |
| Grammar quiz | 🟡 Medium |
| Quiz scoring & streak | 🟡 Medium |
| Import/export CSV | 🟢 Low |
| Daily goal | 🟢 Low |

### Q4 2026
| Feature | Priority |
|---------|----------|
| Kanji module | 🟢 Low |
| Push notifications | 🟢 Low |
| Leaderboard | 🟢 Low |
| Unit tests | 🟢 Low |

---

## 🐛 Known Issues & Bugs

### Critical (Affects User Experience)
| Issue | Status | Root Cause |
|-------|--------|------------|
| Progress bar not updating after toggle | 🔄 In progress | setState not refreshing parent |
| Filter chips reset after login | 🔄 In progress | State not preserved across auth change |
| Quiz fails with <4 words | ✅ Fixed | Added check before quiz starts |

### Moderate
| Issue | Status |
|-------|--------|
| Drift web production errors | 🔄 In progress |
| Search with Vietnamese diacritics | ✅ Fixed |
| Quiz sometimes repeats same word | 📋 Reported |

### Minor
| Issue | Status |
|-------|--------|
| Memory leak in photo page (multiple scans) | 📋 Reported |
| No loading skeleton on list refresh | 📋 Planned |

---

## 📊 Code Statistics
lib/
├── core/ ~15 files ~800 lines
├── features/
│ ├── auth/ ~5 files ~400 lines
│ └── vocabulary/ ~15 files ~1,500 lines
├── shared/ ~3 files ~150 lines
└── main.dart ~1 file ~30 lines

Total: ~2,880 lines (excluding generated)

text

## Test Coverage
| Type | Coverage | Status |
|------|----------|--------|
| Unit Tests | 5% | 📋 Planned |
| Widget Tests | 0% | 📋 Planned |
| Integration Tests | 0% | 📋 Planned |

---

## 📈 Progress Timeline
Dec 2024 ──────────────────────────────────────────────► Mar 2026

[████████████████████████████████████████████] Milestone 1 (Core)
[███████████████████████████░░░░░░░░░░░░░░░] Milestone 2 (40%)
[░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░] Milestone 3 (0%)

Current: Milestone 2 – 40% complete

text

---

## 🎯 Next Sprint Goals (2 Weeks)

### Must Complete
1. **Fix progress bar sync** – ensure UI updates after learned toggle
2. **Fix filter reset after login** – preserve filter state across auth changes
3. **Start Riverpod migration** – create providers for repository and list

### Should Complete
4. **Basic Vocabulary Detail Page** – display all fields, add notes section
5. **Delete vocabulary** – long-press with confirmation

### Could Complete
6. **Improve error messages** – user-friendly, less technical
7. **Add loading skeleton** – better perceived performance

---

## 📝 Notes & Learnings

### What Went Well
- Offline-first architecture works reliably on mobile
- ML Kit integration exceeded expectations for accuracy
- Supabase RLS correctly isolates user data
- Optimistic UI creates smooth experience

### Challenges Encountered
- Drift on web requires different driver (WebSQL) – conditional imports solved this
- ML Kit models are large (30MB) – first translation is slow
- RLS debugging is tricky – needed many SQL console tests

### Lessons Learned
1. Always use `mounted` check after async operations in StatefulWidget
2. Test RLS policies thoroughly before deploying to production
3. Conditional imports are essential for web compatibility
4. Keep models simple – avoid heavy business logic
5. Progressive enhancement > perfect initial implementation

---

## 🚦 Ready for Next Phase

The app has a solid foundation for expansion:

- ✅ Stable vocabulary CRUD
- ✅ Working offline sync (mobile)
- ✅ Proven ML integration
- ✅ Clean architecture foundation

**Ready to add:**
- Riverpod for state management
- SRS engine
- Grammar and Kanji modules
- More polish and testing
