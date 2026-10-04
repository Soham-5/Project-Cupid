# Moments - Gen Z Dating App ("Collage of Moments")

A pixel-faithful Flutter implementation of the Gen Z collage dating app moodboard. Built with Flutter (Material 3), Riverpod, GoRouter, Google Fonts, and custom canvas/path rendering.

---

## 🎨 Visual Architecture & Features

### 1. Reusable Collage Design System (`lib/shared/widgets/`)
- **`TornPaper`**: Uses deterministic mathematical jitter (`CustomClipper<Path>`) with soft drop shadows (`MaskFilter.blur`) to produce realistic torn paper edges (top, bottom, left, right, or all).
- **`TapeStrip`**: Custom-painted translucent masking tape strips with serrated edges and subtle fiber sheen lines.
- **`Polaroid` / `PhotoScrap`**: Cream frame, subtle tilt (`-4°` to `+4°`), drop shadow, tape pins, and grayscale B&W photo filter.
- **`StickerBadge`**: Vector-drawn lime circular "her vibe" sticker, lime smiley sticker, and 12-point starburst badge.
- **`StickyNote`**: Realistic torn sticky notes (Pink "FUNKY but minimal", Yellow "COLLAGE of moments", Lime "DIFFERENT by design", and interactive Lime "or! surprise me" dice note).
- **Micro-Elements & Doodles**:
  - `ScribbleOvalWrapper`: Hand-drawn lime scribble loops around "cool?" and "let's go!".
  - `ScribbleUnderlinePainter`: Pink hand-drawn brush underline beneath "start talking".
  - `HeartDoodle`: Outlined pink hand-drawn sketch heart.
  - `SparkleDoodle`: 4-point hand-drawn asterisk/sparkle.
  - `SpiderDoodle`: Hand-drawn spider icon for Spider-Man plans and matches.
  - `MoonDoodle`: Lime crescent moon for late-night drives.
  - `HandwrittenPillButton`: Black pill button with cream marker text and pink scribble underline.

### 2. Custom Bottom Navigation Bar (`lib/shared/widgets/custom_bottom_nav.dart`)
- Implements **Variant 1** from the moodboard:
  - Cream paper torn strip background across the bottom.
  - 5 tabs: **home**, **plans**, **match**, **vibes**, **you**.
  - Active tab receives a lime rounded square highlight indicator with an elastic bounce animation (`flutter_animate` / `AnimationController`).

### 3. Core Screens Implemented (`lib/features/`)
1. **Home Screen (`/home`)**:
   - Paper cream background (`#ECE5D8`).
   - "For you, by your people" handwritten cursive header with friend avatar stack (`+3` badge).
   - Large B&W hero portrait of Sara with torn bottom/right edges, tape pin, overlapping color sunset palm polaroid scrap, vinyl record player scrap, and floating `+` button.
   - Overlapping lime "her vibe" sticker and black torn paper card (`SARA, 20` + tags).
   - Lavender torn "Plan idea" card (`SPIDER-MAN TONIGHT?` + spider doodle + "maybe ↓" button + "let's go!" button).
   - Vertically scrollable with spring physics.
2. **Plans Screen (`/plans`)**:
   - Charcoal dark background (`#0C0B0B`).
   - "plan something cool?" with hand-drawn lime scribble oval and pink circular `+` button.
   - 4 distinct plan cards:
     - `SPIDER-MAN TONIGHT`: Dark torn card, Times Square city photo left, 2 going, purple/pink starburst stickers.
     - `CAFE HANGOUT`: Cream torn card, cafe photo right, tape strip on top, 3 going.
     - `LATE NIGHT DRIVE`: Dark outlined card, sunset highway photo left, crescent moon doodle, 1 going.
     - `ART EXHIBIT THIS WEEKEND`: Cream card, gallery photo right, pink outline heart doodle, 4 going.
   - Interactive lime sticky note `or! surprise me` with dice: tapping rolls and selects a random plan.
3. **Profile Screen (`/profile` - "you" tab)**:
   - Charcoal dark background (`#0C0B0B`).
   - Back arrow and options menu.
   - B&W photo scrap of Arjun holding vintage 35mm camera with top tape strip, lime smiley sticker, vinyl record scrap, and black torn card (`ARJUN, 21 / photographer / music nerd / overthinker / dog person`).
4. **Match Screen (`/match`)**:
   - Paper cream background (`#ECE5D8`).
   - "it's a match!" handwritten title with pink sketch heart doodle.
   - Dual tilted polaroids of Sara & Arjun pinned with tape strips.
   - Flanked by sparkle and spider doodles: "you both want spider-man tonight".
   - "start talking" black pill button with pink scribble underline stroke + "maybe later" link.
5. **Vibes Screen (`/vibes`)**:
   - Purple torn note with "WHY THIS STANDS OUT" manifesto (`collage > swipe`, `plans > profiles`, `friends > algorithms`, `vibes > perfection`).
   - Funky & Different sticky notes.
   - Direct chat conversation starter with Arjun.

---

## 🚀 Running the App

### Requirements
- Flutter SDK 3.22+ / 3.41+ (Dart 3.4+)

### Run on Chrome (Web)
```bash
flutter run -d chrome
```

### Run on Android / iOS Simulator
```bash
flutter run
```

### Run Test Suite & Static Analysis
```bash
flutter test
flutter analyze
```

---

## 🖼️ Assets & Font Customization Guide

All images are configured in `assets/images/` and registered in `pubspec.yaml`:

| Asset File | Purpose / Used In | Replacement Recommendations |
| :--- | :--- | :--- |
| `assets/images/sara_hero.jpg` | Hero portrait for Sara on Home screen | Any portrait photo (3:4 aspect ratio, high contrast B&W recommended) |
| `assets/images/arjun_camera.jpg` | Hero photo for Arjun profile & Match polaroid | Candid photo (e.g. holding camera or smiling) |
| `assets/images/sunset_palms.jpg` | Tilted color polaroid scrap on Home screen | Colorful travel/vacation photo |
| `assets/images/vinyl_record.jpg` | Music hobby scrap on Home and Profile screens | Photo of record player, headphones, or book |
| `assets/images/city_night.jpg` | Spider-Man plan card image | Nighttime city lights or movie theater marquee |
| `assets/images/cafe_interior.jpg` | Cafe Hangout plan card image | Coffee shop or plant-filled interior photo |
| `assets/images/night_drive.jpg` | Late Night Drive plan card image | Sunset highway or car POV photo |
| `assets/images/art_gallery.jpg` | Art Exhibit plan card image | Art gallery or museum exhibition photo |
| `assets/images/friend_1.jpg` | Friend avatar stack & attendee indicators | Square headshot avatar |
| `assets/images/friend_2.jpg` | Friend avatar stack & attendee indicators | Square headshot avatar |

### Fonts
The app uses Google Fonts via the `google_fonts` package (downloaded automatically at runtime or can be vendored for offline apps):
- **Marker Titles**: `Caveat Brush` (`GoogleFonts.caveatBrush`)
- **Handwritten Accents**: `Caveat` (`GoogleFonts.caveat`)
- **Body & Metadata**: `DM Sans` (`GoogleFonts.dmSans`)
- **Secondary Marker**: `Patrick Hand SC` (`GoogleFonts.patrickHandSc`)
