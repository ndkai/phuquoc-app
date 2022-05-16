class UserInfoSwagger {
  Data? data;
  bool? succeed;
  String? error;

  UserInfoSwagger({this.data,this.succeed, this.error});

  UserInfoSwagger.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    succeed = json['succeed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeed'] = this.succeed;
    return data;
  }
}

class Data {
  UserInfo? userInfo;


  Data({this.userInfo});

  Data.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class UserInfo {
  String? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? fullName;
  bool? isConfirmed;
  bool? isDisabled;
  bool? isElasticSynced;

  UserInfo(
      {this.id,
        this.username,
        this.email,
        this.phoneNumber,
        this.fullName,
        this.isConfirmed,
        this.isDisabled,
        this.isElasticSynced});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    isConfirmed = json['isConfirmed'];
    isDisabled = json['isDisabled'];
    isElasticSynced = json['isElasticSynced'];
  }
}