import 'package:phuquoc/feature/booking/data/models/date_by_service_a_unit.dart';

class BookingRequest {
  MInterval? interval;
  Unit? unit;
  Doctor? doctor;
  Room? room;
  Room? service;
  Customer? customer;
  List<Contacts>? contacts;
  String? note;
  String? date;
  String? bookedByUser;
  ExitInformation? exitInformation;
  ConsultingContent? consultingContent;
  TestingContent? testingContent;

  BookingRequest(
      {this.interval,
        this.unit,
        this.doctor,
        this.room,
        this.service,
        this.customer,
        this.contacts,
        this.note,
        this.date,
        this.bookedByUser,
        this.exitInformation,
        this.consultingContent,
        this.testingContent});

  BookingRequest.fromJson(Map<String, dynamic> json) {
    interval = json['interval'] != null
        ? new MInterval.fromJson(json['interval'])
        : null;
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
    service =
    json['service'] != null ? new Room.fromJson(json['service']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
    note = json['note'];
    date = json['date'];
    bookedByUser = json['bookedByUser'];
    exitInformation = json['exitInformation'] != null
        ? new ExitInformation.fromJson(json['exitInformation'])
        : null;
    consultingContent = json['consultingContent'] != null
        ? new ConsultingContent.fromJson(json['consultingContent'])
        : null;
    testingContent = json['testingContent'] != null
        ? new TestingContent.fromJson(json['testingContent'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.interval != null) {
      data['interval'] = this.interval!.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    data['note'] = this.note;
    data['date'] = this.date;
    data['bookedByUser'] = this.bookedByUser;
    if (this.exitInformation != null) {
      data['exitInformation'] = this.exitInformation!.toJson();
    }
    if (this.consultingContent != null) {
      data['consultingContent'] = this.consultingContent!.toJson();
    }
    if (this.testingContent != null) {
      data['testingContent'] = this.testingContent!.toJson();
    }
    return data;
  }
}

class MInterval {
  String? id;
  String? from;
  String? to;
  int? numId;

  MInterval({this.id, this.from, this.to, this.numId});

  MInterval.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    numId = json['numId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['numId'] = this.numId;
    return data;
  }
}

class Unit {
  String? id;
  String? name;
  String? information;
  String? address;
  String? username;
  String? provinceCode;
  String? districtCode;
  String? wardCode;

  Unit(
      {this.id,
        this.name,
        this.information,
        this.address,
        this.username,
        this.provinceCode,
        this.districtCode,
        this.wardCode});

  Unit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    information = json['information'];
    address = json['address'];
    username = json['username'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    wardCode = json['wardCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['information'] = this.information;
    data['address'] = this.address;
    data['username'] = this.username;
    data['provinceCode'] = this.provinceCode;
    data['districtCode'] = this.districtCode;
    data['wardCode'] = this.wardCode;
    return data;
  }
}



class Room {
  String? id;
  String? name;

  Room({this.id, this.name});

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Customer {
  String? id;
  String? fullname;
  String? username;
  String? phone;
  String? email;
  String? address;
  String? birthDate;
  bool? gender;
  String? provinceCode;
  String? districtCode;
  String? wardCode;
  String? ic;
  String? nation;
  String? passportNumber;
  String? vaccinationCode;
  String? externalId;

  Customer(
      {this.id,
        this.fullname,
        this.username,
        this.phone,
        this.email,
        this.address,
        this.birthDate,
        this.gender,
        this.provinceCode,
        this.districtCode,
        this.wardCode,
        this.ic,
        this.nation,
        this.passportNumber,
        this.vaccinationCode,
        this.externalId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    birthDate = json['birthDate'];
    gender = json['gender'];
    provinceCode = json['provinceCode'];
    districtCode = json['districtCode'];
    wardCode = json['wardCode'];
    ic = json['ic'];
    nation = json['nation'];
    passportNumber = json['passportNumber'];
    vaccinationCode = json['vaccinationCode'];
    externalId = json['externalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if( this.gender!= null){
      data['gender'] = this.gender;
    }
    if( this.fullname!= null){
      data['fullname'] = this.fullname;
    }
    if( this.username!= null){
      data['username'] = this.username;
    }
    if( this.phone!= null){
      data['phone'] = this.phone;
    }
    if( this.email!= null){
      data['email'] = this.email;
    }
    if( this.address!= null){
      data['address'] = this.address;
    }

    if( this.birthDate!= null){
      data['birthDate'] = this.birthDate;
    }
    return data;
  }
}

class Contacts {
  String? fullname;
  String? phone;
  String? relationship;

  Contacts({this.fullname, this.phone, this.relationship});

  Contacts.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    phone = json['phone'];
    relationship = json['relationship'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['phone'] = this.phone;
    data['relationship'] = this.relationship;
    return data;
  }
}

class ExitInformation {
  String? destination;
  String? exitingDate;
  String? entryingDate;

  ExitInformation({this.destination = "string", this.exitingDate, this.entryingDate });

  ExitInformation.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    exitingDate = json['exitingDate'];
    entryingDate = json['entryingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if( this.destination!= null){
      data['destination'] = this.destination;
    }
    if( this.exitingDate!= null){
      data['exitingDate'] = this.exitingDate;
    }
    if( this.entryingDate!= null){
      data['entryingDate'] = this.entryingDate;
    }



    return data;
  }
}

class ConsultingContent {
  String? type;
  String? content;
  String? result;
  String? note;

  ConsultingContent({this.type, this.content, this.result, this.note});

  ConsultingContent.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    content = json['content'];
    result = json['result'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['content'] = this.content;
    data['result'] = this.result;
    data['note'] = this.note;
    return data;
  }
}

class TestingContent {
  String? typeTesting;
  int? quantity;
  bool? isReceived;
  bool? isPickUpAtTheFacility;
  String? receivingAddress;
  String? provinceCode;
  String? districtCode;
  String? wardCode;
  String? receiver;
  String? recipientPhoneNumber;
  String? content;
  String? result;
  String? note;

  TestingContent(
      {this.typeTesting = "",
        this.quantity = 1,
        this.isReceived = false,
        this.isPickUpAtTheFacility = false,
        this.receivingAddress = "",
        this.provinceCode = "",
        this.districtCode = "",
        this.wardCode = "",
        this.receiver = "",
        this.recipientPhoneNumber = "",
        this.content = "",
        this.result = "",
        this.note = ""});

  TestingContent.fromJson(Map<String, dynamic> json) {
    if( this.typeTesting!= null){
      typeTesting = json['typeTesting'];
    }
    if( this.quantity!= null){
      quantity = json['quantity'];
    }
    if( this.isReceived!= null){
      isReceived = json['isReceived'];
    }
    if( this.isPickUpAtTheFacility!= null){
      isPickUpAtTheFacility = json['isPickUpAtTheFacility'];
    }
    if( this.receivingAddress!= null){
      receivingAddress = json['receivingAddress'];
    }
    if( this.provinceCode!= null){
      provinceCode = json['provinceCode'];
    }
    if( this.districtCode!= null){
      districtCode = json['districtCode'];
    }
    if( this.wardCode!= null){
      wardCode = json['wardCode'];
    }
    if( this.receiver!= null){
      receiver = json['receiver'];
    }

    if( this.note!= null){
      note = json['note'];
    }

    if( this.result!= null){
      result = json['result'];
    }

    if( this.recipientPhoneNumber!= null){
      recipientPhoneNumber = json['recipientPhoneNumber'];
    }

    if( this.content!= null){
      content = json['content'];
    }






  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeTesting'] = this.typeTesting;
    data['quantity'] = this.quantity;
    data['isReceived'] = this.isReceived;
    data['isPickUpAtTheFacility'] = this.isPickUpAtTheFacility;
    data['receivingAddress'] = this.receivingAddress;
    data['provinceCode'] = this.provinceCode;
    data['districtCode'] = this.districtCode;
    data['wardCode'] = this.wardCode;
    data['receiver'] = this.receiver;
    data['recipientPhoneNumber'] = this.recipientPhoneNumber;
    data['content'] = this.content;
    data['result'] = this.result;
    data['note'] = this.note;
    return data;
  }
}