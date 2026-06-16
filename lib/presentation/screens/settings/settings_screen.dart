import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/theme_provider.dart';
import '../../../core/providers/locale_provider.dart';
import '../../../core/providers/strings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final lang = ref.watch(languageProvider);
    final s = lang == 'pt' ? AppStrings.pt : AppStrings.en;

    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text(s.darkMode),
            subtitle: Text(s.darkModeSubtitle),
            secondary: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            value: isDark,
            onChanged: (_) => ref.read(themeProvider.notifier).toggle(),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(s.language),
            subtitle: Text(lang == 'pt' ? s.portuguese : s.english),
            trailing: SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'pt', label: Text(s.portuguese)),
                ButtonSegment(value: 'en', label: Text(s.english)),
              ],
              selected: {lang},
              onSelectionChanged: (val) =>
                  ref.read(languageProvider.notifier).setLanguage(val.first),
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('GymLog'),
            subtitle: Text('v1.0.0'),
            leading: Icon(Icons.info_outline),
          ),
        ],
      ),
    );
  }
}
