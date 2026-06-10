import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import '../controllers/auth_controller.dart';
import '../models/questionnaire_model.dart';
import '../models/submission_model.dart';
import '../services/local_storage_service.dart';
import '../utils/app_snackbar.dart';

class QuestionnaireController extends GetxController {
  final localStorageService = LocalStorageService();
  final authController = Get.find<AuthController>();
  final uuid = const Uuid();

  QuestionnaireModel? questionnaire;
  final selectedAnswers = <int?>[];
  final refreshKey = 0.obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      questionnaire = Get.arguments as QuestionnaireModel;
      selectedAnswers.addAll(List.filled(questionnaire!.questions.length, null));
    }
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    selectedAnswers[questionIndex] = optionIndex;
    refreshKey.value++;
  }

  bool get allAnswered {
    if (questionnaire == null) return false;
    return selectedAnswers.every((e) => e != null);
  }

  Future<void> submit() async {
    if (!allAnswered) {
      AppSnackbar.error('Please answer all questions before submitting');
      return;
    }

    isSubmitting.value = true;

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          AppSnackbar.error('Location permission is required to submit');
          isSubmitting.value = false;
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        AppSnackbar.error(
          'Location permission is permanently denied. Please enable it in your device settings to submit.',
        );
        isSubmitting.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );

      final submission = SubmissionModel(
        id: uuid.v4(),
        userId: authController.currentUser!.id,
        questionnaireId: questionnaire!.id,
        questionnaireName: questionnaire!.title,
        selectedAnswers: selectedAnswers.map((e) => e!).toList(),
        questionTexts: questionnaire!.questions.map((q) => q.text).toList(),
        questionOptions: questionnaire!.questions.map((q) => q.options).toList(),
        submittedAt: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await localStorageService.saveSubmission(submission);

      AppSnackbar.success('Questionnaire submitted successfully!');
      Get.offAllNamed('/home');
    } on TimeoutException {
      AppSnackbar.error('Location request timed out. Make sure GPS is enabled and try again.');
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_LOCATION_SERVICES_DISABLED') {
        AppSnackbar.error('Location services are disabled. Please enable GPS and try again.');
      } else if (e.code == 'ERROR_NETWORK') {
        AppSnackbar.error('Network error. Please check your internet connection and try again.');
      } else {
        AppSnackbar.error('Location error: ${e.message ?? "Please enable GPS and try again."}');
      }
    } on SocketException {
      AppSnackbar.error('Network error. Please check your internet connection and try again.');
    } catch (e) {
      AppSnackbar.error('Something went wrong: ${e.toString()}');
    } finally {
      isSubmitting.value = false;
    }
  }
}
