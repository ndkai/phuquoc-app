import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/available_time.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class GetTimeAvailableUc implements UseCase<AvalableTime, String> {
  final BookingRepo bookingRepo;

  GetTimeAvailableUc(this.bookingRepo);

  @override
  Future<Either<Failure, AvalableTime>> call(String params) async {
    return bookingRepo.getAvailableTime(params);
  }
}
