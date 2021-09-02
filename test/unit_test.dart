import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_fundamental_1/models/models.dart';
import 'package:submission_fundamental_1/services/services.dart';
import 'package:submission_fundamental_1/shared/shared.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  final client = MockClient();
  String id = 'rqdv5juczeskfw1e867';
  group('unit testing where the device is connected to the internet', () {
    test('returns an RestaurantResult if the http call completes successfully',
        () async {
      when(client.get(Uri.parse(baseURL + "list"))).thenAnswer((_) async =>
          http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants": []}',
              200));

      expect(await RestaurantServices.getRestaurants(client),
          isA<RestaurantResult>());
    });

    test(
        'returns an RestaurantDetailResult if the http call completes successfully',
        () async {
      when(client.get(Uri.parse(baseURL + "detail/$id"))).thenAnswer(
          (_) async => http.Response(
              '{"error": false, "message": "success", "restaurant": {}}', 200));

      expect(await RestaurantServices.getDetails(id, client),
          isA<RestaurantDetailResult>());
    });
  });

  group('unit testing where the device is not connected to the internet', () {
    test('throws exception if http get restaurant call completes with error',
        () {
      when(client.get(Uri.parse(baseURL + "list")))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(RestaurantServices.getRestaurants(client), throwsException);
    });

    test(
        'throws exception if http restaurant details call completes with error',
        () async {
      when(client.get(Uri.parse(baseURL + "detail/$id"))).thenAnswer(
          (_) async => http.Response(
              '{"error": false, "message": "success", "restaurant": {}}', 404));

      expect(RestaurantServices.getDetails(id, client), throwsException);
    });
  });
}
