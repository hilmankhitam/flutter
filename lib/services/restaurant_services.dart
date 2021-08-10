part of 'services.dart';

class RestaurantServices {
  static Future<List<Restaurant>> getRestaurant(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/local_restaurant.json');
    var body = json.decode(data);
    List result = body['restaurants'];

    return result.map<Restaurant>(Restaurant.fromJson).toList();
  }
}
