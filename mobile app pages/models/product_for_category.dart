import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductForCategory {
  int? productId;
  int? categoryId;
  String? name;
  int? quantity;
  int? price;
  String? description;
  String? productImage;

  ProductForCategory.fromJson(Map json) {
    productId = json['productId'];
    categoryId = json['categoryId'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    productImage = json['productImage'];
  }

  Map<String, dynamic> tojson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    map['categoryId'] = categoryId;
    map['name'] = name;
    map['quantity'] = quantity;
    map['price'] = price;
    map['description'] = description;
    map['productImage'] = productImage;
    return map;
  }

  static Future<List<ProductForCategory>> getProductForCategory(
      String value) async {
    List<ProductForCategory> productsForCategory = [];
    var url = "http://192.168.1.3:3005/product/getProductForCatergory";
    var data = {'categoryId': value};
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      productsForCategory = List<ProductForCategory>.from(
          l.map((model) => ProductForCategory.fromJson(model)));

      return productsForCategory;
    }
    return productsForCategory;
  }
}
