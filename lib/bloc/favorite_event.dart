part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class StartFavorite extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class AddFavoriteRestaurant extends FavoriteEvent {
  final String id;

  const AddFavoriteRestaurant(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveFavoriteRestaurant extends FavoriteEvent {
  final String id;

  const RemoveFavoriteRestaurant(this.id);
}
