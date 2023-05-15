// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;

class AdoptionModel {
  int? adoptionId;
  String? id;
  String? name;
  String? petStory;
  String? location;
  String? petImage;
  String? color;
  String? gender;
  String? weight;
  String? age;
  String? status;

  AdoptionModel.fromJson(Map json) {
    adoptionId = json['adoptionId'];
    id = json['_id'];
    name = json['name'];
    petStory = json['petStory'];
    location = json['location'];
    petImage = json['petImage'];
    color = json['color'];
    weight = json['weight'];
    age = json['age'];
    status = json['status'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adoptionId'] = adoptionId;
    map['_id'] = id;
    map['name'] = name;
    map['petStory'] = petStory;
    map['location'] = location;
    map['petImage'] = petImage;
    map['color'] = color;
    map['weight'] = weight;
    map['age'] = age;
    map['status'] = status;
    map['gender'] = gender;
    return map;
  }

  static Future<List<AdoptionModel>> getAdoptions() async {
    List<AdoptionModel> adoptions = [];
    var url = "http://192.168.1.3:3005/adoption/get";
    var res = await http.get(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody['Adoption'];
      adoptions = List<AdoptionModel>.from(
          l.map((model) => AdoptionModel.fromJson(model)));

      return adoptions;
    }

    return adoptions;
  }
}
