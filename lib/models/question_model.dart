class QuestionModel {
  String id;
  String text;
  List<String> options;

  QuestionModel({
    required this.id,
    required this.text,
    required this.options,
  });

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'],
      text: map['text'],
      options: List<String>.from(map['options']),
    );
  }
}
