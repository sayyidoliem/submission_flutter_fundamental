import 'package:dicoding_submission_flutter_fundamental/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';

Widget buildThemeSwitch(BuildContext context, ThemeProvider provider) {
  return SwitchListTile(
    title: const Text('Dark Theme'),
    subtitle: const Text(
      'Enable dark mode for a more comfortable viewing experience at night.',
    ),
    value: provider.themeMode == ThemeMode.dark,
    onChanged: (value) => provider.toggleTheme(value),
    secondary: const Icon(Icons.brightness_6),
  );
}
