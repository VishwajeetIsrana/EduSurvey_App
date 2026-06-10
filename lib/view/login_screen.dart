import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 40,
                    color: AppTheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'EduSurvey',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.02,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Empowering education through insights.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_rounded),
                    hintText: '+1 (555) 000-0000',
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_rounded),
                      hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.isLoading.value ? null : () => controller.login(),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppTheme.onPrimary,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Flexible(child: Divider(color: AppTheme.outlineVariant)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Don't have an account?",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const Flexible(child: Divider(color: AppTheme.outlineVariant)),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
