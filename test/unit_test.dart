import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_fundamental_1/models/models.dart';
import 'package:submission_fundamental_1/services/services.dart';
import 'package:submission_fundamental_1/shared/shared.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<http.Client>(as: #MockClient, returnNullOnMissingStub: true)
])
void main() {
  final client = MockClient();
  String id = 'rqdv5juczeskfw1e867';

  group('test device terhubung ke internet,', () {
    test('get restaurant sukses', () async {
      when(client.get(Uri.parse(baseURL + 'list')))
          .thenAnswer((_) async => http.Response('''
                { "error": false,
                  "message": "success", 
                  "count": 20, 
                  "restaurants": [
                    {
                        "id": "rqdv5juczeskfw1e867",
                        "name": "Melting Pot",
                        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                        "pictureId": "14",
                        "city": "Medan",
                        "rating": 4.2
                    }
                  ]
                }''', 200));
      expect(await RestaurantServices.getRestaurants(client),
          isA<RestaurantResult>());
    });
    test('get restaurant detail sukses', () async {
      when(client.get(Uri.parse(baseURL + 'detail/$id')))
          .thenAnswer((_) async => http.Response('''
                { "error": false,
                  "message": "success",
                  "restaurant": {
                      "id": "rqdv5juczeskfw1e867",
                      "name": "Melting Pot",
                      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                      "city": "Medan",
                      "address": "Jln. Pandeglang no 19",
                      "pictureId": "14",
                      "categories": [
                        {
                            "name": "Italia"
                        }
                      ],
                      "menus": {
                          "foods": [
                            {
                                "name": "Paket rosemary"
                            }
                          ],
                          "drinks": [
                            {
                                "name": "Es krim"
                            }
                          ]
                      },
                      "rating": 4.2,
                      "customerReviews": [
                        {
                            "name": "Ahmad",
                            "review": "Tidak rekomendasi untuk pelajar!",
                            "date": "13 November 2019"
                        }
                      ]
                  }
                }''', 200));
      expect(await RestaurantServices.getDetails(id, client),
          isA<RestaurantDetailResult>());
    });
  });

  group('test device tidak terhubung ke internet,', () {
    test('get restaurant gagal', () async {
      when(client.get(Uri.parse(baseURL + 'list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(RestaurantServices.getRestaurants(client), throwsException);
    });
    test('get restaurant detail gagal', () async {
      when(client.get(Uri.parse(baseURL + 'detail/$id')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(RestaurantServices.getDetails(id, client), throwsException);
    });
  });
}
