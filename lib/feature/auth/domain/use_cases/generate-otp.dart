import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class GenerateOtpUc implements UseCase<bool, OTPRequest> {
  final AuthRepo authRepo;

  GenerateOtpUc(this.authRepo);

  @override
  Future<Either<Failure, bool>> call(OTPRequest params) async {
    return authRepo.generateOtp(params);
  }
}
