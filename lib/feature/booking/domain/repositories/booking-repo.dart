import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
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

abstract class BookingRepo {
  Future<Either<Failure, HospitalSwagger>> getHospital(String sid);
  Future<Either<Failure, AvailableDay>> getAvalableDay(String sid);
  Future<Either<Failure, AvalableTime>> getAvailableTime(String sid);
  Future<Either<Failure, ServiceAndDateSwagger>> getServiceAndDate(String sid, String date);
  Future<Either<Failure, DateByUnitAServiceSwagger>> getDateByServiceAUnit(String unitId, String serviceId);
  Future<Either<Failure, BookingResponse>> booking(BookingRequest request);
  Future<Either<Failure, BookingHisResponse>> bookingHis(BookingHisRequest request);
  Future<Either<Failure, BookingDelete>> deleteBooking(DeleteBookingRequest request);



}
