part of 'models.dart';

class Categories {
  Categories({
    required this.name,
  });

  String name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
      );
}