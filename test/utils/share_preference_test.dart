import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dicoding_submission_flutter_fundamental/utils/share_preference.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemePreference', () {
    test('should save and retrieve dark theme preference', () async {
      SharedPreferences.setMockInitialValues({});
      final themePref = ThemePreference();

      await themePref.setDarkTheme(true);
      final result = await themePref.getDarkTheme();

      expect(result, true);
    });

    test('should return false if no theme preference is set', () async {
      SharedPreferences.setMockInitialValues({});
      final themePref = ThemePreference();

      final result = await themePref.getDarkTheme();

      expect(result, false);
    });
  });

  group('ReminderPreferences', () {
    test('should save and retrieve reminder preference', () async {
      SharedPreferences.setMockInitialValues({});
      final reminderPref = ReminderPreferences();

      await reminderPref.setReminder(true);
      final result = await reminderPref.getReminder();

      expect(result, true);
    });

    test('should return false if no reminder preference is set', () async {
      SharedPreferences.setMockInitialValues({});
      final reminderPref = ReminderPreferences();

      final result = await reminderPref.getReminder();

      expect(result, false);
    });
  });
}
