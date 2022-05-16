import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/booking_response.dart';
import 'package:phuquoc/feature/booking/domain/entities/booking_request.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class BookingUc implements UseCase<BookingResponse, BookingRequest> {
  final BookingRepo bookingRepo;

  BookingUc(this.bookingRepo);

  @override
  Future<Either<Failure, BookingResponse>> call(BookingRequest params) async {
    return bookingRepo.booking(params);
  }
}
