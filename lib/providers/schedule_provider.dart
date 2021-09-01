part of 'providers.dart';

class SchedulingProvider extends ChangeNotifier {
  

  Future<void> setReminder(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('showReminder', value);
  }

  Future<bool> scheduledNotification(bool value) async {
    if (value) {
      debugPrint('Scheduling Notification Activated');
      notifyListeners();
      setReminder(value);
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      debugPrint('Scheduling Notification Canceled');
      setReminder(value);
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
