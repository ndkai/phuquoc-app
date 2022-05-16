import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/booking/data/models/BookingDelete.dart';
import 'package:phuquoc/feature/booking/data/models/available_dates.dart';
import 'package:phuquoc/feature/booking/data/models/available_time.dart';
import 'package:phuquoc/feature/booking/data/models/booking_his.dart';
import 'package:phuquoc/feature/booking/data/models/booking_response.dart';
import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';
import 'package:phuquoc/feature/booking/data/models/hospital_swagger.dart';
import 'package:phuquoc/feature/booking/data/models/service-and-date.dart';

abstract class BookingState extends Equatable {
  const BookingState();
}

class BookingInitial extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingLoading extends BookingState {
  @override
  List<Object> get props => [];
}


class BookingError extends BookingState {
  final String msg;

  BookingError(this.msg);
  @override
  List<Object> get props => [msg];
}


class GetHospitalLoaded extends BookingState {
  final HospitalSwagger data;

  GetHospitalLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class GetAvailableTimeLoaded extends BookingState {
  final AvalableTime data;

  GetAvailableTimeLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class GetAvailableDateLoaded extends BookingState {
  final AvailableDay data;

  GetAvailableDateLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class GetServiceADateLoaded extends BookingState {
  final ServiceAndDateSwagger data;

  GetServiceADateLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class GetDateByUnitAServiceLoaded extends BookingState {
  final DateByUnitAServiceSwagger data;

  GetDateByUnitAServiceLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class BookingLoaded extends BookingState {
  final BookingResponse data;

  BookingLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class BookingHisLoaded extends BookingState {
  final BookingHisResponse data;

  BookingHisLoaded(this.data);
  @override
  List<Object> get props => [data];
}

class BookingDeteteLoaded extends BookingState {
  final BookingDelete data;

  BookingDeteteLoaded(this.data);
  @override
  List<Object> get props => [data];
}



