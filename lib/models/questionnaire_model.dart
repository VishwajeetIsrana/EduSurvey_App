import 'question_model.dart';

class QuestionnaireModel {
  String id;
  String title;
  String description;
  List<QuestionModel> questions;

  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaireModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      questions: (map['questions'] as List)
          .map((q) => QuestionModel.fromMap(q))
          .toList(),
    );
  }
}
