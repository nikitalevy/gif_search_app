# GIF Search App

Flutter app for searching GIFs using the Giphy API.  
Supports search with debounce, infinite scroll, detail view, loading and error states.

---

## Flutter version
```
Flutter 3.35.3 • channel stable
Dart 3.9.2 • DevTools 2.48.0
```

---

## Features
- Search GIFs from Giphy  
- Auto search (runs 500ms after typing stops)  
- Pagination (load more on scroll)  
- Works in portrait and landscape  
- Grid view for results  
- Detail screen for a single GIF  
- Loading indicators  
- Error display  
- Unit tests for model, service and state logic  

---

## Project structure
```
lib/
 ├─ config/app_config.dart
 ├─ data/
 │   ├─ models/gif_model.dart
 │   ├─ repository/gif_repository.dart
 │   └─ services/giphy_api_service.dart
 └─ features/
     └─ search/
         ├─ presentation/ (UI screens)
         └─ state/search_notifier.dart
test/
 ├─ data/models/gif_model_test.dart
 ├─ data/services/giphy_api_service_test.dart
 └─ features/search/state/search_notifier_test.dart
```

---

## Setup
1. Get a free API key at https://developers.giphy.com/  
2. Put it into `lib/config/app_config.dart`:

```dart
class AppConfig {
  static const String giphyBaseUrl = 'https://api.giphy.com/v1/gifs';
  static const String giphyApiKey  = 'YOUR_API_KEY';
}
```

3. Run the app:
```bash
flutter pub get
flutter run
```

---

## Running tests
```bash
flutter test
```

---

## Notes
- State management: Riverpod  
- Error handling is in place, but network availability banner could be improved  
- Navigation is simple; could be moved to a Coordinator/Router later  

---

## Task requirements vs implementation

**What was required in the task:**
- App should work on iOS & Android  
- Auto search with delay  
- Pagination (scroll to load more)  
- Portrait + landscape support  
- Error handling  
- Unit tests  
- At least 2 views (grid + detail)  
- Grid view of results  
- Detail view on tap  
- Loading indicators  
- Error display  
- Use state management (BLoC / Riverpod)  
- Clear architecture  
- Separate navigation (Coordinator pattern)  
- Network availability handling  
- Document Flutter version in README  

**What was implemented:**
- iOS & Android ready  
- Auto search with debounce ✅  
- Pagination ✅  
- Portrait + landscape ✅  
- Error handling ✅  
- Unit tests ✅  
- Grid + detail screens ✅  
- Loading indicators ✅  
- Error messages ✅  
- State management: Riverpod ✅  
- Clear separation data/features ✅  
- Navigation still inside UI (no Coordinator yet)  
- Network availability handled in service, not in UI banner  
- Flutter version documented in this README ✅  
