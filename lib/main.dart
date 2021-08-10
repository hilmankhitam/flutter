import 'package:flutter/material.dart';
import 'package:submission_fundamental_1/models/models.dart';
import 'package:submission_fundamental_1/shared/shared.dart';

import 'ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Submisson Fundamental 1',
      theme: ThemeData(
        scaffoldBackgroundColor: mainColor,
      ),
      initialRoute: '/',
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
      home: const SplashScreen(),
    );
  }
}
