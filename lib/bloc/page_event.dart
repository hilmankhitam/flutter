part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRestaurantDetailPage extends PageEvent {
  final Restaurant restaurant;
  final String userName;

  const GoToRestaurantDetailPage(this.restaurant,this.userName);
  
  @override
  List<Object> get props => [restaurant];
}