part of 'models.dart';

class Menu {
  late List<Food> foods;
  late List<Drink> drinks;

  Menu({required this.foods, required this.drinks});

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods: List<Food>.from(json["foods"].map((e) => Food.fromJson(e))),
        drinks: List<Drink>.from(json["drinks"].map((e) => Drink.fromJson(e))),
      );
}

class Food {
  late String name;
  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
      );
}

class Drink {
  late String name;
  Drink({
    required this.name,
  });

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

}
