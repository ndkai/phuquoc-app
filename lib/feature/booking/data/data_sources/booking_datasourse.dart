import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/feature/booking/data/models/BookingDelete.dart';
import 'package:phuquoc/feature/booking/data/models/available_dates.dart';
import 'package:phuquoc/feature/booking/data/models/available_time.dart';
import 'package:phuquoc/feature/booking/data/models/booking_his.dart';
import 'package:phuquoc/feature/booking/data/models/booking_response.dart';
import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';
import 'package:phuquoc/feature/booking/data/models/hospital_swagger.dart';
import 'package:phuquoc/feature/booking/data/models/service-and-date.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_his_request.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_request.dart';
import 'package:phuquoc/feature/booking/domain/entities/delete_booking_request.dart';

abstract class BookingDatasource {
  Future<HospitalSwagger> getHospitals(String sid);
  Future<AvailableDay> getDateAvailable(String sid);
  Future<AvalableTime> getIntervalsWithDayId(String sid);
  Future<ServiceAndDateSwagger> getServiceAndDate(String sid, String date);
  Future<DateByUnitAServiceSwagger> getDateByServiceAUnit(String unitId, String serviceid);
  Future<BookingResponse> booking(BookingRequest request);
  Future<BookingHisResponse> getBookingHis(BookingHisRequest request);
  Future<BookingDelete> deleteBooking(DeleteBookingRequest request);

}

class BookingDatasourceImpl implements BookingDatasource {
  final http.Client? client;

  BookingDatasourceImpl({@required this.client});

  @override
  Future<HospitalSwagger> getHospitals(String sid) {
    return _getHospitals(sid);
  }

  @override
  Future<AvailableDay> getDateAvailable(String sid) {
   return _getDateAvailable(sid);
  }

  @override
  Future<AvalableTime> getIntervalsWithDayId(String sid) {
    // TODO: implement getIntervalsWithDayId
    return _getIntervalsWithDayId(sid);
  }

  @override
  Future<ServiceAndDateSwagger> getServiceAndDate(String sid, String date) {
    return _getServiceAndDate(sid, date);
  }

  @override
  Future<DateByUnitAServiceSwagger> getDateByServiceAUnit(String unitId, String serviceid) {
   return _getDateByServiceAUnit(unitId,serviceid );
  }

  @override
  Future<BookingHisResponse> getBookingHis(BookingHisRequest request) {
    return _getBookingHis(request);
  }

  @override
  Future<BookingDelete> deleteBooking(DeleteBookingRequest request) {
    return _deleteBooking(request);
  }

  Future<BookingDelete> _deleteBooking(DeleteBookingRequest request) async{
    try{
      var body = jsonEncode({
        "id": "${request.id}",
        "status": 3,
        "note": "string",
        "rate": "string",
        "typeRating": "string",
        "desc": "string",
        "consultingContent": {
          "type": "string",
          "content": "string",
          "result": "string",
          "note": "string"
        },
        "testingContent": {
          "content": "string",
          "result": "string",
          "note": "string"
        }
      });
      print("_deleteBooking ${request.id}");
      final response = await client!
          .put(Uri.parse("${bookingApi}/api/Examinations"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },
      body: body);
      print("_deleteBooking ${response.body}");
      if(response.statusCode == 200){
        return BookingDelete();
      } else{
        return BookingDelete(error: response.body);
      }
    }  catch(e){
      print("_getBookingHis ${e}");
      return BookingDelete(error: e.toString());
    }

  }

  Future<BookingHisResponse> _getBookingHis(BookingHisRequest request) async{
    try{
      final response = await client!
          .get(Uri.parse("${bookingApi}/api/Examinations?status=1"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getBookingHis ${response.statusCode}");
      print("_getBookingHis ${response.body}");
      if(response.statusCode == 200){
        BookingHisResponse data = BookingHisResponse.fromJson(jsonDecode(response.body));
        print("_getBookingHis ${data.data!.first.id}");
        return data;
      } else{
        return BookingHisResponse(error: response.body);
      }
    }  catch(e){
      print("_getBookingHis ${e}");
      return BookingHisResponse(error: e.toString());
    }
  }

  Future<DateByUnitAServiceSwagger> _getDateByServiceAUnit(String unitId, String serviceid) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/WorkingCalendars/GetDaysByUnitAndService?"
          "unitId=${unitId}"
          "&serviceId=${serviceid}"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("${scheduleApi}/api/WorkingCalendars/GetDaysByUnitAndService?"
          "unitId=${unitId}"
          "&serviceId=${serviceid}");
      print("_getDateByServiceAUnit ${response.statusCode}");
      log("_getDateByServiceAUnit { \"dateByServiceAndUnit\":${response.body}}");
      String body = "{ \"dateByServiceAndUnit\":${response.body}}";
      if(response.statusCode == 200){
        DateByUnitAServiceSwagger data = DateByUnitAServiceSwagger.fromJson(jsonDecode(body));
        return data;
      } else{
        return DateByUnitAServiceSwagger(error: response.body);
      }
    }  catch(e){
      return DateByUnitAServiceSwagger(error: e.toString());
    }

  }

  @override
  Future<BookingResponse> booking(BookingRequest request) {
    return _booking(request);
  }

  Future<BookingResponse> _booking(BookingRequest request) async{
    try{
      var data = jsonEncode(request.toJson());
      final response = await client!
          .post(Uri.parse("${bookingApi}/api/Examinations"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },
      body: data);
      print("_booking ${response.statusCode}");
      log("_booking { \"getServiceAndDate\":${response.body}}");
      // String body = "{ \"booking\":${response.body}}";
      if(response.statusCode == 200){
        // ServiceAndDateSwagger data = ServiceAndDateSwagger.fromJson(jsonDecode(body));
        return BookingResponse();
      } else{
        return BookingResponse(error: response.body);
      }
    }  catch(e){
      return BookingResponse(error: e.toString());
    }
  }

  Future<ServiceAndDateSwagger> _getServiceAndDate(String sid, String date) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/Hospitals/GetByServiceAndDate"
          "/${sid}/${date}"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getServiceAndDate ${response.statusCode}");
      log("_getServiceAndDate { \"getServiceAndDate\":${response.body}}");
      String body = "{ \"getServiceAndDate\":${response.body}}";
      if(response.statusCode == 200){
        ServiceAndDateSwagger data = ServiceAndDateSwagger.fromJson(jsonDecode(body));
        return data;
      } else{
        return ServiceAndDateSwagger(error: response.body);
      }
    }  catch(e){
      return ServiceAndDateSwagger(error: e.toString());
    }

  }

  Future<AvalableTime> _getIntervalsWithDayId(String sid) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/WorkingCalendars/GetIntervalsWithDayId/${sid}"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("${scheduleApi}/api/WorkingCalendars/GetIntervalsWithDayId/${sid}");
      print("_getIntervalsWithDayId ${response.statusCode}");
      log("_getIntervalsWithDayId { \"times\":${response.body}}");
      String body = "{ \"times\":${response.body}}";
      if(response.statusCode == 200){
        AvalableTime data = AvalableTime.fromJson(jsonDecode(body));
        return data;
      } else{
        return AvalableTime(error: response.body);
      }
    }  catch(e){
      return AvalableTime(error: e.toString());
    }
  }

  Future<AvailableDay> _getDateAvailable(String sid) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/Days/Available/${sid}"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getDateAvailable ${response.statusCode}");
      log("_getDateAvailable { \"dates\":${response.body}}");
      String body = "{ \"dates\":${response.body}}";
      if(response.statusCode == 200){
        AvailableDay data = AvailableDay.fromJson(jsonDecode(body));
        return data;
      } else{
        return AvailableDay(error: response.body);
      }
    }  catch(e){
      return AvailableDay(error: e.toString());
    }

  }

  Future<HospitalSwagger> _getHospitals(String sid) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/Hospitals"),
          // .get(Uri.parse("${scheduleApi}/api/Hospitals/${sid}"),
        headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getHospitals ${response.statusCode}");
      log("_getHospitals { \"data\":${response.body}}");
      String body = "{ \"data\":${response.body}}";
      if(response.statusCode == 200){
        HospitalSwagger data = HospitalSwagger.fromJson(jsonDecode(body));
        return data;
      } else{
        return HospitalSwagger(error: response.body);
      }
    }  catch(e){
      print("_getHospitals error ${e.toString()}");
      return HospitalSwagger(error: e.toString());
    }

  }



















}
