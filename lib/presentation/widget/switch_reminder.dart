import 'package:dicoding_submission_flutter_fundamental/presentation/provider/reminder_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Widget buildReminderSwitch(BuildContext context, ReminderProvider provider) {
  return SwitchListTile(
    title: const Text('Daily Reminder'),
    subtitle: const Text(
      'Receive daily lunch notifications at 11:00 a.m. with restaurant recommendations.',
    ),
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
