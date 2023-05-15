import 'package:marahsebaproject/models/favourite_model.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavouritetDatabaseHelper {
  FavouritetDatabaseHelper._();

  static final FavouritetDatabaseHelper db = FavouritetDatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDb();
      return _database!;
    }
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Favourite.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
        CREATE TABLE $tableFavourite (
          id INTEGER PRIMARY KEY, 
        $columnFavName TEXT NOT NULL, 
        $columnFavImage TEXT NOT NULL,
        $columnFavPrice TEXT NOT NULL, 
        $columnFavProductId TEXT NOT NULL  
        ) ''');
    });
  }

  Future<List<FavouriteModel>> getAllProdcut() async {
    var dbClint = await database;
    List<Map> maps = await dbClint.query(tableFavourite);

    List<FavouriteModel> list = maps.isNotEmpty
        ? maps.map((prodcut) => FavouriteModel.fromJson(prodcut)).toList()
        : [];

    return list;
  }

  insert(FavouriteModel favouriteModel) async {
    var dbClint = await database;
    await dbClint.insert(tableFavourite, favouriteModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

 Future<int> deleteFavourtieItem(String id) async {
   var dbClient = await database;
   return await dbClient.delete(tableFavourite,  where: '$columnProductId = ?', whereArgs: [id]);
 }

  Future<int> deleteAllFavourite() async {
   var dbClient = await database;
   return await dbClient.delete(tableFavourite);
 }

  updateProduct(FavouriteModel favouriteModel) async {
    var dbClint = await database;
    return await dbClint.update(tableFavourite, favouriteModel.toJson(),
        where: '$columnProductId = ?',
        whereArgs: [favouriteModel.productId]);
  }
}
