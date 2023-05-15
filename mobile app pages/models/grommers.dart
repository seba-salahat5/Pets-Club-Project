// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;

class grommersModel {
  int? grompersonId;
  String? id;
  String? name;
  String? description;
  String? image;
  String? clinicgromName;
  int? rating;
  int? status;

  grommersModel.fromJson(Map json) {
    grompersonId = json['grompersonId'];
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    clinicgromName = json['clinicgromName'];
    status = json['status'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['grompersonId'] = grompersonId;
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['clinicgromName'] = clinicgromName;
    map['status'] = status;
    map['rating'] = rating;
    return map;
  }

  static Future<List<grommersModel>> getgrommer() async {
    List<grommersModel> grom = [];
    var url = "http://192.168.1.3:3005/gromer/get";
    var res = await http.get(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody['gromList'];
      grom = List<grommersModel>.from(
          l.map((model) => grommersModel.fromJson(model)));

      return grom;
    }
    return grom;
  }
}
