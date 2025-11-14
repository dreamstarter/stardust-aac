# Feature Analysis: Speech Album App

## Reference
**GitHub:** https://github.com/larrj/speechalbumapp  
**Description:** Free, kid-friendly AAC app for non-verbal children using pictures, recordings, and text-to-speech

---

## Key Features to Adopt

### ✅ Core Features (High Priority)

#### 1. **Auto-Close Tile Preview**
- **What:** When a tile is tapped, it shows enlarged and auto-closes after N seconds
- **Options:** 1, 2, 3, 5 seconds, or Manual (tap to close)
- **Default:** 2 seconds
- **Why:** Prevents accidental taps from being disruptive, allows quick return to main grid
- **Implementation:** Modal/overlay that dismisses automatically or on tap

#### 2. **Audio Priority Logic**
- **What:** Custom recording takes priority over TTS if it exists
- **Flow:** Tap photo → Check for custom recording → Play recording OR use TTS
- **Why:** Parent's voice is more personal and meaningful
- **Our Decision:** Adopt this - custom recording first, TTS fallback

#### 3. **Adjustable Tile Size**
- **What:** Slider to adjust tile size (140px - 360px in their app)
- **Why:** Different users have different motor skills and visual needs
- **Location:** Settings screen
- **Our Adaptation:** Could use size presets (Small, Medium, Large) instead of slider initially

#### 4. **Colorful Tile Backgrounds**
- **What:** Optional colored gradients on tiles vs plain backgrounds
- **Why:** Visual appeal for children, helps differentiation
- **Toggle:** Settings option to enable/disable
- **Our Decision:** Add in Phase 4 (polish), start with simple backgrounds

#### 5. **Speech Speed Control**
- **What:** Slider to adjust TTS voice speed
- **Why:** Some users need slower speech for comprehension
- **Location:** Settings → Voice section
- **Our Decision:** Essential accessibility feature - include in Phase 3

#### 6. **Edit Mode Toggle**
- **What:** Separate "view/use" mode from "edit" mode
- **Why:** Prevents accidental edits during communication
- **UI:** Edit button (pencil icon) in toolbar
- **Our Decision:** Adopt this - critical for child-proofing

### 🔄 Secondary Features (Medium Priority)

#### 7. **Folder/Category System**
- **What:** Organize tiles into folders (e.g., "Food", "Emotions", "Actions")
- **Features:**
  - Create named folders
  - Move tiles between folders
  - Folder thumbnail image
  - Navigate in/out of folders
- **Why:** Organization for large collections (10+ items)
- **Our Decision:** Phase 5 - start simple, add when needed

#### 8. **Multi-Select and Batch Operations**
- **What:** Select multiple tiles → Move to folder, Delete
- **Why:** Efficient management of multiple items
- **Our Decision:** Phase 4 - useful but not MVP critical

#### 9. **Drag-to-Reorder**
- **What:** Long-press and drag tiles to reorder in grid
- **Why:** Custom organization based on usage patterns
- **Our Decision:** Phase 4 - nice to have, not essential initially

#### 10. **Max Pictures Limit**
- **What:** Setting to limit total number of tiles (10-100)
- **Why:** Prevents overwhelming interface, encourages curation
- **Our Decision:** Consider for Phase 4, may not be needed if folders exist

### 💡 Ideas to Consider

#### 11. **Recording Duration Tied to Auto-Close**
- **Their approach:** Max recording duration matches auto-close timer
- **Ours:** Fixed 5-second recording limit
- **Question:** Should we tie recording length to a display duration setting?
- **Decision:** Keep separate - recording is permanent content, auto-close is UI behavior

#### 12. **Voice Selection**
- **What:** Choose from available iOS system voices
- **Their approach:** Global voice selection in settings
- **Ours:** Originally planned per-photo voices
- **Decision:** Start global (like Speech Album), add per-photo override later

#### 13. **Thumbnail vs Full-Size Display**
- **Their approach:** Tiles show preview, tap to enlarge
- **Ours:** Need to decide on interaction model
- **Options:**
  - A) Tap plays audio immediately (no enlarge)
  - B) Tap enlarges + plays audio, auto-closes
- **Recommendation:** Option B - better feedback, more engaging

---

## Features We Planned That They Don't Have

### 1. **Per-Photo Voice Selection** (Future)
- We want to allow different voices per photo
- Could be useful for representing different people/characters
- Add in Phase 3 after testing global voice

### 2. **5-Second Recording Limit Display**
- We planned visual timer during recording
- They tie it to auto-close setting (more flexible)
- Consider adopting their approach

### 3. **Single-Word Label Enforcement**
- We want to encourage single words
- They don't mention this restriction
- Decision: Keep as guidance, not hard restriction

---

## Privacy & Storage Alignment

Both apps share identical privacy principles:
- ✅ Local-only storage (Documents directory)
- ✅ No cloud sync (they explicitly exclude from iCloud backup)
- ✅ No analytics or tracking
- ✅ Offline-capable
- ✅ No third-party services
- ✅ All permissions (camera, photos, mic) used locally only

---

## UI/UX Patterns to Adopt

### Main View Structure
```
[Edit Button] [Settings Button]
┌─────────┬─────────┬─────────┐
│ [Tile]  │ [Tile]  │ [Tile]  │
│ Colorful│  with   │ Gradient│
│  Label  │  Label  │  Label  │
├─────────┼─────────┼─────────┤
│ [Tile]  │ [Tile]  │ [Tile]  │
└─────────┴─────────┴─────────┘
```

### Edit Mode Changes
- Show selection indicators on tiles
- Enable long-press to drag/reorder
- Show delete/move actions
- Display [+] Add button prominently
- Display [New Folder] button

### Tile Tap Behavior (Communication Mode)
```
1. Tap tile → Enlarge + Play audio
2. Show enlarged photo with label
3. Audio plays (custom recording or TTS)
4. Auto-close after N seconds OR tap to close
```

### Settings Organization
```
⚙️ Settings
  📐 Display
    - Tile Size: [Slider or Presets]
    - Use Colors: [Toggle]
  
  🎤 Voice
    - Voice: [Picker]
    - Speech Speed: [Slider]
  
  ⏱️ Behavior
    - Auto-close Duration: [1s / 2s / 3s / 5s / Manual]
  
  📸 Limits (optional)
    - Max Pictures: [Slider]
```

---

## Implementation Priorities (Updated)

### Phase 1: MVP Core
- [ ] Photo capture/upload
- [ ] Simple grid display
- [ ] Label input (guidance for single word)
- [ ] TTS with default voice
- [ ] **Tap to enlarge + play audio**
- [ ] **Auto-close after 2 seconds (configurable later)**
- [ ] **Edit mode toggle**

### Phase 2: Audio & Settings
- [ ] 5-second audio recording
- [ ] Custom recording priority over TTS
- [ ] **Settings screen**
- [ ] **Speech speed control**
- [ ] **Auto-close duration setting**

### Phase 3: Voice & Polish
- [ ] Voice selection (global)
- [ ] **Tile size adjustment**
- [ ] Edit/delete photos
- [ ] VoiceOver support

### Phase 4: Advanced Organization
- [ ] Drag-to-reorder
- [ ] **Colorful tile backgrounds (optional)**
- [ ] Multi-select
- [ ] **Folder system**

---

## Key Takeaways

1. **Edit Mode is Critical** - Separate edit from use mode to prevent accidental changes
2. **Auto-Close Enhances UX** - Makes communication flow more natural
3. **Tile Enlargement** - Shows user feedback and makes labels more readable
4. **Simple Settings Structure** - Organized by function (Display, Voice, Behavior)
5. **Custom Recording Priority** - Always prefer personal recordings over TTS
6. **Flexibility in Organization** - Folders are powerful but not needed immediately

---

## Questions Resolved

- ✅ **Audio Priority:** Custom recording first, TTS fallback (matches Speech Album)
- ✅ **Edit Mode:** Separate mode with toggle (adopt their approach)
- ✅ **Voice Selection:** Start with global, add per-photo later
- ✅ **Tile Interaction:** Tap → Enlarge + Play + Auto-close

## New Questions

1. **Auto-close duration:** Start with fixed 2 seconds or make configurable in MVP?
   - **Recommendation:** Fixed 2 seconds for MVP, add setting in Phase 2

2. **Tile enlargement style:** Modal overlay vs full-screen vs popover?
   - **Recommendation:** Modal overlay (centered, dimmed background)

3. **Recording duration:** Keep 5 seconds fixed or tie to auto-close?
   - **Recommendation:** Keep separate - 5 seconds for recording, auto-close is independent

4. **Colors/gradients:** Essential or nice-to-have?
   - **Recommendation:** Nice-to-have, Phase 4 feature

---

## Updated Feature Set for Stardust AAC

### MVP (Phase 1)
1. Photo capture/upload ✓
2. Label input ✓
3. Grid display ✓
4. TTS with default voice ✓
5. **Edit mode toggle** ← NEW
6. **Tap to enlarge + play** ← NEW
7. **Auto-close (2 sec fixed)** ← NEW

### Phase 2
1. Audio recording (5 sec) ✓
2. Custom recording priority ✓
3. **Settings screen** ← NEW
4. **Auto-close duration setting** ← NEW
5. **Speech speed control** ← NEW

### Phase 3
1. Voice selection (global) ✓
2. **Tile size adjustment** ← NEW
3. Edit/delete photos ✓

### Phase 4
1. Drag-to-reorder ✓
2. **Colorful tiles** ← NEW
3. Multi-select ← NEW
4. VoiceOver support ✓

### Phase 5
1. **Folder system** ← NEW (adopted from Speech Album)
2. iCloud backup (optional) ✓
3. Multiple user profiles ✓
