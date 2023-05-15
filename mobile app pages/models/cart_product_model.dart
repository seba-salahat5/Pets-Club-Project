// ignore_for_file: unnecessary_null_comparison

class CartProductModel {
  String? name , image , price ;
  int? quantity ;
    String? productId;


  CartProductModel(
      {this.name , this.image , this.quantity , this.price , this.productId});

  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    } else {
      name = map['name'];
      image = map['image'];
      quantity = map['quantity'];
      price = map['price'];
      productId = map['productId'];
    }
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
      'productId': productId,
    };
  }
}