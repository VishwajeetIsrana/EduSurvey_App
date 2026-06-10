import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../app/app_theme.dart';
import '../controllers/profile_controller.dart';
import '../view/submission_detail_screen.dart';
import '../view/submission_history_screen.dart';
import '../widgets/edu_survey_app_bar.dart';
import '../widgets/app_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final topPad = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            EduSurveyAppBar(
              topPadding: topPad,
              showBack: true,
              showAvatar: true,
              avatarText: controller.userInitials,
              avatarImage: controller.profilePicture.isNotEmpty ? controller.profilePicture : null,
              onBackTap: () => Get.back(),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.primary.withAlpha(51),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipOval(
                                child: controller.profilePicture.isNotEmpty
                                    ? Image.memory(
                                        base64Decode(controller.profilePicture),
                                        fit: BoxFit.cover,
                                        width: 96,
                                        height: 96,
                                      )
                                    : Container(
                                        width: 96,
                                        height: 96,
                                        color: AppTheme.secondaryContainer,
                                        child: Center(
                                          child: Text(
                                            controller.userInitials,
                                            style: GoogleFonts.inter(
                                              fontSize: 36,
                                              fontWeight: FontWeight.w700,
                                              color: AppTheme.onSecondaryContainer,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned.fill(
                                child: IgnorePointer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppTheme.surfaceContainerLowest,
                                        width: 4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _showPictureOptions(context, controller),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit_rounded,
                                color: AppTheme.onPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.userNameFromEmail,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.outlineVariant.withAlpha(77),
                              ),
                              boxShadow: AppTheme.cardShadow,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryContainer.withAlpha(26),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: const Icon(
                                    Icons.mail_rounded,
                                    color: AppTheme.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email Address',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.onSurfaceVariant,
                                        ),
                                      ),
                                      Text(
                                        controller.userEmail.isNotEmpty
                                            ? controller.userEmail
                                            : controller.userPhone,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.onSurface,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppTheme.outlineVariant.withAlpha(77),
                              ),
                              boxShadow: AppTheme.cardShadow,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryContainer.withAlpha(26),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: const Icon(
                                    Icons.call_rounded,
                                    color: AppTheme.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.onSurfaceVariant,
                                        ),
                                      ),
                                      Text(
                                        controller.userPhone,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.onSurface,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'QUESTIONNAIRES FILLED',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.onPrimaryContainer.withAlpha(204),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${controller.submissionCount}',
                                  style: GoogleFonts.inter(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.onPrimaryContainer,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  'total submissions',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.onPrimaryContainer.withAlpha(230),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.fact_check_rounded,
                            size: screenWidth * 0.3 > 120 ? 120 : screenWidth * 0.3,
                            color: AppTheme.onPrimaryContainer.withAlpha(26),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submission History',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        if (controller.submissions.length > 3)
                          TextButton(
                            onPressed: () => Get.to(
                              () => SubmissionHistoryScreen(
                                submissions: controller.submissions,
                              ),
                            ),
                            child: Text(
                              'View All',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (controller.submissions.isEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppTheme.outlineVariant.withAlpha(51)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withAlpha(13),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.assignment_outlined,
                                size: 48,
                                color: AppTheme.primary.withAlpha(153),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No submissions yet',
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Complete a questionnaire to see it here',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppTheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ..._buildSubmissionList(controller),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: controller.logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.errorContainer,
                          foregroundColor: AppTheme.onErrorContainer,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout_rounded, size: 20),
                            const SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 1,
        items: [
          navItem(Icons.home_rounded, 'Home', onTap: () => Get.offAllNamed('/home')),
          navItem(Icons.person_rounded, 'Profile'),
        ],
      ),
    );
  }

  void _showPictureOptions(BuildContext context, ProfileController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Profile Picture',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: 24),
            _optionRow(
              icon: Icons.photo_library_rounded,
              label: 'Choose from Gallery',
              onTap: () {
                Get.back();
                controller.pickProfilePicture();
              },
            ),
            if (controller.profilePicture.isNotEmpty) ...[
              const SizedBox(height: 4),
              _optionRow(
                icon: Icons.delete_outline_rounded,
                label: 'Remove Picture',
                onTap: () {
                  Get.back();
                  controller.deleteProfilePicture();
                },
                isDestructive: true,
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _optionRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDestructive
                ? AppTheme.errorContainer.withAlpha(77)
                : AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isDestructive ? AppTheme.error : AppTheme.primary,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? AppTheme.error : AppTheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSubmissionList(ProfileController controller) {
    final displayList = controller.submissions.take(3).toList();

    return List.generate(displayList.length, (index) {
      final submission = displayList[index];
      final qIndex = controller.questionnaireIndex(submission.questionnaireId);
      final idx = qIndex >= 0 ? qIndex : index;
      final bg = controller.submissionColors[idx % controller.submissionColors.length];
      final icn = controller.submissionIcons[idx % controller.submissionIcons.length];

      return Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Get.to(
              () => SubmissionDetailScreen(submission: submission),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icn, color: AppTheme.onSurface, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          submission.questionnaireName,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurface,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DateFormat('MMM dd, yyyy \u2022 hh:mm a')
                              .format(submission.submittedAt),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
