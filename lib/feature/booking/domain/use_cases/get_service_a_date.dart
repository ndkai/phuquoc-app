import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/service-and-date.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class GetServiceADateUc implements UseCase<ServiceAndDateSwagger, GetServiceADateParams> {
  final BookingRepo bookingRepo;

  GetServiceADateUc(this.bookingRepo);

  @override
  Future<Either<Failure, ServiceAndDateSwagger>> call(GetServiceADateParams params) async {
    return bookingRepo.getServiceAndDate(params.id!, params.date!);
  }
}

class GetServiceADateParams{
  final String? id;
  final String? date;

  GetServiceADateParams({this.id, this.date});
}

