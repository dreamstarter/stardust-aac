# 📖 Documentation Index

Welcome to **Stardust AAC** - an iPad communication app for Milla.

This index helps you find the right document for what you need.

---

## 🚀 Getting Started (Read These First)

1. **[README.md](README.md)** - Project overview and purpose
2. **[SUMMARY.md](SUMMARY.md)** - Quick reference of everything planned
3. **[QUICK_START.md](QUICK_START.md)** - Step-by-step guide to start development

---

## 📋 Planning Documents

### Core Specifications
- **[PROJECT_PLAN.md](PROJECT_PLAN.md)** - Complete technical specification
  - Technology choices
  - Data models
  - UI flows
  - Development phases
  - Accessibility requirements

### Design & User Experience
- **[UI_MOCKUPS.md](UI_MOCKUPS.md)** - Visual mockups of all screens
  - Communication board
  - Tile preview
  - Add photo flow
  - Settings screen
  - Color and typography guidelines

### Decision Making
- **[DECISIONS.md](DECISIONS.md)** - Open questions and decisions to make
  - Voice selection strategy
  - Audio priority logic
  - Grid layout configuration
  - Photo organization
  - Development environment

### Research & Analysis
- **[SPEECH_ALBUM_ANALYSIS.md](SPEECH_ALBUM_ANALYSIS.md)** - Feature analysis of reference app
  - Features to adopt
  - Features to skip
  - Implementation recommendations
  - Resolved questions

---

## 🤖 For AI Coding Assistants

- **[.github/copilot-instructions.md](.github/copilot-instructions.md)** - Guidelines for AI agents
  - Architecture overview
  - Data models
  - Common patterns
  - Coding standards
  - Key constraints

---

## 📂 How to Use This Documentation

### When You're First Learning About the Project
```
1. Read README.md (5 min)
2. Read SUMMARY.md (10 min)
3. Review UI_MOCKUPS.md (15 min)
4. Skim PROJECT_PLAN.md (20 min)
```

### When You're Ready to Start Development
```
1. Read QUICK_START.md thoroughly (30 min)
2. Review DECISIONS.md and make choices (20 min)
3. Set up development environment (2-3 hours)
4. Follow Week 1 guide in QUICK_START.md
```

### When You Need Technical Details
```
- Architecture questions → PROJECT_PLAN.md, .github/copilot-instructions.md
- UI/UX questions → UI_MOCKUPS.md
- Feature questions → SPEECH_ALBUM_ANALYSIS.md
- Decision questions → DECISIONS.md
```

### When Working with AI Assistants
```
- Point AI to .github/copilot-instructions.md
- Reference specific sections of PROJECT_PLAN.md
- Show UI_MOCKUPS.md for visual context
```

---

## 🎯 Document Status

| Document | Status | Last Updated | Completeness |
|----------|--------|--------------|--------------|
| README.md | ✅ Complete | Nov 13, 2025 | 100% |
| SUMMARY.md | ✅ Complete | Nov 13, 2025 | 100% |
| PROJECT_PLAN.md | ✅ Complete | Nov 13, 2025 | 100% |
| UI_MOCKUPS.md | ✅ Complete | Nov 13, 2025 | 100% |
| DECISIONS.md | ⏳ In Progress | Nov 13, 2025 | 80% - needs your input |
| SPEECH_ALBUM_ANALYSIS.md | ✅ Complete | Nov 13, 2025 | 100% |
| QUICK_START.md | ✅ Complete | Nov 13, 2025 | 100% |
| .github/copilot-instructions.md | ✅ Complete | Nov 13, 2025 | 100% |
| INDEX.md | ✅ Complete | Nov 13, 2025 | 100% |

---

## 📝 Quick References

### Key Technologies
- **Platform:** iOS 16+ (iPad)
- **Language:** Swift
- **UI:** SwiftUI
- **Storage:** Core Data + local files
- **Audio:** AVFoundation

### Core Features (MVP)
1. Photo capture/upload
2. Simple labels
3. Grid display
4. TTS playback
5. Edit mode toggle
6. Tile preview with auto-close

### Development Timeline
- **MVP:** 4-6 weeks (Phase 1)
- **Audio Recording:** 2-3 weeks (Phase 2)
- **Customization:** 2-3 weeks (Phase 3)
- **Polish:** 2-3 weeks (Phase 4)
- **Total:** ~10-15 weeks

### Key Constraints
- iPad only (no iPhone)
- Offline-first (no internet)
- Local storage only (no cloud)
- 5-second audio limit
- Single-word labels (guidance)

---

## 🔄 Document Relationships

```
INDEX.md (you are here)
    │
    ├─── README.md ───────────┐
    │                         │
    ├─── SUMMARY.md ──────────┼─── Overview Layer
    │                         │
    └─── QUICK_START.md ──────┘
    
    ┌─── PROJECT_PLAN.md ─────┐
    │                         │
    ├─── UI_MOCKUPS.md ───────┼─── Specification Layer
    │                         │
    └─── DECISIONS.md ────────┘
    
    ┌─── SPEECH_ALBUM_ANALYSIS.md ─┐
    │                               │
    └─── .github/copilot-instructions.md ─┴─── Reference Layer
```

---

## 💡 Tips for Using This Documentation

### For Development
1. **Start with QUICK_START.md** - Follow it step by step
2. **Reference PROJECT_PLAN.md** - When you need technical details
3. **Check UI_MOCKUPS.md** - Before implementing any UI
4. **Review copilot-instructions.md** - When using AI assistance

### For Planning
1. **Review DECISIONS.md** - Make outstanding decisions
2. **Read SPEECH_ALBUM_ANALYSIS.md** - Understand feature choices
3. **Study UI_MOCKUPS.md** - Visualize the end product

### For Collaboration
1. **Share README.md** - To introduce the project
2. **Share SUMMARY.md** - For quick overview
3. **Share specific sections** - From PROJECT_PLAN.md as needed

---

## 🔍 Finding Information

### "How do I start development?"
→ **QUICK_START.md**

### "What does the app look like?"
→ **UI_MOCKUPS.md**

### "What are all the features?"
→ **SUMMARY.md** or **PROJECT_PLAN.md**

### "What decisions need to be made?"
→ **DECISIONS.md**

### "Why did we choose this approach?"
→ **SPEECH_ALBUM_ANALYSIS.md** or **PROJECT_PLAN.md**

### "How should I structure the code?"
→ **.github/copilot-instructions.md** or **PROJECT_PLAN.md**

### "What's the project about?"
→ **README.md**

---

## 📞 Document Maintenance

### When to Update

- **After making a decision:** Update DECISIONS.md (mark as decided)
- **After starting development:** Update QUICK_START.md build instructions
- **When architecture changes:** Update PROJECT_PLAN.md and copilot-instructions.md
- **When UI changes:** Update UI_MOCKUPS.md
- **After MVP completion:** Update README.md with screenshots/status

### Versioning

Consider tagging versions in git as you complete phases:
- `v0.1-planning` - Planning complete
- `v0.2-mvp` - MVP complete
- `v0.3-audio` - Audio recording added
- `v0.4-settings` - Settings complete
- `v1.0` - Full release

---

## ✨ Next Steps

1. ✅ Read this index
2. ⬜ Read SUMMARY.md for complete overview
3. ⬜ Review UI_MOCKUPS.md to visualize the app
4. ⬜ Make decisions in DECISIONS.md
5. ⬜ Follow QUICK_START.md to begin development

---

## 🎉 Ready?

You now have a complete plan for building Stardust AAC. Everything you need to know is in these documents.

**Start with:** [QUICK_START.md](QUICK_START.md)

**Good luck, and remember:** You're building something that will help Milla communicate. That's beautiful. ✨
