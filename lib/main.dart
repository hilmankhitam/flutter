import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:submission_fundamental_1/helper/helpers.dart';
import 'package:submission_fundamental_1/providers/providers.dart';
import 'package:submission_fundamental_1/repository/repository.dart';
import 'package:submission_fundamental_1/services/services.dart';
import 'package:submission_fundamental_1/shared/shared.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (defaultTargetPlatform != TargetPlatform.iOS) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => PageBloc(),
          ),
          BlocProvider(
            create: (_) => SearchBloc(searchRepository: RestaurantRepository()),
          ),
          BlocProvider(
              create: (_) => RestaurantBloc()..add(FetchRestaurants())),
          BlocProvider(
              create: (_) =>
                  FavoriteBloc(favoriteRepository: FavoriteRepository())
                    ..add(StartFavorite())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Submisson Fundamental 1',
          theme: ThemeData(
            scaffoldBackgroundColor: mainColor,
          ),
          
          home: const Wrapper(),
        ),
      ),
    );
  }
}
