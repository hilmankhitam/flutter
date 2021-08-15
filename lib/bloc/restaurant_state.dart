part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState extends Equatable {}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object?> get props => [];
}

class RestaurantLoaded extends RestaurantState {
  final RestaurantResult restaurants;

  RestaurantLoaded({required this.restaurants});
  @override
  List<Object?> get props => [restaurants];
}

class RestaurantError extends RestaurantState {
  final String error;

  RestaurantError(this.error);

  @override
  List<Object> get props => [error];
}
