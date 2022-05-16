import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/booking/data/models/BookingDelete.dart';
import 'package:phuquoc/feature/booking/domain/entities/delete_booking_request.dart';
import 'package:phuquoc/feature/booking/domain/repositories/booking-repo.dart';

class DeleteBookingUc implements UseCase<BookingDelete, DeleteBookingRequest> {
  final BookingRepo bookingRepo;

  DeleteBookingUc(this.bookingRepo);

  @override
  Future<Either<Failure, BookingDelete>> call(DeleteBookingRequest params) async {
    return bookingRepo.deleteBooking(params);
  }
}
