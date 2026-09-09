# Survey Toolkit - Project Specification

## Overview
**Survey Toolkit** is a Flutter-based calculator app for civil engineering students and field surveyors. It provides 15+ essential surveying calculations with a modern glass-morphism UI.

## Tech Stack
- **Framework**: Flutter 3.x (Dart)
- **UI**: Material 3 with custom dark theme, glass-morphism effects
- **Icons**: Lucide Icons (MIT licensed)
- **Fonts**: Google Fonts (Inter)
- **Animations**: flutter_animate
- **Platform**: Android (primary), iOS, Web, Windows, macOS, Linux

## Project Structure
```
survey_toolkit/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── src/
│   │   ├── calc/
│   │   │   └── survey_math.dart     # All calculation logic (port from Kotlin)
│   │   ├── theme/
│   │   │   └── app_theme.dart       # Dark theme, glass decorations
│   │   ├── ui/
│   │   │   ├── navigation/
│   │   │   │   └── glass_pill_navigation.dart  # 4-tab glass pill nav
│   │   │   ├── widgets/
│   │   │   │   └── common_widgets.dart         # Reusable UI components
│   │   │   └── screens/
│   │   │       ├── main_shell.dart             # PageView + navigation
│   │   │       ├── home_screen.dart            # Dashboard with quick tools
│   │   │       ├── tools_screen.dart           # All tools by category
│   │   │       ├── guides_screen.dart          # 30+ detailed guides
│   │   │       └── about_screen.dart           # App info, credits, legal
```

## Navigation (Glass Pill Design)
4 tabs in a floating glass pill at bottom:
1. **Dashboard** (`AppTab.home`) - Quick access grid
2. **Tools** (`AppTab.tools`) - All calculations organized by category
3. **Guides** (`AppTab.guides`) - Tutorials with difficulty levels
4. **About** (`AppTab.about`) - App info, tech stack, credits

## Calculations Implemented (survey_math.dart)

### Core Data Classes
- `LatitudeDeparture` - Lat/Dep components
- `CoordinateSolution` - Easting/Northing with Lat/Dep
- `TraverseLineInput/Result` - Traverse line data
- `TraverseAnalysis` - Full traverse with corrections
- `AreaPoint` - Coordinate point for polygons
- `CircleResult` - Circle center + radius
- `IntersectionResult` - Intersection point + distances
- `ResectionResult` - Resection position + residuals
- `MissingLinesResult` - Two missing line solution
- `LevelingResult` - HI, elevation, BS/FS
- `SecantsResult` - Offsets + area for curves

### Required Calculations (11 from spec)
| # | Calculation | Function | Status |
|---|-------------|----------|--------|
| 1 | Traverse Calculation | `analyzeTraverse()` | ✅ |
| 2 | Bearing + Distance → Coordinate | `coordinateFromStart()` | ✅ |
| 3 | Coordinate → Bearing + Distance | `distanceBetweenCoordinates()`, `bearingBetweenCoordinates()` | ✅ |
| 4 | Secants Equal Width | `secantsEqualWidth()` | ✅ |
| 5 | Secants Non-Equal Width | `secantsNonEqualWidth()` | ✅ |
| 6 | Area by Coordinates | `areaByCoordinates()` | ✅ |
| 7 | Center of Circle (3 pts) | `centerOfCircle()` | ✅ |
| 8 | 2 Missing Lines | `twoMissingLines()` | ✅ |
| 9 | Leveling Survey | `levelingSurvey()` | ✅ |
| 10 | Center Point (Centroid) | `centerPoint()` | ✅ |
| 11 | Intersection (Bearing-Bearing) | `intersection()` | ✅ |
| 12 | Resection (3-Point) | `resection()` | ✅ |

### Supporting Functions
- Bearing: `normalizeBearing()`, `wcbToQuadrantBearing()`, `quadrantBearingToWcb()`
- Angles: `internalAngleFromBearings()`, `bearingFromKnownAndInternal()`
- Core: `latitudeDeparture()`, `linearMisclose()`, `traverseAccuracyRatio()`
- Corrections: Bowditch (compass rule), Transit rule

## UI Components (common_widgets.dart)
- `GlassCard` - Frosted glass container with border
- `GlassInputField` - Styled text field
- `SectionHeader` - Category titles with accent icons
- `ResultCard` - Highlighted result display
- `ToolCard` - Tool selection card with tags
- `EmptyState` - Placeholder with action
- `LoadingOverlay` - Full-screen loader

## Tools Screen Categories
1. **Traverse & Coordinates** (4 tools)
2. **Bearing & Angle** (3 tools)
3. **Geometry & Area** (3 tools)
4. **Intersection & Resection** (2 tools)
5. **Curve & Alignment** (2 tools)
6. **Leveling** (1 tool)

Each tool opens a modal bottom sheet with contextual input fields.

## Guides Screen
30+ guides across 7 categories:
- Getting Started (3)
- Traverse Calculations (4)
- Coordinate Geometry (4)
- Bearing & Angle Operations (3)
- Advanced Surveying (4)
- Curve & Alignment (2)
- Leveling & Vertical Control (2)

Each guide has: title, description, icon, difficulty (beginner/intermediate/advanced), expandable detail sheet.

## Theme (app_theme.dart)
- **Primary Dark**: `#1B2128`
- **Surface**: `#222831`
- **Surface Variant**: `#2D353F`
- **Accents**: Blue `#64B5F6`, Teal `#4DB6AC`, Amber `#FFCC80`, Purple `#BA68C8`, Green `#66BB6A`
- **Glass**: White 10-18% opacity, white 20% border
- **Typography**: Google Fonts Inter

## Key Formulas Reference
```
Latitude  = Distance × cos(Bearing)
Departure = Distance × sin(Bearing)
Linear Misclose = √(ΣLat² + ΣDep²)
Accuracy Ratio = Total Distance / Linear Misclose

Bowditch:  ΔLat = -ΣLat × (LineDist / TotalDist)
Transit:   ΔLat = -ΣLat × (|Lat| / Σ|Lat|)

Area (shoelace): ½ | Σ(Eᵢ×Nᵢ₊₁ - Eᵢ₊₁×Nᵢ) |

Leveling HI: HI = BM + BS;  Elevation = HI - FS
```

## Running the Project
```bash
flutter pub get
flutter run          # Hot reload with 'r', restart with 'R'
flutter test         # Run unit tests
flutter analyze      # Static analysis
```

## Android-Specific Notes
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)
- **Architectures**: arm64-v8a, armeabi-v7a, x86_64
- **Permissions**: No special permissions required (offline-only)
- **Build APK**: `flutter build apk --release`
- **Build App Bundle**: `flutter build appbundle --release` (for Play Store)
- **ProGuard/R8**: Enabled by default for release builds
- **Signing**: Configure `android/app/build.gradle.kts` for release signing
- **Orientation**: Portrait locked (configure in `AndroidManifest.xml` if needed)

## Porting Notes (from Kotlin)
- Original: `app/src/main/java/.../ui/SurveyMath.kt`
- All functions ported 1:1 with Dart idioms
- Data classes → Dart classes with `copyWith`, `==`, `hashCode`
- Extension functions → top-level functions
- `MutableState` → Flutter `StatefulWidget` / providers
- Compose `@Preview` → Flutter preview widgets or `flutter run`

## Future Enhancements
- [ ] Unit tests for all calculations
- [ ] Export results (CSV/PDF)
- [ ] Project save/load (local storage)
- [ ] GPS coordinate input
- [ ] Unit converter (ft/m, DMS/decimal)
- [ ] Dark/light theme toggle
- [ ] Localization support