class SubmissionModel {
  String id;
  String userId;
  String questionnaireId;
  String questionnaireName;
  List<int> selectedAnswers;
  List<String> questionTexts;
  List<List<String>> questionOptions;
  DateTime submittedAt;
  double latitude;
  double longitude;

  SubmissionModel({
    required this.id,
    required this.userId,
    required this.questionnaireId,
    required this.questionnaireName,
    required this.selectedAnswers,
    required this.questionTexts,
    required this.questionOptions,
    required this.submittedAt,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'questionnaireId': questionnaireId,
      'questionnaireName': questionnaireName,
      'selectedAnswers': selectedAnswers,
      'questionTexts': questionTexts,
      'questionOptions': questionOptions,
      'submittedAt': submittedAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory SubmissionModel.fromMap(Map<String, dynamic> map) {
    return SubmissionModel(
      id: map['id'],
      userId: map['userId'],
      questionnaireId: map['questionnaireId'],
      questionnaireName: map['questionnaireName'],
      selectedAnswers: List<int>.from(map['selectedAnswers']),
      questionTexts: List<String>.from(map['questionTexts']),
      questionOptions: (map['questionOptions'] as List)
          .map((e) => List<String>.from(e))
          .toList(),
      submittedAt: DateTime.parse(map['submittedAt']),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
