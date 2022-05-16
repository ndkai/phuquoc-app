class ComfirmOtp {
  String? accessToken;
  String? tokenType;
  String? userId;
  String? username;
  int? expiresIn;
  List<Null>? resourcePermissions;
  List<Null>? uiPermissions;
  String? error;

  ComfirmOtp(
      {this.accessToken,
        this.tokenType,
        this.userId,
        this.username,
        this.expiresIn,
        this.resourcePermissions,
        this.error,
        this.uiPermissions});

  ComfirmOtp.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    userId = json['userId'];
    username = json['username'];
    expiresIn = json['expires_in'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['userId'] = this.userId;
    data['username'] = this.username;
    data['expires_in'] = this.expiresIn;

    return data;
  }
}