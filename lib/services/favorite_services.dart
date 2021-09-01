part of 'services.dart';

class FavoriteServices {
  final FavoriteDatabaseHelper dbProvider = FavoriteDatabaseHelper.instance;

  Future<void> addFavorite(Restaurant restaurant) async {
    final db = await dbProvider.database;
    await db.insert(tblfavorite, restaurant.toJson());
  }

  String fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    return id;
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.query(tblfavorite);

    List<Restaurant> restaurant =
        result.isNotEmpty ? result.map((item) => Restaurant.fromJson(item)).toList() : [];
    return restaurant;
  }

  Future<String> deleteFavorite(String id) async {
    final db = await dbProvider.database;

    var result =
        await db.delete(tblfavorite, where: 'id = ?', whereArgs: [id]);

    return result.toString();
  }
}
