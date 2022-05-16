class AvalableTime {
  List<Times>? times;
   String? error;
  AvalableTime({this.times, this.error});

  AvalableTime.fromJson(Map<String, dynamic> json) {
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(new Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? id;
  String? from;
  String? to;
  int? status;
  bool? isAvailable;
  int? numId;
  int? availableQuantity;

  Times(
      {this.id,
        this.from,
        this.to,
        this.status,
        this.isAvailable,
        this.numId,
        this.availableQuantity});

  Times.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    isAvailable = json['isAvailable'];
    numId = json['numId'];
    availableQuantity = json['availableQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from'] = this.from;
    data['to'] = this.to;
    data['status'] = this.status;
    data['isAvailable'] = this.isAvailable;
    data['numId'] = this.numId;
    data['availableQuantity'] = this.availableQuantity;
    return data;
  }
}