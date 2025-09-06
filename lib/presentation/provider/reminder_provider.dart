import 'dart:math';
import 'package:dicoding_submission_flutter_fundamental/data/api/api_service.dart';
import 'package:dicoding_submission_flutter_fundamental/utils/share_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderProvider with ChangeNotifier {
  bool _isReminderEnabled = false;
  final ReminderPreferences _preferences = ReminderPreferences();
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final ApiService _apiService;

  bool get isReminderEnabled => _isReminderEnabled;

  FlutterLocalNotificationsPlugin get notificationsPlugin =>
      _notificationsPlugin;

  ReminderProvider(this._apiService) {
    _initializeNotification();
    _loadReminder();
  }

  Future<void> _initializeNotification() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );
    await _notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> toggleReminder(bool isEnabled) async {
    _isReminderEnabled = isEnabled;
    notifyListeners();
    await _preferences.setReminder(isEnabled);

    if (isEnabled) {
      await _scheduleDailyReminder();
    } else {
      await _notificationsPlugin.cancel(0);
    }
  }

  Future<void> _loadReminder() async {
    _isReminderEnabled = await _preferences.getReminder();
    notifyListeners();

    if (_isReminderEnabled) {
      await _scheduleDailyReminder();
    }
  }

  Future<void> _scheduleDailyReminder() async {
    final restaurantName = await _getRandomRestaurantName();

    const androidDetails = AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Reminder',
      channelDescription: 'Reminder for lucnh',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.zonedSchedule(
      0,
      'Time to launch!',
      'Try to eat at: $restaurantName 🍽️',
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

  Future<String> _getRandomRestaurantName() async {
    try {
      final response = await _apiService.getRestaurantList();
      final restaurants = response.restaurants;
      if (restaurants.isNotEmpty) {
        final random = restaurants[Random().nextInt(restaurants.length)];
        return random.name;
      }
    } catch (_) {}
    return 'Restoran favoritmu';
  }
}
