import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../app/app_theme.dart';
import '../models/submission_model.dart';
import '../controllers/auth_controller.dart';
import '../services/local_storage_service.dart';
import '../services/mock_api_service.dart';

class ProfileController extends GetxController {
  final localStorageService = LocalStorageService();
  final authController = Get.find<AuthController>();
  final mockApi = MockApiService();

  final submissions = <SubmissionModel>[].obs;
  final submissionCount = 0.obs;

  final List<Color> submissionColors = const [
    AppTheme.secondaryFixedDim,
    AppTheme.tertiaryFixedDim,
    AppTheme.errorContainer,
    AppTheme.primaryContainer,
    AppTheme.secondaryContainer,
  ];

  final List<IconData> submissionIcons = const [
    Icons.menu_book_rounded,
    Icons.amp_stories_rounded,
    Icons.science_rounded,
    Icons.fact_check_rounded,
    Icons.school_rounded,
  ];

  int questionnaireIndex(String questionnaireId) {
    final questionnaires = mockApi.getQuestionnaires();
    return questionnaires.indexWhere((q) => q.id == questionnaireId);
  }

  @override
  void onInit() {
    super.onInit();
    loadSubmissions();
  }

  void loadSubmissions() {
    final userId = authController.currentUser?.id;
    if (userId == null) return;
    submissions.value = localStorageService.getSubmissions(userId);
    submissionCount.value = localStorageService.getSubmissionCount(userId);
  }

  void logout() {
    authController.logout();
  }

  String get userInitials => authController.userInitials;
  String get userPhone => authController.currentUser?.phone ?? 'N/A';
  String get userEmail => authController.userEmail;

  String get userNameFromEmail {
    final email = userEmail;
    if (email.isEmpty) {
      final phone = userPhone;
      if (phone.length >= 4) return 'User ${phone.substring(phone.length - 4)}';
      return 'User';
    }
    final localPart = email.split('@').first;
    if (localPart.isEmpty) return 'User';
    final name = localPart
        .replaceAll(RegExp(r'[._\-]'), ' ')
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
    return name;
  }

  String get profilePicture => authController.profilePicture.value;

  Future<void> pickProfilePicture() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery, maxWidth: 512, maxHeight: 512);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    final base64 = base64Encode(bytes);
    await authController.updateProfilePicture(base64);
  }

  Future<void> deleteProfilePicture() async {
    await authController.deleteProfilePicture();
  }
}
