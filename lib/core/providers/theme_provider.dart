import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _themeKey = 'dark_mode';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (_) => SharedPreferences.getInstance(),
);

class ThemeNotifier extends StateNotifier<bool> {
  SharedPreferences? _prefs;

  ThemeNotifier(SharedPreferences? prefs)
      : super(prefs?.getBool(_themeKey) ?? false) {
    _prefs = prefs;
  }

  void toggle() {
    state = !state;
    _prefs?.setBool(_themeKey, state);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).valueOrNull;
  return ThemeNotifier(prefs);
});
