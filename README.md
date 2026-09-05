# Survey Toolkit

Survey Toolkit is a Flutter-based calculator application designed for civil engineering students and field surveyors. It offers 15+ essential surveying computations with a dark glass-morphism interface.

## Features

- **15+ Survey Calculations**: Traverse analysis, coordinate transformations, intersection/resection, circle center, missing lines, leveling, secants, area calculation.
- **Glass-Morphism UI**: Dark theme styling built with Material 3 and smooth animations.
- **Interactive Guides**: 30+ detailed guides categorized by surveying discipline and difficulty level.
- **Offline First**: Runs completely offline with no network dependencies.

## Tech Stack

- **Framework**: Flutter 3.x (Dart)
- **UI**: Material 3, custom glass-morphism decorations
- **Icons**: Lucide Icons
- **Typography**: Google Fonts (Inter)
- **Animations**: `flutter_animate`
- **Target Platforms**: Android, iOS, Web, Windows, macOS, Linux

## Project Structure

```
survey_toolkit/
├── lib/
│   ├── main.dart                    # Application entry point
│   └── src/
│       ├── calc/
│       │   └── survey_math.dart     # Survey math and calculation engine
│       ├── theme/
│       │   └── app_theme.dart       # Theme definitions and glass styles
│       └── ui/
│           ├── navigation/
│           │   └── glass_pill_navigation.dart  # Floating navigation pill
│           ├── widgets/
│           │   └── common_widgets.dart         # Reusable glass UI components
│           └── screens/
│               ├── main_shell.dart             # Root scaffold & tab controller
│               ├── home_screen.dart            # Quick tools dashboard
│               ├── tools_screen.dart           # Categorized tool catalog
│               ├── guides_screen.dart          # Step-by-step guides
│               └── about_screen.dart           # App info and credits
```

## Calculations Included

| Calculation | Method / Function | Status |
|---|---|---|
| Traverse Calculation | `analyzeTraverse()` (Bowditch & Transit rules) | Supported |
| Bearing + Distance to Coordinate | `coordinateFromStart()` | Supported |
| Coordinate to Bearing + Distance | `distanceBetweenCoordinates()`, `bearingBetweenCoordinates()` | Supported |
| Secants (Equal Width) | `secantsEqualWidth()` | Supported |
| Secants (Non-Equal Width) | `secantsNonEqualWidth()` | Supported |
| Area by Coordinates | `areaByCoordinates()` (Shoelace formula) | Supported |
| Center of Circle (3 Points) | `centerOfCircle()` | Supported |
| 2 Missing Lines | `twoMissingLines()` | Supported |
| Leveling Survey | `levelingSurvey()` (HI method) | Supported |
| Center Point (Centroid) | `centerPoint()` | Supported |
| Intersection (Bearing-Bearing) | `intersection()` | Supported |
| Resection (3-Point) | `resection()` | Supported |

## Getting Started

### Prerequisites

- Flutter SDK (3.x or later)
- Dart SDK (compatible with Flutter 3.x)

### Setup & Run

1. Clone repository and fetch dependencies:
   ```bash
   flutter pub get
   ```

2. Run application:
   ```bash
   flutter run
   ```

3. Run tests and static analysis:
   ```bash
   flutter test
   flutter analyze
   ```

### Android Build

- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)

```bash
# Build release APK
flutter build apk --release

# Build release App Bundle
flutter build appbundle --release
```

## License

MIT License.
