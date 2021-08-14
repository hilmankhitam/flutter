part of 'services.dart';

class RestaurantServices {
  static Future<RestaurantResult> getRestaurants() async {
    String url = baseURL + "list";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return RestaurantResult.fromJson(data);
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static Future<RestaurantDetailResult> getDetails(String restaurantID) async {
    String url = baseURL + "detail/$restaurantID";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return RestaurantDetailResult.fromJson(data);
    } else {
      throw Exception('Failed to load Details');
    }
  }

  static Future<void> addReview(String id, String name, String review) async {
    String url = baseURL + "review";
    var headers = {'Content-Type': 'application/json', 'X-Auth-Token': '12345'};
    final body = {'id': id, 'name': name, 'review': review};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      
    } else {
      throw Exception('Failed to add Review');
    }
  }
}
