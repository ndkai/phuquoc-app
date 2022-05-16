class SignupRequest {
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String? fullName;
  bool? isElasticSynced;
  String? groupName;

  SignupRequest(
      {this.username="",
        this.password,
        this.email="",
        this.phoneNumber,
        this.fullName,
        this.isElasticSynced = false,
        this.groupName = 'CUSTOMER'});

  SignupRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    fullName = json['fullName'];
    isElasticSynced = json['isElasticSynced'];
    groupName = json['groupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['fullName'] = this.fullName;
    data['isElasticSynced'] = this.isElasticSynced;
    data['groupName'] = this.groupName;
    return data;
  }
}