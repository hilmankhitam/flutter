part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  final int bottomNavBarIndex;

  const GoToHomePage({this.bottomNavBarIndex = 0});

  @override
  List<Object> get props => [bottomNavBarIndex];
}

class GoToRestaurantDetailPage extends PageEvent {
  final String id;
  final String userName;

  const GoToRestaurantDetailPage(this.id, this.userName);

  @override
  List<Object> get props => [id, userName];
}

class GoToSearchPage extends PageEvent {
  final String userName;
  const GoToSearchPage(this.userName);
  @override
  List<Object> get props => [];
}
