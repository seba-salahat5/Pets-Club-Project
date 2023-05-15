import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:marahsebaproject/MainPage.dart';
import 'package:marahsebaproject/core/database/favourite_database_helper.dart';
import 'package:marahsebaproject/models/Product.dart';
import 'package:marahsebaproject/models/cart_product_model.dart';
import 'package:marahsebaproject/models/favourite_model.dart';
import 'package:marahsebaproject/models/product_for_category.dart';
import 'package:marahsebaproject/mycart/cartpage.dart';
import 'package:marahsebaproject/productscreen/search.dart';
import 'package:marahsebaproject/productscreen/test.dart';
import 'package:marahsebaproject/core/database/cart_database_helper.dart';
import 'package:marahsebaproject/utils/constants.dart';

class ShopScreen extends StatefulWidget {
  ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  static List<ProductModel> main_product_list = [];
  ProductModel? productModel;
  var dio = Dio();
  List<dynamic> listproduct = [];
  List<dynamic> listproductbycategore = [];
  List<dynamic> listcategore = [];
  String valcategory = "";

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  var dbHelper = CartDatabaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }


  getAllProduct() async {
    _cartProductModel = await dbHelper.getAllProdcut();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getCategories();
      ProductForCategory.getProductForCategory(valcategory);
      ProductModel.getCategory();
    });

    return valcategory == ''
        ? Scaffold(
            backgroundColor: const Color(0xF2F2F2F2),
            appBar: buildAppBar(context),
            body: FutureBuilder(
              future: ProductModel.getCategory(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                      ),
                   
                      const SizedBox(
                        height: 20,
                      ),
                      Categories(),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPaddin,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                ProductModel productModel =
                                    snapshot.data[index];

                                listproductbycategore =
                                    listproduct.where((products) {
                                  return listproduct[index]['category']['name']
                                      .toLowerCase()
                                      .contains((valcategory.toLowerCase()));
                                }).toList();

                                return GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(),
                                          settings: RouteSettings(
                                            arguments: productModel,
                                          ),
                                        ),
                                      );
                                    }),
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 212, 162, 255),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(children: [
                                          const SizedBox(height: 10),
                                          Expanded(
                                            flex: 5,
                                            child: Image.network(
                                                '$baseUrl/uploads/${productModel.productImage}'),
                                          ),
                                          const SizedBox(height: 10),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                  productModel.name.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color:
                                                          Color(0xFF4F3268)))),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      productModel.price
                                                              .toString() +
                                                          ' \$',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
                                                Container(

                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0Xff4f3268),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                color: Color(0xF2F2F2F2),
                                size: 25,
                                
                              ),
                            ),
                                              ],
                                            ),
                                          ),
                                        ])));
                              }),
                        ),
                      ),
                    ],
                  );
                }
              },
            ))
        : Scaffold(
            backgroundColor: const Color(0xF2F2F2F2),
            appBar: buildAppBar(context),
            body: FutureBuilder(
              future: ProductForCategory.getProductForCategory(valcategory),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                      ),
                  
                      const SizedBox(
                        height: 10,
                      ),
                      Categories(),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                          child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: kDefaultPaddin,
                                crossAxisSpacing: kDefaultPaddin,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                ProductForCategory productForCategory =
                                    snapshot.data[index];
                                listproductbycategore =
                                    listproduct.where((products) {
                                  return listproduct[index]['category']['name']
                                      .toLowerCase()
                                      .contains((valcategory.toLowerCase()));
                                }).toList();

                                return GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsPage(),
                                          settings: RouteSettings(
                                            arguments: productModel,
                                          ),
                                        ),
                                      );
                                    }),
                                    child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 212, 162, 255),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(children: [
                                          const SizedBox(height: 10),
                                          Expanded(
                                            flex: 5,
                                            child: Image.network(
                                                '$baseUrl/uploads/${productForCategory.productImage}'),
                                          ),
                                          const SizedBox(height: 10),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                  productForCategory.name
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color:
                                                          Color(0xFF4F3268)))),
                                          const SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Text(
                                                      productForCategory.price
                                                              .toString() +
                                                          ' \$',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
                                                                                                Container(

                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0Xff4f3268),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.add,
                                color: Color(0xF2F2F2F2),
                                size: 25,
                                
                              ),
                            ),
                                                
                                              ],
                                            ),
                                          ),
                                        ])));
                              }),
                        ),
                      ),
                    ],
                  );
                }
              },
            ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "    Shopping Online",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 17,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: Color(0xFF4F3268),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => CartPage()));
                },
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Color(0xFF4F3268),
                        size: 30,
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              )),
        ),
     
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
               
                child: Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Color(0xFF4F3268),
                        size: 30,
                      ),
                      onPressed:(){
                        showSearch(context: context, delegate: Searchp());
                      },
                    ),
                  ],
                ),
              )),
        )
     
      ],
    );
  }

  Future getCategories() async {
    try {
      return await dio
          .get(
            ('http://192.168.1.3:3005/category/show'),
          )
          .then((value) => listcategore = value.data['categories']);
    } on DioError catch (e) {
      return e;
    }
  }

  Widget Categories() => Container(
        height: 50,
        child: FutureBuilder(
            future: ProductForCategory.getProductForCategory(valcategory),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: listcategore.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Color(0xFF4F3268),
                              borderRadius: BorderRadius.circular(15)),
                          child: ElevatedButton(
                            child: Text(listcategore[index]['name']),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF4F3268),

                              // primary: Colors.green,
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                valcategory = listcategore[index]['categoryId']
                                    .toString();
                                print(valcategory);
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }),
      );

  List<ProductModel> updateList = List.from(_ShopScreenState.main_product_list);
  void searchList(String value) {
    setState(() {
      updateList = main_product_list
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }
}
