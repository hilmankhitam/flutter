part of 'models.dart';

class ResultError {
  const ResultError({required this.message});

  final String message;

  static ResultError fromJson(dynamic json) {
    return ResultError(
      message: json['error'],
    );
  }
}

class RestaurantResult {
  final bool error;
  final String message;
  final int count;
  final List<Restaurant> restaurants;

  RestaurantResult(
      {required this.error,
      required this.message,
      required this.count,
      required this.restaurants});

  factory RestaurantResult.fromJson(Map<String, dynamic> json) =>
      RestaurantResult(
          error: json['error'],
          message: json['message'],
          count: json['count'],
          restaurants: List<Restaurant>.from(
              json['restaurants'].map((e) => Restaurant.fromJson(e))));
}

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  const Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: (json['rating'] as num).toDouble(),
      );

  @override
  List<Object> get props => [id, name, description, pictureId, city, rating];
}
