import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class LoginUc implements UseCase<LoginResponse, LoginRequest> {
  final AuthRepo authRepo;

  LoginUc(this.authRepo);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginRequest params) async {
    return authRepo.login(params);
  }
}
