// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
  group('fetch RestaurantResult', () {
    test('returns an RestaurantResult if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(baseURL + "list"))).thenAnswer((_) async =>
          http.Response(
              '{"error": true, "message": "success", "count": 20, "restaurants": []}',
              200));

      expect(await RestaurantServices.getRestaurants(client),
          isA<RestaurantResult>());
    });
  });
}
