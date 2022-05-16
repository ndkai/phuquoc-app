class HospitalSwagger {
  List<HospitalData>? data;
  String? error;
  HospitalSwagger({this.data, this.error});

  HospitalSwagger.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HospitalData>[];
      json['data'].forEach((v) {
        data!.add(new HospitalData.fromJson(v));
      });
    }
  }
}

class HospitalData {
  String? dateCreated;
  String? dateUpdated;
  String? logo;
  bool? isDeleted;
  bool? isTestingFacility;
  bool? isPrEPFacility;
  bool? isARTFacility;
  Null parentId;
  String? id;
  String? username;
  String? name;
  String? unitTypeId;
  String? address;
  String? province;
  String? district;
  String? ward;
  String? website;
  String? phone;
  String? email;
  String? introduction;


  HospitalData(
      {this.dateCreated,
      this.dateUpdated,
      this.logo,
      this.isDeleted,
      this.isTestingFacility,
      this.isPrEPFacility,
      this.isARTFacility,
      this.parentId,
      this.id,
      this.username,
      this.name,
      this.unitTypeId,
      this.address,
      this.province,
      this.district,
      this.ward,
      this.website,
      this.phone,
      this.email,
      this.introduction});

  HospitalData.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    logo = json['logo'];
    isDeleted = json['isDeleted'];
    isTestingFacility = json['isTestingFacility'];
    isPrEPFacility = json['isPrEPFacility'];
    isARTFacility = json['isARTFacility'];
    // parentId = json['parentId'];
    id = json['id'];
    username = json['username'];
    name = json['name'];
    unitTypeId = json['unitTypeId'];
    address = json['address'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    website = json['website'];
    phone = json['phone'];
    email = json['email'];
    introduction = json['introduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateCreated'] = this.dateCreated;
    data['dateUpdated'] = this.dateUpdated;
    data['logo'] = this.logo;
    data['isDeleted'] = this.isDeleted;
    data['isTestingFacility'] = this.isTestingFacility;
    data['isPrEPFacility'] = this.isPrEPFacility;
    data['isARTFacility'] = this.isARTFacility;
    data['parentId'] = this.parentId;
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['unitTypeId'] = this.unitTypeId;
    data['address'] = this.address;
    data['province'] = this.province;
    data['district'] = this.district;
    data['ward'] = this.ward;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['introduction'] = this.introduction;
    return data;
  }
}
