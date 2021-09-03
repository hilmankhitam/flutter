part of 'models.dart';

class Categories extends Equatable {
  const Categories({
    required this.name,
  });

  final String name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}