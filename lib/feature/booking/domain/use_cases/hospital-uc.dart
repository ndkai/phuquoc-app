import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/hospital_swagger.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class HospitalUc implements UseCase<HospitalSwagger, String> {
  final BookingRepo bookingRepo;

  HospitalUc(this.bookingRepo);

  @override
  Future<Either<Failure, HospitalSwagger>> call(String params) async {
    return bookingRepo.getHospital(params);
  }
}
