import 'package:equatable/equatable.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/data/models/signup-response.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthError extends AuthState {
  final String msg;

  AuthError(this.msg);
  @override
  List<Object> get props => [msg];
}

class SignUpLoaded extends AuthState {
  final SignupResponse signupResponse;

  SignUpLoaded(this.signupResponse);
  @override
  List<Object> get props => [signupResponse];
}

class LoginLoaded extends AuthState {
  final LoginResponse loginResponse;

  LoginLoaded(this.loginResponse);
  @override
  List<Object> get props => [loginResponse];
}

class AlReadyLogin extends AuthState {
  final LoginResponse loginResponse;
  AlReadyLogin(this.loginResponse);
  @override
  List<Object> get props => [loginResponse];
}

class ComfirmOtpLoaded extends AuthState {
  final ComfirmOtp comfirmOtp;
  ComfirmOtpLoaded(this.comfirmOtp);
  @override
  List<Object> get props => [comfirmOtp];
}

class GenerateOtpLoaded extends AuthState {
  GenerateOtpLoaded();
  @override
  List<Object> get props => [];
}

class ResetPassLoaded extends AuthState {
  ResetPassLoaded();
  @override
  List<Object> get props => [];
}

class FbAGgLoaded extends AuthState {
  final LoginResponse loginResponse;
  FbAGgLoaded(this.loginResponse);
  @override
  List<Object> get props => [loginResponse];
}

class GetSQLoaded extends AuthState {
  final QuestionSwagger questionSwagger;
  GetSQLoaded(this.questionSwagger);
  @override
  List<Object> get props => [questionSwagger];
}