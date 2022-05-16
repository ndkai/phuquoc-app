import 'package:phuquoc/feature/booking/data/models/booking_response.dart';

class BookingHisResponse {
  String? error;
  List<Data>? data;

  BookingHisResponse({this.error, this.data,});

  BookingHisResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}







