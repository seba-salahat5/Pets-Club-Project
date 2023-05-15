// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorsModel {
  int? docId;
  String? id;
  String? name;
  String? description;
  String? image;
  String? clinicName;
  int? exp;
  int? rating;
  int? status;

  DoctorsModel.fromJson(Map json) {
    docId = json['docId'];
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    clinicName = json['clinicName'];
    status = json['status'];
    exp = json['exp'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['_id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['image'] = image;
    map['clinicName'] = clinicName;
    map['status'] = status;
    map['exp'] = exp;
    map['rating'] = rating;
    return map;
  }

  static Future<List<DoctorsModel>> getDoctors() async {
    List<DoctorsModel> doctors = [];
    var url = "http://192.168.1.3:3005/doctor/get";
    var res = await http.get(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody['doctorList'];
      doctors = List<DoctorsModel>.from(
          l.map((model) => DoctorsModel.fromJson(model)));

      return doctors;
    }
    return doctors;
  }
}
