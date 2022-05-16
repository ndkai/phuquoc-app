import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/feature/auth/data/models/comfirm_otp.dart';
import 'package:phuquoc/feature/auth/data/models/login-response.dart';
import 'package:phuquoc/feature/auth/data/models/question_swagger.dart';
import 'package:phuquoc/feature/auth/data/models/signup-response.dart';
import 'package:phuquoc/feature/auth/domain/entities/comfirm_sq_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/login_request.dart';
import 'package:phuquoc/feature/auth/domain/entities/otp-request.dart';
import 'package:phuquoc/feature/auth/domain/entities/signup_request.dart';

abstract class AuthDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);

  Future<SignupResponse> signup(SignupRequest signupRequest);

  Future<bool> generateOtp(OTPRequest otpRequest);

  Future<ComfirmOtp> comfirmOtp(OTPRequest otpRequest);

  Future<bool> resetpass(String newpass);

  Future<LoginResponse> loginWithFbAGG(String token, String flatform);

  Future<QuestionSwagger> getSecurityQuestion();

  Future<String> comfirmSecurityQuestion(ComfirmSQRequest request);
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client? client;

  AuthDataSourceImpl({@required this.client});

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) {
    return _login(loginRequest);
  }

  @override
  Future<SignupResponse> signup(SignupRequest signupRequest) {
   return _signup(signupRequest);
  }

  @override
  Future<bool> generateOtp(OTPRequest otpRequest) {
    return _generateOtp(otpRequest);
  }

  @override
  Future<ComfirmOtp> comfirmOtp(OTPRequest otpRequest) {
    return _comfirmOtp(otpRequest);
  }

  @override
  Future<bool> resetpass(String newpass) {
    return _resetpass(newpass);
  }

  @override
  Future<LoginResponse> loginWithFbAGG(String token, String flatform) {
    return _loginWithFbAGG(token, flatform);
  }

  @override
  Future<QuestionSwagger> getSecurityQuestion() {
    return _getSecurityQuestion();
  }

  @override
  Future<String> comfirmSecurityQuestion(ComfirmSQRequest request) {
    return _comfirmSecurityQuestion(request);
  }

  Future<String> _comfirmSecurityQuestion(ComfirmSQRequest request) async{
    try{
      var body = jsonEncode({
        "username": "${request.username}",
        "securityQuestionId": "${request.id}",
        "securityQuestionAnswer": "${request.answer}"
      });
      final response = await client!
          .post(Uri.parse("${userApi}/api/Users/ResetPassword/ConfirmSecurityQuestion"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body);
      print("_comfirmSecurityQuestion ${response.statusCode}");
      print("_comfirmSecurityQuestion ${response.body}");
      if(response.statusCode == 200){
        return response.body;
      } else{
        return response.body;
      }
    }  catch(e){
      return e.toString();
    }
  }


  Future<QuestionSwagger> _getSecurityQuestion() async{
    try{
      final response = await client!
          .get(Uri.parse("${userApi}/api/SecurityQuestion"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },);
      print("_getSecurityQuestion ${response.statusCode}");
      print("_getSecurityQuestion ${response.body}");
      if(response.statusCode == 200){
        QuestionSwagger data = QuestionSwagger.fromJson(jsonDecode(response.body));
        return data;
      } else{
        QuestionSwagger data = QuestionSwagger(error: response.body);
        return data;
      }
    }  catch(e){
      QuestionSwagger data = QuestionSwagger(error: e.toString());
      return data;
    }
  }

  Future<LoginResponse> _loginWithFbAGG(String token, String flatform) async{
    try{
      if(flatform == "google"){
        var data = json.encode({
          "idToken": token
        });
        final response = await client!
            .post(Uri.parse("${userApi}/api/Users/LoginWithGoogle"), headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
            body: data);
        print("_loginWithFbAGG ${response.statusCode}");
        print("_loginWithFbAGG ${response.body}");
        if(response.statusCode == 200){
          return LoginResponse();
        } else{
          return LoginResponse(error: response.body);
        }
      } else
      if(flatform == "facebook"){
        var data = json.encode({
          "accessToken": token
        });
        final response = await client!
            .post(Uri.parse("${userApi}/api/Users/LoginWithFacebook"), headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
            body: data);
        print("_loginWithFbAGG ${response.statusCode}");
        print("_loginWithFbAGG ${response.body}");
        if(response.statusCode == 200){
          return LoginResponse();
        } else{
          return LoginResponse(error: response.body);
        }
      }
      return LoginResponse();
    }  catch(e){
      return LoginResponse(error: e.toString());
    }
  }

  Future<bool> _resetpass(String newpass) async{
    try{
      List<String> request = newpass.split(",");
      var data = json.encode({
        "newPassword": request.first
      });
      final response = await client!
          .post(Uri.parse("${userApi}/api/Users/ResetPassword"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization':"Bearer ${request.last}"
      },
          body: data);
      print("_resetpass ${response.statusCode}");
      print("_resetpass ${response.body}");
      if(response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    }  catch(e){
      return false;
    }
  }

  Future<ComfirmOtp> _comfirmOtp(OTPRequest otpRequest) async{
    try{
      var data = json.encode({
        "phoneNumber": "${otpRequest.phone}",
        "email": "${otpRequest.email}",
        "otp": "${otpRequest.otp}"
      });
      final response = await client!
          .post(Uri.parse("${userApi}/api/Users/ResetPassword/ConfirmOTP"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
          body: data);
      print("_comfirmOtp ${response.statusCode}");
      print("_comfirmOtp ${response.body}");
      if(response.statusCode == 200){
        ComfirmOtp data = ComfirmOtp.fromJson(jsonDecode(response.body));
        return data;
      } else{
        ComfirmOtp data = ComfirmOtp(error: response.body);
        return data;
      }
    }  catch(e){
      ComfirmOtp data = ComfirmOtp(error: e.toString());
      return data;
    }
  }

  Future<bool> _generateOtp(OTPRequest otpRequest) async{
    try{
      var data = json.encode({
        "phoneNumber": "${otpRequest.phone}",
        "email": "${otpRequest.email}"
      });
      print("_generateOtp state");
      final response = await client!
          .post(Uri.parse("${userApi}/api/Users/ResetPassword/GenerateOTP"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
          body: data);
      print("_generateOtp ${response.statusCode}");
      print("_generateOtp ${response.body}");
      if(response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    }  catch(e){
      print('_generateOtp ${e}');
      return false;
    }
  }

  Future<SignupResponse> _signup(SignupRequest signupRequest) async{
     try{
       var data = json.encode(signupRequest);
       final response = await client!
           .post(Uri.parse("${userApi}/api/Users"), headers: {
         "Accept": "application/json",
         "content-type": "application/json",
       },
           body: data);
       print("_signup ${response.statusCode}");
       print("_signup ${response.body}");
       if(response.statusCode == 200){
         return SignupResponse(id: response.body);
       } else{
          return SignupResponse(error: response.body);
       }
     }  catch(e){
       return SignupResponse(error: e.toString());
     }
  }

  Future<LoginResponse> _login(LoginRequest loginRequest) async{
      try{
        var data = json.encode(loginRequest);
        print("login request ${data.toString()}");
        final response = await client!
            .post(Uri.parse("${userApi}/api/Users/Login"), headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        }, body: data);
        print("_login ${response.statusCode}");
        print("_login ${response.body}");
        if(response.statusCode == 200){
          LoginResponse data = LoginResponse.fromJson(jsonDecode(response.body));
          prefs!.setString(TIME_EXPIRE,  DateTime.now().add(Duration(seconds: data.expiresIn!)).toIso8601String());
          prefs!.setString(LOGIN_SAVE, json.encode(data));
          return data;
        } else{
         return LoginResponse(error: response.body);
        }
      }  catch(e){
        return LoginResponse(error: e.toString());
      }

  }









}
