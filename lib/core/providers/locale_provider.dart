import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_provider.dart';

const _localeKey = 'language';

class LocaleNotifier extends StateNotifier<String> {
  SharedPreferences? _prefs;

  LocaleNotifier(SharedPreferences? prefs)
      : super(prefs?.getString(_localeKey) ?? 'pt') {
    _prefs = prefs;
  }

  void setLanguage(String lang) {
    state = lang;
    _prefs?.setString(_localeKey, lang);
  }
}

final languageProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider).valueOrNull;
  return LocaleNotifier(prefs);
});
