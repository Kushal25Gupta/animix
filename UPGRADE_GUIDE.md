# Animix Upgrade Guide

## Current Status

The app is currently **not workable** with Flutter 3.29.0 due to several compatibility issues:

1. The codebase was built for an older Flutter version (likely Flutter 2.x)
2. Many dependencies are outdated and use deprecated APIs
3. UI components are using deprecated styling methods
4. There are version conflicts between packages

## Steps to Make the App Workable

### Option 1: Use Flutter 2.x (Recommended for Quick Fix)

The easiest way to make this app work is to use Flutter 2.x, which is the version it was likely developed with:

```bash
# Install Flutter version management tool
dart pub global activate fvm

# Install Flutter 2.10.5
fvm install 2.10.5

# Use this version for the project
fvm use 2.10.5

# Run with this version
fvm flutter pub get
fvm flutter run
```

### Option 2: Upgrade Dependencies and Fix Code (More Work)

If you want to use the latest Flutter version (3.29.0), you'll need to:

1. **Update package dependencies** in `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     youtube_player_flutter: ^9.0.0
     flutter_html: ^3.0.0
     video_player: ^2.7.0
     provider: ^6.1.0
     http: ^1.1.0
     shimmer: ^3.0.0
     url_launcher: ^6.2.0
     shared_preferences: ^2.2.0
     audioplayers: ^5.0.0
     fluttertoast: ^8.2.0
     hive: ^2.2.0
     hive_flutter: ^1.1.0
     path_provider: ^2.1.0
     firebase_analytics: ^10.5.0
     firebase_core: ^2.15.0
     wakelock_plus: ^1.1.3  # Replacement for wakelock
   ```

2. **Fix UI component styling** in these files:
   - `lib/widgets/detail_bottom_sheet.dart`
   - `lib/widgets/filter_bottom_sheet.dart`
   
   Replace deprecated styling:
   - Change `ElevatedButton.styleFrom(onPrimary:)` to `ElevatedButton.styleFrom(foregroundColor:)`
   - Change `TextButton.styleFrom(primary:)` to `TextButton.styleFrom(foregroundColor:)`
   - Replace `theme.accentColor` with `theme.colorScheme.secondary`

3. **Fix YouTube player widget**:
   - Update the imports to use the newer youtube_player_flutter package
   - Replace `SystemChrome.setEnabledSystemUIOverlays` with `SystemChrome.setEnabledSystemUIMode`

4. **Update Firebase hash implementation**:
   - Replace `hashValues()` with `Object.hash()` in Firebase-related files

5. **Upgrade Gradle configuration**:
   - Use plugin DSL in android/app/build.gradle and android/settings.gradle
   - Update Gradle wrapper to 7.5+

## API Considerations

The app uses the Jikan API (MyAnimeList unofficial API). Make sure to update the API endpoints in the code if they have changed since the app was developed.

## Testing

After making these changes:
1. Run `flutter pub get` to update dependencies
2. Run `flutter analyze` to check for remaining issues
3. Run `flutter run` to test the app on a device

## Notes

- The original app used AniApi, but the Jikan-API branch uses the Jikan API
- Some API endpoints may have changed or be deprecated, requiring additional code updates 