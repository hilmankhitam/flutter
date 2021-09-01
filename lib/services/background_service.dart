part of 'services.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  static Future<void> callback() async {
    debugPrint('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();

    final data = await RestaurantServices.getRestaurants(http.Client());
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, data);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    debugPrint('Execute some process');
  }
}
