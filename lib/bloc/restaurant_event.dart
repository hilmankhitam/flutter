part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();
}

class FetchRestaurants extends RestaurantEvent {
  @override
  List<Object> get props => [];
}