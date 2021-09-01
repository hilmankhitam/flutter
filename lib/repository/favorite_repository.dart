part of 'repository.dart';

class FavoriteRepository {
  FavoriteServices favoriteServices = FavoriteServices();

  Future getFavorite() => favoriteServices.getFavorite();

  Future addFavorite(Restaurant restaurant) =>
      favoriteServices.addFavorite(restaurant);

  Future deleteById(String id) => favoriteServices.deleteFavorite(id);
}
