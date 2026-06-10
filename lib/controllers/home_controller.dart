import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../app/app_theme.dart';
import '../controllers/auth_controller.dart';
import '../models/questionnaire_model.dart';
import '../services/mock_api_service.dart';
import '../services/local_storage_service.dart';
import '../utils/app_snackbar.dart';

class HomeController extends GetxController {
  final mockApi = MockApiService();
  final localStorage = LocalStorageService();
  final authController = Get.find<AuthController>();

  final questionnaires = <QuestionnaireModel>[].obs;
  final submittedIds = <String>{}.obs;
  final isLoading = false.obs;
  final locationGranted = false.obs;

  final List<Color> colorPalette = const [
    AppTheme.secondaryFixedDim,
    AppTheme.tertiaryFixedDim,
    AppTheme.errorContainer,
    AppTheme.primaryContainer,
    AppTheme.secondaryContainer,
  ];

  final List<IconData> iconSet = const [
    Icons.menu_book_rounded,
    Icons.amp_stories_rounded,
    Icons.science_rounded,
    Icons.fact_check_rounded,
    Icons.school_rounded,
  ];

  final List<String> statusSet = const [
    'Online \u2022 5 mins',
    'Evaluation',
    'Curriculum',
    'Wellness',
    'Campus',
  ];

  String get userInitials => authController.userInitials;
  String get profilePicture => authController.profilePicture.value;

  @override
  void onInit() {
    super.onInit();
    loadQuestionnaires();
    loadSubmittedIds();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    locationGranted.value = permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  void loadQuestionnaires() {
    isLoading.value = true;
    questionnaires.value = mockApi.getQuestionnaires();
    isLoading.value = false;
  }

  void loadSubmittedIds() {
    final userId = authController.currentUser?.id;
    if (userId == null) return;
    final subs = localStorage.getSubmissions(userId);
    submittedIds.clear();
    submittedIds.addAll(subs.map((s) => s.questionnaireId));
  }

  void openQuestionnaire(QuestionnaireModel questionnaire) {
    if (submittedIds.contains(questionnaire.id)) return;
    if (!locationGranted.value) {
      AppSnackbar.error(
        'Location permission is required. Please grant it to submit questionnaires.',
      );
      checkLocationPermission();
      return;
    }
    Get.toNamed('/questionnaire', arguments: questionnaire)?.then((_) {
      loadSubmittedIds();
    });
  }
}
