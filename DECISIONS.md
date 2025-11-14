# Open Questions & Decisions

## Questions for Discussion

### 1. Voice Selection Strategy
**Question:** Should each photo have its own voice, or use a global default initially?

**Options:**
- **Global default** (recommended for MVP) - One voice for all photos, can be changed in settings
- **Per-photo voices** - Each photo can have a different voice selected
- **Hybrid** - Global default with option to override per photo

**Recommendation:** Start with global default to simplify MVP, add per-photo override in Phase 3.

---

### 2. Audio Priority/Playback Mode
**Question:** When both custom recording and TTS exist for a photo, which should play by default?

**Options:**
- **Custom recording priority** - Always play parent's recorded voice if it exists
- **TTS priority** - Always use text-to-speech for consistency
- **User choice per photo** - Toggle between modes for each photo
- **Global setting** - App-wide preference in settings

**Recommendation:** Custom recording priority (more personal/meaningful), with global setting to override.

---

### 3. Grid Layout Configuration
**Question:** Should the grid layout be fixed or user-adjustable?

**Options:**
- **Fixed 3x3** - Simple, consistent layout
- **User-adjustable** (2, 3, or 4 columns) - More flexible for different needs
- **Auto-adaptive** - Adjusts based on screen orientation and number of photos

**Recommendation:** Start with fixed 3 columns (portrait) / 4 columns (landscape), add user adjustment in Phase 4.

---

### 4. Photo Organization/Categories
**Question:** Should we plan for folders/categories from the start?

**Options:**
- **Single board only** (MVP) - All photos in one grid
- **Categories from start** - E.g., "Food", "Emotions", "Actions", "People"
- **Add later** - Start simple, add organization in Phase 5

**Examples of useful categories:**
- Food & Drinks
- People & Family
- Emotions & Feelings
- Actions & Activities
- Places
- Wants & Needs

**Recommendation:** Start with single board, add categories in Phase 5 after understanding usage patterns.

---

### 5. Development Environment
**Question:** What do you have access to for development?

**Checklist:**
- [x] Windows PC for development
- [ ] Flutter SDK installed on Windows
- [ ] VS Code or Android Studio installed
- [ ] iPad for testing (real device testing via USB)
- [ ] iOS version on iPad (should be 12.0 or higher)
- [ ] Rick's Mac for final App Store build
- [ ] Apple Developer account ($99/year for App Store, free for device testing)

**Decision:** Using Flutter to develop on Windows, Rick's Mac for final submission only

---

### 6. Single-Word Label Enforcement
**Question:** How strict should the "single word" requirement be?

**Options:**
- **Strict validation** - Only allow one word (block spaces/multiple words)
- **Guidance only** - Allow multiple words but encourage single words
- **Flexible** - Allow short phrases (2-3 words) for complex concepts

**Recommendation:** Start with guidance (warning but allow), can adjust based on usage.

---

### 7. Photo Editing/Management
**Question:** What level of photo management is needed?

**Features to consider:**
- Edit label/audio after creation
- Delete photos
- Reorder photos (drag & drop)
- Duplicate photos with different labels
- Crop/rotate photos

**Recommendation:** Edit and delete in MVP, reorder in Phase 4, crop/rotate if needed based on feedback.

---

### 8. Audio Recording Quality
**Question:** What audio quality and format should we use?

**Options:**
- **High quality** (44.1kHz stereo) - Larger files, better quality
- **Medium quality** (22kHz mono AAC) - Balanced
- **Phone quality** (16kHz mono) - Smaller files, sufficient for speech

**Recommendation:** 22kHz mono AAC - good balance for speech clarity and file size.

---

## Decisions Log

_This section will track decisions as they're made:_

- [ ] Decision 1: Voice selection strategy
- [ ] Decision 2: Audio playback priority
- [ ] Decision 3: Grid layout approach
- [ ] Decision 4: Category/organization timing
- [ ] Decision 5: Development environment confirmed
- [ ] Decision 6: Label validation approach
- [ ] Decision 7: Photo management features for MVP
- [ ] Decision 8: Audio quality settings

---

## Next Steps

1. Review speechalbumapp for inspiration
2. Make decisions on open questions
3. Finalize MVP feature set
4. Begin Xcode project setup
