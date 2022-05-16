import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class ComfirmPassUC implements UseCase<ComfirmOtp, OTPRequest> {
  final AuthRepo authRepo;

  ComfirmPassUC(this.authRepo);

  @override
  Future<Either<Failure, ComfirmOtp>> call(OTPRequest params) async {
    return authRepo.comfirmOtp(params);
  }
}
