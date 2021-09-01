part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Restaurant> restaurant;

  const FavoriteLoaded({required this.restaurant});

  @override
  List<Object> get props => [restaurant];
}

class FavoriteError extends FavoriteState {}
