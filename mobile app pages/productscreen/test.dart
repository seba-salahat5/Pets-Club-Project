// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marahsebaproject/models/Product.dart';
import 'package:marahsebaproject/models/cart_product_model.dart';
import 'package:marahsebaproject/mycart/cart_view_model.dart';
import 'package:marahsebaproject/productscreen/shoppage2.dart';
import 'package:marahsebaproject/core/database/cart_database_helper.dart';
import 'package:marahsebaproject/utils/constants.dart';

class DetailsPage extends StatelessWidget {
  static const routeName = '/product-details-screen ';

  ProductModel? productModel;
  String? productId;

  DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return SafeArea(
        child: GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFF4F3268)),
          centerTitle: true,
          backgroundColor: const Color(0xF2F2F2F2),
          title: const Text(
            'Product details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 231, 204, 255)),
          padding: EdgeInsets.all(10),
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
            Container(
                decoration: BoxDecoration(color: Color(0xF2F2F2F2)),
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image(
                  image: NetworkImage(
                      '$baseUrl/uploads/${productModel.productImage!}'),
                  fit: BoxFit.contain,
                )),
            Divider(
              height: 70,
              color: Color.fromRGBO(79, 35, 104, 1.000),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(children: [
                  Row(
                    children: [
                      Text("Product Name:",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF4F3268))),
                      SizedBox(width: 8),
                      Text(productModel.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 125, 64, 179))),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Description",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFF4F3268))),
                      SizedBox(width: 8),
                      Divider(
                        height: 30,
                        //color: Color.fromRGBO(79, 35, 104, 1.000),
                      ),
                      Text(
                        productModel.description!,
                        
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromARGB(255, 125, 64, 179),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            )),
            Divider(
              height: 50,
              color: Color.fromRGBO(79, 35, 104, 1.000),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF4F3268),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$ ' + productModel.price!.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 125, 64, 179),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(15),
                      width: 200,
                      height: 90,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color.fromRGBO(79, 35, 104, 1.000),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          CartProductModel product = CartProductModel(
                              name: productModel.name,
                              image: productModel.productImage,
                              quantity: productModel.quantity,
                              price: productModel.price.toString(),
                              productId: productModel.id.toString());
                          controller.cartProductModel.add(product);
                          totalPrice += (double.parse(product.price!) *
                              product.quantity!);
                          controller.increaseTotal(totalPrice);

                          // controller.getTotalPrice();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ShopScreen()));
                        },
                        child: Text(
                          'Add To Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    ));
  }

  var dbHelper = CartDatabaseHelper.db;
  double totalPrice = 0.0;

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartProductModel.length; i++) {
      if (_cartProductModel[i].productId == cartProductModel.productId) {
        return;
      }
    }
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    // totalPrice +=
    //   (double.parse(cartProductModel.price!) * cartProductModel.quantity!);
  }

  List<CartProductModel> _cartProductModel = [];

  increaseQuantity(int index) async {
    _cartProductModel[index].quantity = _cartProductModel[index].quantity! + 1;
    totalPrice += (double.parse(_cartProductModel[index].price!));
    await dbHelper.updateProduct(_cartProductModel[index]);
  }

  decreaseQuantity(int index) async {
    if (_cartProductModel[index].quantity != 1) {
      _cartProductModel[index].quantity =
          _cartProductModel[index].quantity! - 1;
      totalPrice -= (double.parse(_cartProductModel[index].price!));
      await dbHelper.updateProduct(_cartProductModel[index]);
    } else {
      _cartProductModel[index].quantity = 1;
    }
  }
}
