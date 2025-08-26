import 'package:dicoding_submission_flutter_fundamental/utils/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderProvider with ChangeNotifier {
  bool _isReminderEnabled = false;
  final ReminderPreferences _preferences = ReminderPreferences();
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool get isReminderEnabled => _isReminderEnabled;

  ReminderProvider() {
    _initializeNotification();
    _loadReminder();
  }

  void _initializeNotification() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await _notificationsPlugin.initialize(initializationSettings);
  }

  void toggleReminder(bool isEnabled) async {
    _isReminderEnabled = isEnabled;
    notifyListeners();
    await _preferences.setReminder(isEnabled);

    if (isEnabled) {
      _scheduleDailyReminder();
    } else {
      _notificationsPlugin.cancel(0);
    }
  }

  void _loadReminder() async {
    _isReminderEnabled = await _preferences.getReminder();
    notifyListeners();

    if (_isReminderEnabled) {
      _scheduleDailyReminder();
    }
  }

  void _scheduleDailyReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Reminder',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      0,
      'Waktunya Makan Siang!',
      'Jangan lupa makan siang ya 🍽️',
      _nextInstanceOf11AM(),
      notificationDetails,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  tz.TZDateTime _nextInstanceOf11AM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      11,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
