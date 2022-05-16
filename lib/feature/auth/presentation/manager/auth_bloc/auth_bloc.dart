import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/core/usecase/usecase.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/comfirm-otp.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/generate-otp.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/get_sq_uc.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/login_fb_gg.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/login_uc.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/reset-pass.dart';
import 'package:phuquoc/feature/auth/domain/use_cases/signup_uc.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUc loginUc;
  final SignupUc signupUc;
  final ComfirmPassUC comfirmPassUC;
  final ResetPassUC resetPassUC;
  final GenerateOtpUc generateOtpUc;
  final LoginFbAGGUc loginFbAGGUc;
  final GetSQUC getSQUC;

  AuthBloc(this.loginUc, this.signupUc, this.comfirmPassUC, this.resetPassUC, this.generateOtpUc, this.loginFbAGGUc, this.getSQUC) : super(AuthInitial()){
    on<LoginE>(_login);
    on<SignupE>(_signup);
    on<LoadingE>(_loading);
    on<CheckLoginE>(_checkLogin);
    on<ResetPassE>(_resetpass);
    on<GenerateOtpE>(_generateOtp);
    on<ComfirmOtpE>(_cormfirmOtp);
    on<FbAGgLoginE>(_fbAggLogin);
    on<GetSQE>(_getSQ);
  }

  Future<void> _getSQ(GetSQE event, Emitter<AuthState> emit) async {
    var result = await getSQUC(NoParams());
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => r.error == null? GetSQLoaded(r) : AuthError(r.error.toString())));
  }

  Future<void> _fbAggLogin(FbAGgLoginE event, Emitter<AuthState> emit) async {
    var result = await loginFbAGGUc(FbAGgParams(event.token, event.type));
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => r.error == null? FbAGgLoaded(r) : AuthError(r.error.toString())));
  }

  Future<void> _cormfirmOtp(ComfirmOtpE event, Emitter<AuthState> emit) async {
    var result = await comfirmPassUC(event.otpRequest);
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => r.error == null? ComfirmOtpLoaded(r) : AuthError(r.error.toString())));
  }

  Future<void> _generateOtp(GenerateOtpE event, Emitter<AuthState> emit) async {
    var result = await generateOtpUc(event.otpRequest);
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => r? GenerateOtpLoaded() : AuthError("Lấy Otp thất bại")));
  }

  Future<void> _resetpass(ResetPassE event, Emitter<AuthState> emit) async {
    var result = await resetPassUC(event.newpass);
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => r? ResetPassLoaded() : AuthError("Đổi mật khẩu thất bại")));
  }

  Future<void> _signup(SignupE event, Emitter<AuthState> emit) async {
    var result = await signupUc(event.signupRequest);
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => SignUpLoaded(r)));
  }

  Future<void> _login(LoginE event, Emitter<AuthState> emit) async {
    var result = await loginUc(event.loginRequest);
    return emit(
        result.fold(
                (l) => AuthError(l.msg),
                (r) => LoginLoaded(r)));
  }

  Future<void> _checkLogin(CheckLoginE event, Emitter<AuthState> emit) async {
    var result = prefs!.getString(LOGIN_SAVE);
    print(" _checkLogin ${result}");
    if(result == null){
      return emit(AuthError(""));
    } else
    try{
     LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(result));
     String? timeExpire = prefs!.getString(TIME_EXPIRE);
     DateTime dateExpire = DateTime.parse(timeExpire!);
     if(dateExpire.compareTo(DateTime.now()) == 1){
       return emit(AlReadyLogin(loginResponse));
     }
    } catch(e){
      return emit(AuthError(""));
    }
    return emit(AuthError(""));
  }


  Future<void> _loading(LoadingE event, Emitter<AuthState> emit) async {
    return emit(
      AuthLoading()
    );
  }



  
}
