import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:marahsebaproject/mycart/cart_view_model.dart';
import 'package:marahsebaproject/productscreen/shoppage2.dart';
import 'package:marahsebaproject/core/database/cart_database_helper.dart';
import 'package:marahsebaproject/utils/CustomWidget.dart';
import 'package:marahsebaproject/utils/constants.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ShopScreen()));
            },
            child: Icon(Icons.arrow_back),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: const Color(0xF2F2F2F2),
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xF2F2F2F2),
        body: controller.cartProductModel.length == 0
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        assetsPath + "cart_item.png",
                        height: getScreenPercentSize(context, 20),
                      ),
                      SizedBox(
                        height: getScreenPercentSize(context, 3),
                      ),
                      getCustomTextWithFontFamilyWidget(
                          "Your Cart is Empty Yet!",
                          Color(0xFF4F3268),
                          getScreenPercentSize(context, 2.5),
                          FontWeight.w500,
                          TextAlign.center,
                          1),
                      SizedBox(
                        height: getScreenPercentSize(context, 1),
                      ),
                      getCustomTextWidget(
                          "Explore more and shortlist some pets.",
                          Color(0xFF4F3268),
                          getScreenPercentSize(context, 2),
                          FontWeight.w400,
                          TextAlign.center,
                          1),
                    ]),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Container(
                        child: ListView.separated(
                      itemCount: controller.cartProductModel.length,
                      itemBuilder: ((context, index) {
                        return Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 210, 189, 228),
                                borderRadius: BorderRadius.circular(30)),
                            height: 140,
                            child: Row(
                              children: [
                                Container(
                                    width: 140,
                                    child: Image(
                                      image: NetworkImage(
                                          '$baseUrl/uploads/${controller.cartProductModel[index].image}'),
                                      fit: BoxFit.contain,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        controller
                                            .cartProductModel[index].name!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF4F3268),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        '\$ ${controller.cartProductModel[index].price.toString()}',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4F3268),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Container(
                                        width: 120,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Color.fromARGB(
                                                255, 233, 211, 252)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller
                                                    .increaseQuantity(index);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                              controller.cartProductModel[index]
                                                  .quantity
                                                  .toString(),
                                              style: TextStyle(
                                                color: Color(0xFF4F3268),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 16),
                                              child: GestureDetector(
                                                onTap: () {
                                                  controller
                                                      .decreaseQuantity(index);
                                                },
                                                child: Icon(
                                                  Icons.minimize,
                                                  color: Color(0xFF4F3268),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  child:
                                      //Image.asset("assets/img/recycle-bin.png"),
                                      Icon(Icons.delete),
                                  onTap: () {
                                    CartDatabaseHelper.db.deleteCartItem(
                                        controller
                                            .cartProductModel[index].productId
                                            .toString());
                                    controller.decreaseTotal(int.parse(
                                        controller
                                            .cartProductModel[index].price!));
                                    controller.cartProductModel.removeAt(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CartPage()));
                                  },
                                ),
                              ],
                            ));
                      }),
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 15,
                        );
                      },
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'TOTAL',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(79, 35, 104, 1.000),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GetBuilder<CartViewModel>(
                              init: CartViewModel(),
                              builder: (controller) => Text(
                                '\$ ${controller.totalPrice}',
                                style: TextStyle(
                                    color: Color.fromRGBO(79, 35, 104, 1.000),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: 70,
                            width: 200,
                            padding: EdgeInsets.all(5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(79, 35, 104, 1.000),
                                onPrimary: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                       backgroundColor:Color.fromARGB(255, 255, 210, 225),
                                              icon: Icon(FontAwesomeIcons.cat,color: Color(0xFF4F3268),),
                                              title:
                                                  Text('Check out  Approvel',
                                                  textAlign: TextAlign.center,
             style: TextStyle(
                  fontSize: 22.0, fontWeight: FontWeight.w600),
                                                  
                                                  ),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text(
                                                'Would you like to approve of this Order?'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Approve'),
                                          onPressed: () async {
                                            var dbHelper =
                                                CartDatabaseHelper.db;
                                            await dbHelper.deleteAllCart();
                                            controller.cartProductModel.clear();
                                            controller.clearTotal();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShopScreen()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Check Out",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
      ),
    ));
  }
}