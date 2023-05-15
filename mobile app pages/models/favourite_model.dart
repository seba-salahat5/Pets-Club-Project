// ignore_for_file: unnecessary_null_comparison

class FavouriteModel {
  String? name , image , price ;

    String? productId;


  FavouriteModel(
      {this.name , this.image , this.price , this.productId});

  FavouriteModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    } else {
      name = map['name'];
      image = map['image'];
      price = map['price'];
      productId = map['productId'];
    }
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'productId': productId,
    };
  }
}
