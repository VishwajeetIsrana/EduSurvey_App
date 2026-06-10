import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/app_theme.dart';
import 'app/routes.dart';
import 'controllers/auth_controller.dart';
import 'services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init();
  final authController = Get.put(AuthController());
  final isLoggedIn = authController.isLoggedIn.value;
  runApp(EduSurveyApp(initialRoute: isLoggedIn ? '/home' : '/login'));
}

class EduSurveyApp extends StatelessWidget {
  final String initialRoute;
  const EduSurveyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EduSurvey',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: initialRoute,
      getPages: AppRoutes.routes,
    );
  }
}
