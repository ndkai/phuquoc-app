import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class ResetPassUC implements UseCase<bool, String> {
  final AuthRepo authRepo;

  ResetPassUC(this.authRepo);

  @override
  Future<Either<Failure, bool>> call(String params) async {
    return authRepo.resetpass(params);
  }
}
