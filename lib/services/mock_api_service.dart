import '../models/questionnaire_model.dart';
import '../models/question_model.dart';

class MockApiService {
  static final MockApiService _instance = MockApiService._();
  factory MockApiService() => _instance;
  MockApiService._();

  List<QuestionnaireModel> getQuestionnaires() {
    return [
      QuestionnaireModel(
        id: '1',
        title: 'Online Learning Experience',
        description:
            'Share your experience with our digital learning platform and online classes.',
        questions: [
          QuestionModel(
            id: 'q1',
            text: 'How would you rate the quality of online instruction?',
            options: ['Excellent', 'Good', 'Average', 'Poor'],
          ),
          QuestionModel(
            id: 'q2',
            text: 'Is the learning platform easy to navigate?',
            options: ['Very Easy', 'Easy', 'Difficult', 'Very Difficult'],
          ),
          QuestionModel(
            id: 'q3',
            text: 'How engaging are the virtual classes?',
            options: ['Very Engaging', 'Engaging', 'Boring', 'Very Boring'],
          ),
          QuestionModel(
            id: 'q4',
            text: 'Are the digital resources helpful for your studies?',
            options: ['Very Helpful', 'Helpful', 'Not Helpful', 'Useless'],
          ),
          QuestionModel(
            id: 'q5',
            text: 'Would you recommend online learning to others?',
            options: [
              'Definitely Yes',
              'Probably Yes',
              'Not Sure',
              'No',
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: '2',
        title: 'Teacher Performance Evaluation',
        description: 'Help us recognise and improve teaching excellence across the institution.',
        questions: [
          QuestionModel(
            id: 'q6',
            text: 'How well does the teacher explain concepts?',
            options: ['Very Well', 'Well', 'Needs Improvement', 'Poorly'],
          ),
          QuestionModel(
            id: 'q7',
            text: 'Is the teacher approachable and responsive?',
            options: ['Always', 'Mostly', 'Sometimes', 'Rarely'],
          ),
          QuestionModel(
            id: 'q8',
            text: 'How effective is the feedback on assignments?',
            options: ['Very Effective', 'Effective', 'Minimal', 'Not Given'],
          ),
          QuestionModel(
            id: 'q9',
            text: 'Does the teacher encourage class participation?',
            options: ['Always', 'Often', 'Sometimes', 'Never'],
          ),
          QuestionModel(
            id: 'q10',
            text: 'How would you rate the teacher overall?',
            options: ['Excellent', 'Good', 'Average', 'Poor'],
          ),
        ],
      ),
      QuestionnaireModel(
        id: '3',
        title: 'Curriculum Relevance Assessment',
        description: 'Tell us if the curriculum meets current educational standards and industry needs.',
        questions: [
          QuestionModel(
            id: 'q11',
            text: 'Is the course content up-to-date with industry trends?',
            options: ['Very Current', 'Current', 'Outdated', 'Very Outdated'],
          ),
          QuestionModel(
            id: 'q12',
            text: 'Does the curriculum cover practical skills?',
            options: [
              'Very Well',
              'Adequately',
              'Needs More',
              'Not at All',
            ],
          ),
          QuestionModel(
            id: 'q13',
            text: 'Are the learning objectives clearly defined?',
            options: [
              'Very Clear',
              'Clear',
              'Unclear',
              'Not Defined',
            ],
          ),
          QuestionModel(
            id: 'q14',
            text: 'How relevant is this course to your career goals?',
            options: [
              'Highly Relevant',
              'Relevant',
              'Somewhat',
              'Not Relevant',
            ],
          ),
          QuestionModel(
            id: 'q15',
            text: 'Would you add more practical projects to the curriculum?',
            options: ['Definitely', 'Probably', 'Probably Not', 'No'],
          ),
        ],
      ),
      QuestionnaireModel(
        id: '4',
        title: 'Student Well-being Check',
        description: 'Your mental health matters. Share how you are feeling this semester.',
        questions: [
          QuestionModel(
            id: 'q21',
            text: 'How would you rate your stress level this semester?',
            options: ['Very Low', 'Manageable', 'High', 'Very High'],
          ),
          QuestionModel(
            id: 'q22',
            text: 'Do you have access to adequate student support services?',
            options: ['Yes, Fully', 'Mostly', 'Limited', 'Not at All'],
          ),
          QuestionModel(
            id: 'q23',
            text: 'How balanced is your academic and personal life?',
            options: ['Very Balanced', 'Balanced', 'Slightly Off', 'Very Unbalanced'],
          ),
          QuestionModel(
            id: 'q24',
            text: 'Do you feel a sense of belonging at this institution?',
            options: ['Strongly Feel', 'Feel', 'Neutral', 'Don\'t Feel'],
          ),
          QuestionModel(
            id: 'q25',
            text: 'Would you like more mental health resources on campus?',
            options: [
              'Definitely Yes',
              'Probably Yes',
              'Not Needed',
              'No',
            ],
          ),
        ],
      ),
      QuestionnaireModel(
        id: '5',
        title: 'Campus Facilities Feedback',
        description: 'Help us improve campus facilities with your valuable input.',
        questions: [
          QuestionModel(
            id: 'q16',
            text: 'How would you rate the cleanliness of campus?',
            options: ['Excellent', 'Good', 'Average', 'Poor'],
          ),
          QuestionModel(
            id: 'q17',
            text: 'Are the library facilities adequate for your needs?',
            options: [
              'Very Adequate',
              'Adequate',
              'Inadequate',
              'Very Inadequate',
            ],
          ),
          QuestionModel(
            id: 'q18',
            text: 'How would you rate the cafeteria food quality?',
            options: ['Excellent', 'Good', 'Average', 'Poor'],
          ),
          QuestionModel(
            id: 'q19',
            text: 'Is the campus Wi-Fi reliable?',
            options: ['Always', 'Mostly', 'Sometimes', 'Never'],
          ),
          QuestionModel(
            id: 'q20',
            text: 'How safe do you feel on campus?',
            options: ['Very Safe', 'Safe', 'Unsafe', 'Very Unsafe'],
          ),
        ],
      ),
    ];
  }
}
