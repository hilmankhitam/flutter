part of 'repository.dart';

class FavoriteRepository {
  FavoriteServices favoriteServices = FavoriteServices();

  Future getFavorite() => favoriteServices.getFavorite();

  Future addFavorite(String id) =>
      favoriteServices.addFavorite(id);

  Future deleteById(String id) => favoriteServices.deleteFavorite(id);
}
