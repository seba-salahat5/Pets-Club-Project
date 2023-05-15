// ignore_for_file: unnecessary_null_comparison

class BookingModel {
  int? docId;
  String? dateTime;

  BookingModel.fromJson(Map json) {
    docId = json['docId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['docId'] = docId;
    map['dateTime'] = dateTime;
    return map;
  }
}
