# CONTEXT.md

```markdown
# Project Context – LingoDual

## Project Goals

Build a modern, **offline-capable** Japanese learning companion for Vietnamese JLPT learners (N5–N1) with:

- Strong vocabulary foundation (500+ words, expandable)
- Real-world photo translation (signs, manga, menus, textbooks)
- Personalized progress tracking per user
- Future expansion to grammar, kanji, and SRS

## Target Users

- **Vietnamese students** preparing for JLPT exams
- **Self-learners** wanting structured vocabulary practice
- **Expats/workers in Japan** needing quick reading assistance
- **Anyone** seeking a free, no-barrier Japanese study tool

## Core Problems Solved

| Problem | LingoDual Solution |
|---------|-------------------|
| Apps lack good offline support | Drift SQLite cache + offline fallback |
| Progress not synced across devices | Supabase user progress table + RLS |
| No Vietnamese-friendly photo translation | On-device ML Kit OCR + JP→VN translation |
| Outdated or cluttered UX | Clean Material 3 design, simple navigation |
| Paywalls blocking core features | Free tier with generous limits, guest mode |

## Design Philosophy

1. **Mobile-first, offline-first** – learn anywhere, sync when connected
2. **Simple > perfect** – working MVP beats theoretical perfection
3. **Guest mode first** – no friction to try the app
4. **Reusable patterns** – vocabulary module structure → grammar/kanji modules
5. **Privacy by design** – on-device ML, no image uploads

## Technical Constraints

- **Solo/small-team development** – prioritize working features over deep abstraction
- **Free-tier Supabase** – 500 MB database, 2 GB file storage
- **On-device ML** – no cloud costs, but ~30MB model download
- **Flutter limitations** – web has no SQLite + no ML Kit

## Current State (March 2026)

### What Works Well
- Vocabulary CRUD (fetch, filter, search, toggle progress)
- Quiz (random 4-option)
- Photo translation (OCR + translation)
- Offline cache (mobile)
- Auth (email, guest)

### What Needs Improvement
- State management (still setState)
- No SRS/review system
- Grammar/Kanji modules not started
- Error handling could be more robust
- No background sync queue

## Long-term Vision

**Personalized Japanese Learning Assistant**

- Adaptive SRS scheduling based on user performance
- Weak-point analysis and recommendations
- Multi-skill support (reading, listening, speaking, writing)
- Community features (shared study sets, leaderboards)
- Teacher-student connections for tutoring

## Technical Debt & Known Issues

| Issue | Impact | Plan |
|-------|--------|------|
| setState scattered | Harder to test, debug | Migrate to Riverpod |
| No domain layer | Business logic in repositories | Add UseCases |
| Web offline disabled | Web users need internet | Accept limitation |
| ML Kit web unsupported | No photo translate on web | Show fallback message |

## Key Learnings from Development

1. **Conditional imports** (`if (dart.library.html)`) are essential for web compatibility
2. **Optimistic UI** greatly improves perceived performance
3. **RLS policies** must be tested thoroughly before deploying
4. **Drift** works well but code generation adds complexity
5. **Google ML Kit** models are large – warn users about download

## Resources & References

- [JLPT Vocabulary Lists](https://jlptstudy.net/)
- [Supabase Flutter Docs](https://supabase.com/docs/guides/with-flutter)
- [Drift Documentation](https://drift.simonbinder.eu/)
- [Google ML Kit for Flutter](https://pub.dev/packages/google_mlkit_commons)