import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/booking_his.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_his_request.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class BookingHisUc implements UseCase<BookingHisResponse, BookingHisRequest> {
  final BookingRepo bookingRepo;

  BookingHisUc(this.bookingRepo);

  @override
  Future<Either<Failure, BookingHisResponse>> call(BookingHisRequest params) async {
    return bookingRepo.bookingHis(params);
  }
}
