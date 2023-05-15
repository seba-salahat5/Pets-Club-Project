import 'package:marahsebaproject/models/cart_product_model.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabaseHelper {
  CartDatabaseHelper._();

  static final CartDatabaseHelper db = CartDatabaseHelper._();

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
    String path = join(databasesPath, 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(''' 
        CREATE TABLE $tableCartProduct (
          id INTEGER PRIMARY KEY, 
        $columnName TEXT NOT NULL, 
        $columnImage TEXT NOT NULL,
        $columnQuantity INTEGER NOT NULL, 
        $columnPrice TEXT NOT NULL, 
        $columnProductId TEXT NOT NULL  
        ) ''');
    });
  }

  Future<List<CartProductModel>> getAllProdcut() async {
    var dbClint = await database;
    List<Map> maps = await dbClint.query(tableCartProduct);

    List<CartProductModel> list = maps.isNotEmpty
        ? maps.map((prodcut) => CartProductModel.fromJson(prodcut)).toList()
        : [];

    return list;
  }

  insert(CartProductModel cartModel) async {
    var dbClint = await database;
    await dbClint.insert(tableCartProduct, cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

 Future<int> deleteCartItem(String id) async {
   var dbClient = await database;
   return await dbClient.delete(tableCartProduct,  where: '$columnProductId = ?', whereArgs: [id]);
 }

  Future<int> deleteAllCart() async {
   var dbClient = await database;
   return await dbClient.delete(tableCartProduct);
 }

  updateProduct(CartProductModel productForCategory) async {
    var dbClint = await database;
    return await dbClint.update(tableCartProduct, productForCategory.toJson(),
        where: '$columnProductId = ?',
        whereArgs: [productForCategory.productId]);
  }
}
