import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';

class AppSnackbar {
  AppSnackbar._();

  static void error(String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.error.withAlpha(38),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.error_outline_rounded, color: AppTheme.error, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Error',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      messageText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.surfaceContainerLowest,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: AppTheme.shadow.withAlpha(30),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: AppTheme.shadow.withAlpha(15),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
      ],
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void success(String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      titleText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.tertiary.withAlpha(38),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_circle_outline_rounded, color: AppTheme.tertiary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Success',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      messageText: const SizedBox.shrink(),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.surfaceContainerLowest,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      boxShadows: [
        BoxShadow(
          color: AppTheme.shadow.withAlpha(30),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
        BoxShadow(
          color: AppTheme.shadow.withAlpha(15),
          blurRadius: 32,
          offset: const Offset(0, 8),
        ),
      ],
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
