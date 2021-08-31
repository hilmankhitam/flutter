part of 'helpers.dart';

const String tblfavorite = 'favorite';

class FavoriteDatabaseHelper {
  static final FavoriteDatabaseHelper instance = FavoriteDatabaseHelper();
  late Database _database;

  Future<Database> get database async {
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "favorite.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute('''CREATE TABLE $tblfavorite (
           id TEXT PRIMARY KEY
         )     
      ''');
  }
}
