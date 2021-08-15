part of 'page_bloc.dart';

abstract class PageState extends Equatable {
  const PageState();
}

class OnInitialPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnHomePage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRestaurantDetailPage extends PageState {
  final Restaurant restaurant;
  final String userName;

  const OnRestaurantDetailPage(this.restaurant,this.userName);
  
  @override
  List<Object> get props => [restaurant];
}

class OnSearchPage extends PageState {
  final String userName;
  const OnSearchPage(this.userName);
  @override
  List<Object> get props => [];
}