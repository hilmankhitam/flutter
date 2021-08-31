part of 'repository.dart';

class SearchRepository {
  RestaurantServices restaurantServices = RestaurantServices();

  Future<List<Restaurant>> search(String search) =>
      restaurantServices.search(search);
}
