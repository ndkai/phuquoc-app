import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/booking.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/booking_his.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/delete_booking.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get-date-by-unit-and-service-uc.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_date_available.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_service_a_date.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/get_time_available.dart';
import 'package:phuquoc/feature/booking/domain/use_cases/hospital-uc.dart';

import 'bloc.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final HospitalUc hospitalUc;
  final GetDateAvailableUc getDateAvailableUc;
  final GetTimeAvailableUc getTimeAvailableUc;
  final GetServiceADateUc getServiceADateUc;
  final GetDateByUnitAServiceUc getDateByUnitAServiceUc;
  final BookingUc bookingUc;
  final BookingHisUc bookingHisUc;
  final DeleteBookingUc deleteBookingUc;

  BookingBloc(this.hospitalUc, this.getDateAvailableUc, this.getTimeAvailableUc, this.getServiceADateUc, this.getDateByUnitAServiceUc, this.bookingUc, this.bookingHisUc, this.deleteBookingUc) : super(BookingInitial()){
    on<BookingLoadingE>(_loadingE);
    on<GetHospitalByServiceE>(_getHospitalByService);
    on<GetAvailableTimeE>(_getAvailableTime);
    on<GetAvailableDateE>(_getAvailableDate);
    on<GetServiceADateE>(_getServiceADate);
    on<GetDateByUnitAServiceE>(_getDateByServiceAUnit);
    on<BookingE>(_booking);
    on<GetBookingHisE>(_bookingHis);
    on<DeleteBookingE>(_deleteBooking);
  }

  Future<void> _deleteBooking(DeleteBookingE event, Emitter<BookingState> emit) async {
    var result = await deleteBookingUc(event.request);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? BookingDeteteLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _bookingHis(GetBookingHisE event, Emitter<BookingState> emit) async {
    var result = await bookingHisUc(event.request);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? BookingHisLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _booking(BookingE event, Emitter<BookingState> emit) async {
    var result = await bookingUc(event.request);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? BookingLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _getDateByServiceAUnit(GetDateByUnitAServiceE event, Emitter<BookingState> emit) async {
    var result = await getDateByUnitAServiceUc(GetDateByUnitAServiceParams(serviceId: event.serviceId, unitid: event.unitId));
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? GetDateByUnitAServiceLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _getServiceADate(GetServiceADateE event, Emitter<BookingState> emit) async {
    var result = await getServiceADateUc(GetServiceADateParams(date: event.date, id: event.sid));
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? GetServiceADateLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _getAvailableDate(GetAvailableDateE event, Emitter<BookingState> emit) async {
    var result = await getDateAvailableUc(event.sid);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? GetAvailableDateLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _getAvailableTime(GetAvailableTimeE event, Emitter<BookingState> emit) async {
    var result = await getTimeAvailableUc(event.sid);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? GetAvailableTimeLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _getHospitalByService(GetHospitalByServiceE event, Emitter<BookingState> emit) async {
    var result = await hospitalUc(event.sid);
    return emit(
        result.fold(
                (l) => BookingError(l.msg),
                (r) => r.error == null? GetHospitalLoaded(r) : BookingError(r.error.toString())));
  }

  Future<void> _loadingE(BookingLoadingE event, Emitter<BookingState> emit) async {
    return emit(BookingLoading());
  }
}
