part of 'services.dart';

class RestaurantServices {
  static Future<RestaurantResult> getRestaurants({http.Client? client}) async {
    String url = baseURL + "list";

    client ??= http.Client();

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return RestaurantResult.fromJson(data);
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static Future<RestaurantDetailResult> getDetails(String restaurantID,
      {http.Client? client}) async {
    String url = baseURL + "detail/$restaurantID";

    client ??= http.Client();

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return RestaurantDetailResult.fromJson(data);
    } else {
      throw Exception('Failed to load Details');
    }
  }

  static Future<void> addReview(String id, String name, String review,
      {http.Client? client}) async {
    String url = baseURL + "review";

    client ??= http.Client();

    var headers = {'Content-Type': 'application/json', 'X-Auth-Token': '12345'};
    final body = {'id': id, 'name': name, 'review': review};
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to add Review');
    }
  }

  Future<List<Restaurant>> search(String search, {http.Client? client}) async {
    String url = baseURL + "search?q=$search";

    client ??= http.Client();

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    List results = data['restaurants'];
    if (response.statusCode == 200) {
      return results.map((e) => Restaurant.fromJson(e)).toList();
    } else {
      throw SearchResultError.fromJson(data);
    }
  }
}

class SearchRepository {
  RestaurantServices restaurantServices = RestaurantServices();

  Future<List<Restaurant>> search(String search) =>
      restaurantServices.search(search);
}


