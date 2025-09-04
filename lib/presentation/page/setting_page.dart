import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/reminder_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () => context.go(HOME_PAGE_ROUTE),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Theme'),
            value:
                Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            onChanged: (value) {
              Provider.of<ThemeProvider>(
                context,
                listen: false,
              ).toggleTheme(value);
            },
          ),
          SwitchListTile(
            title: const Text('Daily Reminder'),
            value: Provider.of<ReminderProvider>(context).isReminderEnabled,
            onChanged: (value) {
              Provider.of<ReminderProvider>(
                context,
                listen: false,
              ).toggleReminder(value);
            },
          ),
        ],
      ),
    );
  }
}
