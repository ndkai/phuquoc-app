class UpdateInforRequest {
  String? fullname;
  String? id;
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
  String? passportNumber;
  String? nation;
  int? status;

  UpdateInforRequest(
      {this.fullname,
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
        this.passportNumber,
        this.id,
        this.nation,
        this.status});

  UpdateInforRequest.fromJson(Map<String, dynamic> json) {
    if(fullname != null){
      fullname = json['fullname'];
    }
    if(gender != null){
      gender = json['gender'];
    }
    if(dateOfBirth != null){
      dateOfBirth = json['dateOfBirth'];
    }
    if(phoneNumber != null){
      phoneNumber = json['phoneNumber'];
    }
    if(email != null){
      email = json['email'];
    }
    if(vaccinationCode != null){
      vaccinationCode = json['vaccinationCode'];
    }
    if(identityCard != null){
      identityCard = json['identityCard'];
    }
    if(address != null){
      address = json['address'];
    }
    if(province != null){
      province = json['province'];
    }
    if(district != null){
      district = json['district'];
    }
    if(ward != null){
      ward = json['ward'];
    }
    if(passportNumber != null){
      passportNumber = json['passportNumber'];
    }
    if(nation != null){
      nation = json['nation'];
    }
    if(status != null){
      status = json['status'];
    }
    if(id != null){
      id = json['id'];
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(fullname != null && fullname!.length > 0){
      data['fullname'] = this.fullname;
    }
    if(gender != null){
      data['gender'] = this.gender;
    }
    if(dateOfBirth != null){
      dateOfBirth != null ? data['dateOfBirth'] = this.dateOfBirth : null;
    }
    if(phoneNumber != null && phoneNumber!.length > 1){
      data['phoneNumber'] = this.phoneNumber;
    }
    if(email != null && email!.length > 1){
      data['email'] = this.email;
    }
    if(vaccinationCode != null && vaccinationCode!.length > 1){
      data['vaccinationCode'] = this.vaccinationCode;
    }
    if(identityCard != null && identityCard!.length > 1){
      data['identityCard'] = this.identityCard;
    }
    if(address != null && address!.length > 1){
      data['address'] = this.address;
    }
    if(province != null ){
      data['province'] = this.province;
    }
    if(district != null){
      data['district'] = this.district;
    }
    if(ward != null){
      data['ward'] = this.ward;
    }
    if(passportNumber != null && phoneNumber!.length > 1){
      data['passportNumber'] = this.passportNumber;
    }
    if(nation != null){
      data['nation'] = this.nation;
    }
    if(status != null){
      data['status'] = this.status;
    }
    if(id != null){
      data['id'] = this.id;
    }
    return data;
  }
}