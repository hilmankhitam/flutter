import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_fundamental_1/shared/shared.dart';
import 'package:provider/provider.dart';

import 'bloc/blocs.dart';
import 'ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PageBloc(),
        ),
        BlocProvider(create: (_) => RestaurantBloc()..add(FetchRestaurants()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Submisson Fundamental 1',
        theme: ThemeData(
          scaffoldBackgroundColor: mainColor,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
