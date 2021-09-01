part of 'repository.dart';

class RestaurantRepository {
  RestaurantServices restaurantServices = RestaurantServices();

  Future<List<Restaurant>> search(String search) =>
      restaurantServices.search(search);
}
