import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:submission_fundamental_1/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSplashPage) {
      yield OnSplashPage();
    } else if (event is GoToHomePage) {
      yield OnHomePage(bottomNavBarIndex: event.bottomNavBarIndex);
    } else if (event is GoToRestaurantDetailPage) {
      yield OnRestaurantDetailPage(event.restaurant, event.userName);
    } else if (event is GoToSearchPage) {
      yield OnSearchPage(event.userName);
    }
  }
}
