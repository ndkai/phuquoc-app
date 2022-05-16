import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class LoginFbAGGUc implements UseCase<LoginResponse, FbAGgParams> {
  final AuthRepo authRepo;

  LoginFbAGGUc(this.authRepo);

  @override
  Future<Either<Failure, LoginResponse>> call(FbAGgParams params) async {
    return authRepo.loginWithFbAGG(params.token, params.type);
  }
}

class FbAGgParams{
  final String token;
  final String type;

  FbAGgParams(this.token, this.type);
}