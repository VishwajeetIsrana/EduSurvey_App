import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../services/local_storage_service.dart';
import '../utils/app_snackbar.dart';

class AuthController extends GetxController {
  final localStorageService = LocalStorageService();
  final uuid = const Uuid();

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoggedIn = false.obs;
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  UserModel? currentUser;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  String get userInitials {
    if (currentUser != null && currentUser!.email.isNotEmpty) {
      final local = currentUser!.email.split('@').first;
      if (local.length >= 2) {
        return local.substring(0, 2).toUpperCase();
      }
      return local[0].toUpperCase();
    }
    if (currentUser != null && currentUser!.phone.isNotEmpty) {
      return currentUser!.phone.substring(0, min(2, currentUser!.phone.length)).toUpperCase();
    }
    return '?';
  }

  String get userEmail => currentUser?.email ?? '';
  final profilePicture = ''.obs;

  Future<void> updateProfilePicture(String base64Image) async {
    if (currentUser == null) return;
    currentUser!.profilePicture = base64Image;
    profilePicture.value = base64Image;
    await localStorageService.saveUser(currentUser!);
  }

  Future<void> deleteProfilePicture() async {
    if (currentUser == null) return;
    currentUser!.profilePicture = '';
    profilePicture.value = '';
    await localStorageService.saveUser(currentUser!);
  }

  void checkLoginStatus() {
    final user = localStorageService.getLoggedInUser();
    if (user != null) {
      currentUser = user;
      profilePicture.value = user.profilePicture;
      isLoggedIn.value = true;
    }
  }

  String? validatePhone(String value) {
    if (value.isEmpty) return 'Phone number is required';
    if (value.length < 10) return 'Enter a valid phone number';
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(value)) return 'Enter a valid email';
    return null;
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (validateEmail(email) != null) {
      AppSnackbar.error(validateEmail(email)!);
      return;
    }
    if (validatePhone(phone) != null) {
      AppSnackbar.error(validatePhone(phone)!);
      return;
    }
    if (validatePassword(password) != null) {
      AppSnackbar.error(validatePassword(password)!);
      return;
    }
    if (password != confirmPassword) {
      AppSnackbar.error('Passwords do not match');
      return;
    }

    final existing = localStorageService.getUserByPhone(phone);
    if (existing != null) {
      AppSnackbar.error('An account with this phone number already exists');
      return;
    }

    isLoading.value = true;

    final user = UserModel(
      id: uuid.v4(),
      email: email,
      phone: phone,
      password: password,
    );
    await localStorageService.saveUser(user);

    isLoading.value = false;
    clearFields();
    AppSnackbar.success('Account created successfully');
    Get.offAllNamed('/login');
  }

  Future<void> login() async {
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    if (validatePhone(phone) != null) {
      AppSnackbar.error(validatePhone(phone)!);
      return;
    }
    if (validatePassword(password) != null) {
      AppSnackbar.error(validatePassword(password)!);
      return;
    }

    isLoading.value = true;

    final existingUser = localStorageService.getUserByPhone(phone);
    if (existingUser == null) {
      isLoading.value = false;
      AppSnackbar.error('No account found. Please register first.');
      return;
    }
    if (existingUser.password != password) {
      isLoading.value = false;
      AppSnackbar.error('Invalid phone or password');
      return;
    }
    currentUser = existingUser;
    profilePicture.value = existingUser.profilePicture;
    isLoggedIn.value = true;
    await localStorageService.setLoggedInPhone(phone);
    isLoading.value = false;
    clearFields();
    Get.offAllNamed('/home');
  }

  Future<void> logout() async {
    await localStorageService.clearSession();
    currentUser = null;
    profilePicture.value = '';
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  void clearFields() {
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
