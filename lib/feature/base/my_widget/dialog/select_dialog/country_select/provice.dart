class Provinces {
  List<Province>? provinces;

  Provinces({this.provinces});

  Provinces.fromJson(Map<String, dynamic> json) {
    if (json['provinces'] != null) {
      provinces = <Province>[];
      json['provinces'].forEach((v) {
        provinces!.add(new Province.fromJson(v));
      });
    }
  }
}

class Province {
  String? label;
  String? value;
  List<Districts>? districts;

  Province({this.label, this.value, this.districts});

  Province.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts!.add(new Districts.fromJson(v));
      });
    }
  }
}

class Districts {
  String? label;
  String? value;
  List<Wards>? wards;

  Districts({this.label, this.value, this.wards});

  Districts.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards!.add(new Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    if (this.wards != null) {
      data['wards'] = this.wards!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  String? label;
  String? value;

  Wards({this.label, this.value});

  Wards.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}