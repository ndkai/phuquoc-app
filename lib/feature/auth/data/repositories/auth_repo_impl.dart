import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/core/network/network_info.dart';
import 'package:phuquoc/feature/auth/data/data_sources/auth_datasourse.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/data/models/signup-response.dart';
import 'package:phuquoc/feature/auth/domain/entities/comfirm_sq_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';
import 'package:phuquoc/feature/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final NetworkInfo? networkInfo;
  final AuthDataSource? authDataSource;

  AuthRepoImpl({
    this.networkInfo,
    this.authDataSource,
  });

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest) {
    return _login(authDataSource!.login(loginRequest));
  }

  @override
  Future<Either<Failure, SignupResponse>> signup(SignupRequest signupRequest) {
   return _signup(authDataSource!.signup(signupRequest));
  }

  @override
  Future<Either<Failure, ComfirmOtp>> comfirmOtp(OTPRequest otpRequest) {
    return _comfirmOtp(authDataSource!.comfirmOtp(otpRequest));
  }

  @override
  Future<Either<Failure, bool>> generateOtp(OTPRequest otpRequest) {
    return _boolData(authDataSource!.generateOtp(otpRequest));
  }

  @override
  Future<Either<Failure, bool>> resetpass(String newpass) {
    return _boolData(authDataSource!.resetpass(newpass));
  }

  @override
  Future<Either<Failure, LoginResponse>> loginWithFbAGG(String token, String flatform) {
    return _login(authDataSource!.loginWithFbAGG(token, flatform));
  }

  @override
  Future<Either<Failure, String>> comfirmSecurityQuestion(ComfirmSQRequest request) {
   return _comfirmSecurityQuestion(authDataSource!.comfirmSecurityQuestion(request));
  }

  @override
  Future<Either<Failure, QuestionSwagger>> getSecurityQuestion() {
    return _getSecurityQuestion(authDataSource!.getSecurityQuestion());
  }

  Future<Either<Failure, QuestionSwagger>> _getSecurityQuestion(
      Future<QuestionSwagger> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, String>> _comfirmSecurityQuestion(
      Future<String> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }


  Future<Either<Failure, ComfirmOtp>> _comfirmOtp(
      Future<ComfirmOtp> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, bool>> _boolData(
      Future<bool> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData; 
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, SignupResponse>> _signup(
      Future<SignupResponse> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }

  Future<Either<Failure, LoginResponse>> _login(
      Future<LoginResponse> getData) async {
    var connected = await networkInfo!.isConnected;
    if (connected != ConnectivityResult.none ) {
      try {
        final data = await getData;
        if(data.error != null){
          return Left(ServerFailure(data.error.toString()));
        }
        return Right(data);
      } catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    } else
      return Left(ServerFailure(NETWORK_FAILURE_MESSAGE));
  }





}
