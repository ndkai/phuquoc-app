class LoginResponse {
  String? accessToken;
  String? tokenType;
  String? userId;
  String? username;
  int? expiresIn;
  String? error;

  LoginResponse(
      {this.accessToken,
        this.tokenType,
        this.userId,
        this.username,
        this.expiresIn,
        this.error,
     });

  LoginResponse.fromJson(Map<String, dynamic> json) {
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