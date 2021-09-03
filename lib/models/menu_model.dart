part of 'models.dart';

class Menu extends Equatable {
  final List<Food> foods;
  final List<Drink> drinks;

  const Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<Food>.from(json["foods"].map((e) => Food.fromJson(e))),
        drinks: List<Drink>.from(json["drinks"].map((e) => Drink.fromJson(e))),
      );

  @override
  List<Object?> get props => [foods, drinks];
}

class Food extends Equatable {
  final String name;
  const Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}

class Drink extends Equatable {
  final String name;
  const Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];

}
