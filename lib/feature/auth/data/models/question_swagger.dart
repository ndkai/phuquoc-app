class QuestionSwagger {
  List<Question>? data;
  bool? succeed;
  String? error;

  QuestionSwagger({this.data, this.succeed, this.error});

  QuestionSwagger.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Question>[];
      json['data'].forEach((v) {
        data!.add( Question.fromJson(v));
      });
    }
    succeed = json['succeed'];
  }

}

class Question {
  String? id;
  String? question;

  Question({this.id, this.question});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    return data;
  }
}