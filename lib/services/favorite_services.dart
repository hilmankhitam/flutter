part of 'services.dart';

class FavoriteServices {
  final FavoriteDatabaseHelper dbProvider = FavoriteDatabaseHelper.instance;

  Future<void> addFavorite(String id) async {
    final db = await dbProvider.database;
    await db.insert(tblfavorite, {"id": id});
  }

  String fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    return id;
  }

  Future<List<String>> getFavorite() async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;

    result = await db.query(tblfavorite);

    List<String> id =
        result.isNotEmpty ? result.map((item) => fromJson(item)).toList() : [];
    return id;
  }

  Future<String> deleteFavorite(String id) async {
    final db = await dbProvider.database;

    var result =
        await db.delete(tblfavorite, where: 'id = ?', whereArgs: [id]);

    return result.toString();
  }
}
