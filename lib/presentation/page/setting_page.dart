import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/reminder_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/theme_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/switch_reminder.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/widget/switch_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final reminderProvider = context.watch<ReminderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () => context.go(homePageRoute),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          buildThemeSwitch(context, themeProvider),
          const Divider(),
          buildReminderSwitch(context, reminderProvider),
        ],
      ),
    );
  }
}
