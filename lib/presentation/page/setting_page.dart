import 'package:dicoding_submission_flutter_fundamental/constant/name_router.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/reminder_provider.dart';
import 'package:dicoding_submission_flutter_fundamental/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
          onPressed: () => context.go(HOME_PAGE_ROUTE),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildThemeSwitch(context, themeProvider),
          const Divider(),
          _buildReminderSwitch(context, reminderProvider),
        ],
      ),
    );
  }

  Widget _buildThemeSwitch(BuildContext context, ThemeProvider provider) {
    return SwitchListTile(
      title: const Text('Dark Theme'),
      subtitle: const Text('Enable dark mode for a more comfortable viewing experience at night.'),
      value: provider.themeMode == ThemeMode.dark,
      onChanged: (value) => provider.toggleTheme(value),
      secondary: const Icon(Icons.brightness_6),
    );
  }

  Widget _buildReminderSwitch(BuildContext context, ReminderProvider provider) {
    return SwitchListTile(
      title: const Text('Daily Reminder'),
      subtitle: const Text('Receive daily lunch notifications at 11:00 a.m. with restaurant recommendations.'),
      value: provider.isReminderEnabled,
      onChanged: (value) async {
        await provider.toggleReminder(value);

        if (value) {
          _showImmediateNotification(provider);
        }
      },
      secondary: const Icon(Icons.notifications_active),
    );
  }

  void _showImmediateNotification(ReminderProvider provider) async {
    const androidDetails = AndroidNotificationDetails(
      'preview_channel',
      'Preview Notification',
      channelDescription: 'Preview notification when reminder is activated',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await provider.notificationsPlugin.show(
      999, 
      'Active Preview Reminder',
      'Lunch notifications will appear every day at 11:00 a.m',
      notificationDetails,
    );
  }
}
