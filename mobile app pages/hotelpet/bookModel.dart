// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

class BookHotelModel {
  bool? status;
  String? message;
  BookHotelData? data;
  BookHotelModel.fromJson(Map<String, dynamic> json) {
    data = BookHotelData.fromJson(json['data']);
  }
}

BookHotelData bookhotelDataFromJson(String str) =>
    BookHotelData.fromJson(json.decode(str));
String bookhotelDataToJson(BookHotelData data) => json.encode(data.toJson());

class BookHotelData {
  List<ListBookHotel> bookhotel = [];

  BookHotelData.fromJson(Map<String, dynamic> json) {
    json['bookhotel'].forEach((element) {
      bookhotel.add(ListBookHotel.fromJson(element));
    });
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (bookhotel != null) {
      map['bookhotel'] = bookhotel.map((element) => element.toJson()).toList();
    }

    return map;
  }
}

ListBookHotel listBookHotelFromJson(String str) =>
    ListBookHotel.fromJson(json.decode(str));
String listBookHotelToJson(ListBookHotel data) => json.encode(data.toJson());

class ListBookHotel {
  String? id;
  String? user;
  String? pets;
  DateTime? firstdate;
  DateTime? lastdate;
  ListBookHotel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    user = json['user'];
    pets = json['pets'];
    firstdate = json['firstdate'];
    lastdate = json['lastdate'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user'] = user;
    map['pets'] = pets;
    map['firstdate'] = firstdate;
    map['lastdate'] = lastdate;
    return map;
  }
}
