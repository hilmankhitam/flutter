part of 'helpers.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  RestaurantServices restaurantServices = RestaurantServices();

  Restaurant random(RestaurantResult restaurantResult) {
    List<Restaurant> restaurant = restaurantResult.restaurants;
    var randomItem = (restaurant.toList()..shuffle()).first;
    return randomItem;
  }

  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantResult restaurants) async {
    var randomRestaurant = random(restaurants);
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = randomRestaurant.name;
    var bodyNotification = randomRestaurant.description;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, bodyNotification, platformChannelSpecifics,
        payload: json.encode(randomRestaurant.toJson()));
  }
}
