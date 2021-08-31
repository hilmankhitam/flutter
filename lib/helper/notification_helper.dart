part of 'helpers.dart';

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static BehaviorSubject<String?> onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        'channelDescription',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('app_icon');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Restaurant randomRestaurant(RestaurantResult restaurants) {
    var now = DateTime.now();
    Random random = Random(now.millisecondsSinceEpoch);
    List<Restaurant> restaurant = restaurants.restaurants;
    Restaurant randomItem = restaurant[random.nextInt(restaurant.length)];
    return randomItem;
  }

  static Future showScheduleNotification({
    int id = 0,
  }) async {
    final data = await RestaurantServices.getRestaurants(http.Client());
    var random = randomRestaurant(data);
    _notifications.zonedSchedule(
      id,
      random.name,
      random.description,
      _scheduleDaily(const Time(11, 00, 00)),
      await _notificationDetails(),
      payload: random.id,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    return now.isAfter(scheduleDate)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static void cancel() => _notifications.cancel(0);
}
