class LoginRequest {
  String? username;
  String? phoneNumber;
  String? email;
  String? password;
  PermissionQuery? permissionQuery;

  LoginRequest(
      {this.username,
        this.phoneNumber,
        this.email,
        this.password,
        this.permissionQuery});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    // permissionQuery = json['permissionQuery'] != null
    //     ? new PermissionQuery.fromJson(json['permissionQuery'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    // if (this.permissionQuery != null) {
    //   data['permissionQuery'] = this.permissionQuery.toJson();
    // }
    return data;
  }
}

class PermissionQuery {
  String? type;
  List<String>? groups;
  List<String>? roles;

  PermissionQuery({this.type, this.groups, this.roles});

  PermissionQuery.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    groups = json['groups'].cast<String>();
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['groups'] = this.groups;
    data['roles'] = this.roles;
    return data;
  }
}