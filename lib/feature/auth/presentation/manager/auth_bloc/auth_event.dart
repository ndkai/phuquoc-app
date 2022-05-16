import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoadingE extends AuthEvent{

  LoadingE();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoginE extends AuthEvent{
  final LoginRequest loginRequest;

  LoginE(this.loginRequest);
  @override
  // TODO: implement props
  List<Object?> get props => [loginRequest];

}

class SignupE extends AuthEvent{
  final SignupRequest signupRequest;

  SignupE(this.signupRequest);
  @override
  // TODO: implement props
  List<Object?> get props => [signupRequest];

}

class CheckLoginE extends AuthEvent{
  CheckLoginE();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class GenerateOtpE extends AuthEvent{
  final OTPRequest otpRequest;
  GenerateOtpE(this.otpRequest);
  @override
  // TODO: implement props
  List<Object?> get props => [otpRequest];
}

class ComfirmOtpE extends AuthEvent{
  final OTPRequest otpRequest;
  ComfirmOtpE(this.otpRequest);
  @override
  // TODO: implement props
  List<Object?> get props => [otpRequest];
}

class ResetPassE extends AuthEvent{
  final String newpass;
  ResetPassE(this.newpass);
  @override
  // TODO: implement props
  List<Object?> get props => [newpass];
}

class FbAGgLoginE extends AuthEvent{
  final String type;
  final String token;
  FbAGgLoginE(this.type, this.token);
  @override
  // TODO: implement props
  List<Object?> get props => [type, token];
}

class GetSQE extends AuthEvent{
  GetSQE();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


