// ignore_for_file: unnecessary_null_comparison

class BookingModel {
  int? grompersonId;
  String? dateTime;

  BookingModel.fromJson(Map json) {
    grompersonId = json['grompersonId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['grompersonId'] = grompersonId;
    map['dateTime'] = dateTime;
    return map;
  }
}
