import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class GetDateByUnitAServiceUc implements UseCase<DateByUnitAServiceSwagger, GetDateByUnitAServiceParams> {
  final BookingRepo bookingRepo;

  GetDateByUnitAServiceUc(this.bookingRepo);

  @override
  Future<Either<Failure, DateByUnitAServiceSwagger>> call(GetDateByUnitAServiceParams params) async {
    return bookingRepo.getDateByServiceAUnit(params.unitid!, params.serviceId!);
  }
}

class GetDateByUnitAServiceParams{
  final String? unitid;
  final String? serviceId;

  GetDateByUnitAServiceParams({this.unitid, this.serviceId});
}

