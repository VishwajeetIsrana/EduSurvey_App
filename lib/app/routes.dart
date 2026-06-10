import 'package:get/get.dart';
import '../view/login_screen.dart';
import '../view/register_screen.dart';
import '../view/home_screen.dart';
import '../view/questionnaire_screen.dart';
import '../view/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String questionnaire = '/questionnaire';
  static const String profile = '/profile';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: questionnaire, page: () => const QuestionnaireScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
  ];
}
