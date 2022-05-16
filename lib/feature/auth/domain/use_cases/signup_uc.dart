import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/signup-response.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class SignupUc implements UseCase<SignupResponse, SignupRequest> {
  final AuthRepo authRepo;

  SignupUc(this.authRepo);

  @override
  Future<Either<Failure, SignupResponse>> call(SignupRequest params) async {
    return authRepo.signup(params);
  }
}
