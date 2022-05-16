import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_his_request.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_request.dart';
import 'package:phuquoc/feature/booking/domain/entities/delete_booking_request.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class BookingLoadingE extends BookingEvent{

  BookingLoadingE();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class GetHospitalByServiceE extends BookingEvent{
  final String sid;

  GetHospitalByServiceE(this.sid);

  @override
  // TODO: implement props
  List<Object?> get props => [sid];
}

class GetAvailableTimeE extends BookingEvent{
  final String sid;

  GetAvailableTimeE(this.sid);

  @override
  // TODO: implement props
  List<Object?> get props => [sid];
}

class GetAvailableDateE extends BookingEvent{
  final String sid;

  GetAvailableDateE(this.sid);

  @override
  // TODO: implement props
  List<Object?> get props => [sid];
}

class GetServiceADateE extends BookingEvent{
  final String sid;
  final String date;

  GetServiceADateE(this.sid, this.date);

  @override
  // TODO: implement props
  List<Object?> get props => [sid, date];
}


class GetDateByUnitAServiceE extends BookingEvent{
  final String unitId;
  final String serviceId;

  GetDateByUnitAServiceE(this.unitId, this.serviceId);

  @override
  // TODO: implement props
  List<Object?> get props => [unitId, serviceId];
}

class BookingE extends BookingEvent{
  final BookingRequest request;

  BookingE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class GetBookingHisE extends BookingEvent{
  final BookingHisRequest request;

  GetBookingHisE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}

class DeleteBookingE extends BookingEvent{
  final DeleteBookingRequest request;

  DeleteBookingE(this.request);

  @override
  // TODO: implement props
  List<Object?> get props => [request];
}


