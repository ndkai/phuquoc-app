import 'package:phuquoc/feature/booking/domain/entities/booking_request.dart';

import 'date_by_service_a_unit.dart';

class BookingResponse {
   Booking? booking;
   String? error;
   BookingResponse({this.booking, this.error});

   BookingResponse.fromJson(Map<String, dynamic> json) {
      booking = json['booking'] != null ? new Booking.fromJson(json['booking']) : null;
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      if (this.booking != null) {
         data['booking'] = this.booking!.toJson();
      }
      return data;
   }
}

class Booking {
   Data? data;

   Booking({this.data});

   Booking.fromJson(Map<String, dynamic> json) {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      return data;
   }
}

class Data {
   String? id;
   int? status;
   String? dateBooked;
   bool? hasFile;
   MInterval? interval;
   Unit? unit;
   Doctor? doctor;
   Room? room;
   Room? service;
   Customer? customer;
   List<Null>? contacts;
   String? date;
   String? bookedByUser;

   Data({this.id, this.status, this.dateBooked, this.hasFile, this.interval, this.unit, this.doctor, this.room, this.service, this.customer, this.contacts, this.date, this.bookedByUser});

   Data.fromJson(Map<String, dynamic> json) {
      id = json['id'];
      status = json['status'];
      dateBooked = json['dateBooked'];
      hasFile = json['hasFile'];
      interval = json['interval'] != null ? new MInterval.fromJson(json['interval']) : null;
      unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
      doctor = json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
      room = json['room'] != null ? new Room.fromJson(json['room']) : null;
      service = json['service'] != null ? new Room.fromJson(json['service']) : null;
      customer = json['customer'] != null ? new Customer.fromJson(json['customer']) : null;
      date = json['date'];
      bookedByUser = json['bookedByUser'];
   }

   Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['id'] = this.id;
      data['status'] = this.status;
      data['dateBooked'] = this.dateBooked;
      if (this.interval != null) {
         data['interval'] = this.interval!.toJson();
      }
      if (this.unit != null) {
         data['unit'] = this.unit!.toJson();
      }
      if (this.doctor != null) {
         data['doctor'] = this.doctor!.toJson();
      }
      if (this.room != null) {
         data['room'] = this.room!.toJson();
      }
      if (this.service != null) {
         data['service'] = this.service!.toJson();
      }
      if (this.customer != null) {
         data['customer'] = this.customer!.toJson();
      }
      data['date'] = this.date;
      data['bookedByUser'] = this.bookedByUser;
      return data;
   }
}


