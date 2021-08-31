part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<String> id;

  const FavoriteLoaded({required this.id});

  @override
  List<Object> get props => [id];
}

class FavoriteError extends FavoriteState {}
