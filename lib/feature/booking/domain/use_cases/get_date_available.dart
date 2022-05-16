import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/available_dates.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class GetDateAvailableUc implements UseCase<AvailableDay, String> {
  final BookingRepo bookingRepo;

  GetDateAvailableUc(this.bookingRepo);

  @override
  Future<Either<Failure, AvailableDay>> call(String params) async {
    return bookingRepo.getAvalableDay(params);
  }
}
