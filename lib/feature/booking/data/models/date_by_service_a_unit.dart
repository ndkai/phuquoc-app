class DateByUnitAServiceSwagger {
  List<DateByServiceAndUnit>? dateByServiceAndUnit;
  String? error;

  DateByUnitAServiceSwagger({this.dateByServiceAndUnit, this.error});

  DateByUnitAServiceSwagger.fromJson(Map<String, dynamic> json) {
    if (json['dateByServiceAndUnit'] != null) {
      dateByServiceAndUnit = <DateByServiceAndUnit>[];
      json['dateByServiceAndUnit'].forEach((v) {
        dateByServiceAndUnit!.add(new DateByServiceAndUnit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateByServiceAndUnit != null) {
      data['dateByServiceAndUnit'] =
          this.dateByServiceAndUnit!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateByServiceAndUnit {
  String? id;
  String? date;
  String? time;
  int? status;
  Schedules? schedules;
  Doctor? doctor;
  Doctor? room;
  String? hospitalName;
  List<Service>? service;

  DateByServiceAndUnit(
      {this.id,
        this.date,
        this.time,
        this.status,
        this.schedules,
        this.doctor,
        this.room,
        this.hospitalName,
        this.service});

  DateByServiceAndUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    schedules = json['schedules'] != null
        ? new Schedules.fromJson(json['schedules'])
        : null;
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? new Doctor.fromJson(json['room']) : null;
    hospitalName = json['hospitalName'];
    if (json['service'] != null) {
      service = <Service>[];
      json['service'].forEach((v) {
        service!.add(new Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    data['hospitalName'] = this.hospitalName;
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Service {
  String? id;
  String? description;

  Service({this.id, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}

class Schedules {
  String? from;
  String? to;

  Schedules({this.from, this.to});

  Schedules.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}

class Doctor {
  String? id;
  String? description;

  Doctor({this.id, this.description});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}