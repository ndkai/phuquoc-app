import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import 'package:phuquoc/feature/booking/data/data_sources/booking_datasourse.dart';
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
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class BookingRepoImpl extends BookingRepo {
  final NetworkInfo? networkInfo;
  final BookingDatasource? bookingDatasource;

  BookingRepoImpl({
    this.networkInfo,
    this.bookingDatasource,
  });

  @override
  Future<Either<Failure, HospitalSwagger>> getHospital(String sid) {
    return _getHospital(bookingDatasource!.getHospitals(sid));
  }

  @override
  Future<Either<Failure, AvalableTime>> getAvailableTime(String sid) {
    return _getTime(bookingDatasource!.getIntervalsWithDayId(sid));
  }

  @override
  Future<Either<Failure, AvailableDay>> getAvalableDay(String sid) {
    return _getDay(bookingDatasource!.getDateAvailable(sid));
  }

  @override
  Future<Either<Failure, ServiceAndDateSwagger>> getServiceAndDate(String sid, String date) {
    return _getServiceAndDate(bookingDatasource!.getServiceAndDate(sid, date));
  }

  @override
  Future<Either<Failure, DateByUnitAServiceSwagger>> getDateByServiceAUnit(String unitId, String serviceId) {
    return _getDateByServiceAUnit(bookingDatasource!.getDateByServiceAUnit(unitId, serviceId));
  }

  @override
  Future<Either<Failure, BookingResponse>> booking(BookingRequest request) {
    return _booking(bookingDatasource!.booking(request));
  }

  @override
  Future<Either<Failure, BookingHisResponse>> bookingHis(BookingHisRequest request) {
    return _bookingHis(bookingDatasource!.getBookingHis(request));
  }

  @override
  Future<Either<Failure, BookingDelete>> deleteBooking(DeleteBookingRequest request) {
   return _deleteBooking(bookingDatasource!.deleteBooking(request));
  }

  Future<Either<Failure, BookingDelete>> _deleteBooking(
      Future<BookingDelete> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }


  Future<Either<Failure, BookingHisResponse>> _bookingHis(
      Future<BookingHisResponse> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }


  Future<Either<Failure, BookingResponse>> _booking(
      Future<BookingResponse> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }



  Future<Either<Failure, DateByUnitAServiceSwagger>> _getDateByServiceAUnit(
      Future<DateByUnitAServiceSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, ServiceAndDateSwagger>> _getServiceAndDate(
      Future<ServiceAndDateSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }



  Future<Either<Failure, AvalableTime>> _getTime(
      Future<AvalableTime> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, AvailableDay>> _getDay(
      Future<AvailableDay> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, HospitalSwagger>> _getHospital(
      Future<HospitalSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }







}