import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phuquoc/core/constant/global_var.dart';
import 'package:phuquoc/core/constants.dart';
import 'package:phuquoc/feature/user/data/models/get_user_info.dart';
import 'package:phuquoc/feature/user/data/models/profile_swagger.dart';
import 'package:phuquoc/feature/user/domain/entities/user_update_request.dart';

abstract class UserDatasource {
  Future<UserInfoSwagger> getUserinfo();
  Future<bool> updateUserInfor(UpdateInforRequest request);

  Future<ProfileSwagger> getUserProfile(String userId);
}

class UserDatasourceImpl implements UserDatasource {
  final http.Client? client;

  UserDatasourceImpl({@required this.client});

  @override
  Future<UserInfoSwagger> getUserinfo() {
    return _getUserinfo();
  }

  @override
  Future<bool> updateUserInfor(UpdateInforRequest request) {
    return _updateUserInfor(request);
  }

  @override
  Future<ProfileSwagger> getUserProfile(String userId) {
    return _getUserProfile(userId);
  }

  Future<ProfileSwagger> _getUserProfile(String userId) async{
    try{
      final response = await client!
          .get(Uri.parse("${scheduleApi}/api/Profiles?userId=${userId}"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getUserProfile ${response.statusCode}");
      print("_getUserProfile ${response.body}");
      if(response.statusCode == 200){
        ProfileSwagger data = ProfileSwagger.fromJson(jsonDecode(response.body));
        return data;
      } else{
        return ProfileSwagger(error: response.body);
      }
    }  catch(e){
      return ProfileSwagger(error: e.toString());
    }
  }

  Future<bool> _updateUserInfor(UpdateInforRequest request) async{
    try{
      final response = await client!
          .put(Uri.parse("${scheduleApi}/api/Profiles"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },
        body: jsonEncode(request)
      );
      print("_updateUserInfor ${response.statusCode}");
      print("_updateUserInfor ${response.body}");
      if(response.statusCode == 200){
        return true;
      } else{
        return false;
      }
    }  catch(e){
      return false;
    }
  }


  Future<UserInfoSwagger> _getUserinfo() async{
    try{
      final response = await client!
          .get(Uri.parse("${userApi}/api/Users/GetUserInfo"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        'Authorization': 'Bearer ${currentUser!.accessToken}',
      },);
      print("_getUserinfo ${response.statusCode}");
      print("_getUserinfo ${response.body}");
      if(response.statusCode == 200){
        UserInfoSwagger data = UserInfoSwagger.fromJson(jsonDecode(response.body));
        return data;
      } else{
        return UserInfoSwagger(error: response.body);
      }
    }  catch(e){
      return UserInfoSwagger(error: e.toString());
    }
  }







}
