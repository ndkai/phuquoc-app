class AvailableDay {
  List<String>? dates;
  String? error;
  AvailableDay({this.dates, this.error});

  AvailableDay.fromJson(Map<String, dynamic> json) {
    dates = json['dates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dates'] = this.dates;
    return data;
  }
}