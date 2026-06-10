import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:edusurvey/main.dart';
import 'package:edusurvey/controllers/auth_controller.dart';
import 'package:edusurvey/services/local_storage_service.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    await LocalStorageService().init();
    Get.put(AuthController());
    await tester.pumpWidget(const EduSurveyApp(initialRoute: '/login'));
    await tester.pump();
    expect(find.text('EduSurvey'), findsOneWidget);
  });
}
