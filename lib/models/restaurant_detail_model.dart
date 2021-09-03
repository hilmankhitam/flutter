part of 'models.dart';

class RestaurantDetailResult extends Equatable{
   const RestaurantDetailResult({
    required this.error,
    required this.message,
    required this.restaurantDetail,
  });

  final bool error;
  final String message;
  final RestaurantDetail restaurantDetail;

  factory RestaurantDetailResult.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailResult(
        error: json["error"],
        message: json["message"],
        restaurantDetail: RestaurantDetail.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurantDetail.toJson(),
    };

  @override
  List<Object?> get props => [error, message, restaurantDetail];
}

class RestaurantDetail extends Restaurant {
  final String address;
  final List<Categories> categories;
  final Menu menus;
  final List<CustomerReview> customerReview;
  RestaurantDetail(
    Restaurant restaurant, {
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReview,
  }) : super(
            id: restaurant.id,
            name: restaurant.name,
            description: restaurant.description,
            pictureId: restaurant.pictureId,
            city: restaurant.city,
            rating: restaurant.rating);

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(Restaurant.fromJson(json),
          address: json['address'],
          categories: List<Categories>.from(
              json['categories'].map((e) => Categories.fromJson(e))),
          customerReview: List<CustomerReview>.from(
              json['customerReviews'].map((e) => CustomerReview.fromJson(e))),
          menus: Menu.fromJson(json['menus']));

  

  @override
  List<Object> get props =>
      super.props + [address, categories, customerReview, menus];
}
