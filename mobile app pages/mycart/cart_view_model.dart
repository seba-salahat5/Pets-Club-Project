import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:marahsebaproject/models/cart_product_model.dart';
import 'package:marahsebaproject/core/database/cart_database_helper.dart';
import 'package:marahsebaproject/utils/constants.dart';
import 'package:sqflite/sqlite_api.dart';

class CartViewModel extends GetxController {

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }

  increaseTotal(newTotal){
_totalPrice+=newTotal;
update();
  }

  decreaseTotal(price) {
    _totalPrice -= price;
    update();
  }

    clearTotal(){
_totalPrice=0;
update();
  }

  getAllProduct() async {
    _loading.value = true;
    _cartProductModel = await dbHelper.getAllProdcut();

    _loading.value = false;
    getTotalPrice();

    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _cartProductModel.length; i++) {
      _totalPrice += (double.parse(_cartProductModel[i].price!) *
          _cartProductModel[i].quantity!);

      update();
    }
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return;
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);

    update();
  }

  minProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i--) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return;
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice -=
        (double.parse(cartProductModel.price!) * cartProductModel.quantity!);

    update();
  }

  increaseQuantity(int index) async {
    _cartProductModel[index].quantity = _cartProductModel[index].quantity! + 1;
    _totalPrice += (double.parse(_cartProductModel[index].price!));
    await dbHelper.updateProduct(_cartProductModel[index]);
    update();
  }

  decreaseQuantity(int index) async {
    // cartProductModel.firstWhere((element) => element.productId);
    if (_cartProductModel[index].quantity != 1) {
      _cartProductModel[index].quantity =
          _cartProductModel[index].quantity! - 1;
      _totalPrice -= (double.parse(_cartProductModel[index].price!));
      await dbHelper.updateProduct(_cartProductModel[index]);
    } else {
      _cartProductModel[index].quantity = 1;
    }

    update();
  }

  static Database? database;

  delete(CartProductModel cartModel) async {
    var dbClint = await database;
    await dbClint!.delete(tableCartProduct,
         where: '$columnProductId = ?',
        whereArgs: [cartModel.productId]);
  }
}
