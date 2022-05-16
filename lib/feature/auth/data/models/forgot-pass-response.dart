// To parse this JSON data, do
//
//     final forgotPaswordAuth = forgotPaswordAuthFromJson(jsonString);

import 'dart:convert';

class ForgotPaswordAuth {
  ForgotPaswordAuth({
    this.accessToken,
    this.tokenType,
    this.userId,
    this.username,
    this.expiresIn,
    this.resourcePermissions,
    this.uiPermissions,
  });

  String? accessToken;
  String? tokenType;
  String? userId;
  String? username;
  int? expiresIn;
  List<dynamic>? resourcePermissions;
  List<dynamic>? uiPermissions;

  factory ForgotPaswordAuth.fromRawJson(String str) =>
      ForgotPaswordAuth.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPaswordAuth.fromJson(Map<String, dynamic> json) =>
      ForgotPaswordAuth(
        accessToken: json["access_token"] == null ? null : json["access_token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
        userId: json["userId"] == null ? null : json["userId"],
        username: json["username"] == null ? null : json["username"],
        expiresIn: json["expires_in"] == null ? null : json["expires_in"],
        resourcePermissions: json["resourcePermissions"] == null
            ? null
            : List<dynamic>.from(json["resourcePermissions"].map((x) => x)),
        uiPermissions: json["uiPermissions"] == null
            ? null
            : List<dynamic>.from(json["uiPermissions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken == null ? null : accessToken,
        "token_type": tokenType == null ? null : tokenType,
        "userId": userId == null ? null : userId,
        "username": username == null ? null : username,
        "expires_in": expiresIn == null ? null : expiresIn,
        "resourcePermissions": resourcePermissions == null
            ? null
            : List<dynamic>.from(resourcePermissions!.map((x) => x)),
        "uiPermissions": uiPermissions == null
            ? null
            : List<dynamic>.from(uiPermissions!.map((x) => x)),
      };
}
