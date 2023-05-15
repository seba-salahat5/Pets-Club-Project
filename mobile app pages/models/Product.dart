// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductModel {
  int? id;
  int? categoryId;
  String? category;
  String? name;
  String? description;
  int? price;
  String? productImage;
  int? quantity;

  ProductModel.fromJson(Map json) {
    id = json['productId'];
    categoryId = json['categoryId'];
    category = json['category']['name'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    productImage = json['productImage'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = id;
    map['categoryId'] = categoryId.toString();
    map['category']['name'] = category;
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['productImage'] = productImage;
    map['quantity'] = quantity;
    return map;
  }

  static Future<List<ProductModel>> getCategory() async {
    List<ProductModel> products = [];
    var url = "http://192.168.1.3:3005/product/show";
    var res = await http.get(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody['products'];
      products = List<ProductModel>.from(
          l.map((model) => ProductModel.fromJson(model)));

      return products;
    }

    return products;
  }

    static Future<List<ProductModel>> getCategorySearch({String? query}) async {
    List<ProductModel> products = [];
    var url = "http://192.168.1.3:3005/product/show";
    var res = await http.get(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody['products'];
      products = List<ProductModel>.from(
          l.map((model) => ProductModel.fromJson(model)));
          if (query !=null){
            products=products.where((element) =>element.name!.toLowerCase().contains(query.toLowerCase())).toList();
          }

      return products;
    }

    return products;
  }
}
