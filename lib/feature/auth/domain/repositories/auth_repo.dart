import 'package:dartz/dartz.dart';
import 'package:phuquoc/core/error/failures.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/data/models/signup-response.dart';
import 'package:phuquoc/feature/auth/domain/entities/comfirm_sq_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest);
  Future<Either<Failure, SignupResponse>> signup(SignupRequest signupRequest);
  Future<Either<Failure, bool>> generateOtp(OTPRequest otpRequest);
  Future<Either<Failure, ComfirmOtp>> comfirmOtp(OTPRequest otpRequest);
  Future<Either<Failure, bool>> resetpass(String newpass);
  Future<Either<Failure, LoginResponse>> loginWithFbAGG(String token, String flatform);
  Future<Either<Failure, QuestionSwagger>> getSecurityQuestion();
  Future<Either<Failure, String>> comfirmSecurityQuestion(ComfirmSQRequest request);
}
