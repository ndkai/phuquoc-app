class ProfileSwagger {
  String? id;
  String? fullname;
  String? username;
  bool? gender;
  String? dateOfBirth;
  String? phoneNumber;
  String? email;
  String? vaccinationCode;
  String? identityCard;
  String? address;
  String? province;
  String? district;
  String? ward;
  // Null relationProfileId;
  String? passportNumber;
  String? nation;
  bool? isDeleted;
  int? status;
  String? error;
  // Null externalId;

  ProfileSwagger(
      {this.id,
        this.fullname,
        this.username,
        this.error,
        this.gender,
        this.dateOfBirth,
        this.phoneNumber,
        this.email,
        this.vaccinationCode,
        this.identityCard,
        this.address,
        this.province,
        this.district,
        this.ward,
        // this.relationProfileId,
        this.passportNumber,
        this.nation,
        this.isDeleted,
        this.status,
        // this.externalId
      });

  ProfileSwagger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    vaccinationCode = json['vaccinationCode'];
    identityCard = json['identityCard'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    // relationProfileId = json['relationProfileId'];
    passportNumber = json['passportNumber'];
    nation = json['nation'];
    isDeleted = json['isDeleted'];
    status = json['status'];
    // externalId = json['externalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['vaccinationCode'] = this.vaccinationCode;
    data['identityCard'] = this.identityCard;
    data['address'] = this.address;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    // data['relationProfileId'] = this.relationProfileId;
    data['passportNumber'] = this.passportNumber;
    data['nation'] = this.nation;
    data['isDeleted'] = this.isDeleted;
    data['status'] = this.status;
    // data['externalId'] = this.externalId;
    return data;
  }
}