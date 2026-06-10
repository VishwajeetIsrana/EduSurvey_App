import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';
import '../controllers/home_controller.dart';
import '../widgets/edu_survey_app_bar.dart';
import '../widgets/app_bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final topPad = MediaQuery.of(context).padding.top;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            EduSurveyAppBar(
              topPadding: topPad,
              showAvatar: true,
              avatarText: controller.userInitials,
              avatarImage: controller.profilePicture.isNotEmpty
                  ? controller.profilePicture
                  : null,
              leading: Padding(
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 160,
                        maxHeight: 240,
                      ),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primary,
                              AppTheme.primary.withAlpha(210),
                              AppTheme.secondary.withAlpha(77),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                        padding: EdgeInsets.all(screenWidth > 360 ? 24 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Shape the Future of Learning',
                                style: GoogleFonts.inter(
                                  fontSize: screenWidth > 360 ? 24 : 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.onPrimary,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Flexible(
                              child: Text(
                                'Your feedback drives educational excellence. Explore available questionnaires and share your thoughts today.',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.onPrimary.withAlpha(230),
                                  height: 1.5,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Available Questionnaires',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (controller.questionnaires.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(48),
                        width: double.infinity,
                        child: Text(
                          'No questionnaires available',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    else
                      ...List.generate(controller.questionnaires.length, (
                        index,
                      ) {
                        final q = controller.questionnaires[index];
                        final isSubmitted = controller.submittedIds.contains(
                          q.id,
                        );
                        final c = isSubmitted
                            ? AppTheme.tertiaryContainer.withAlpha(77)
                            : controller.colorPalette[index % controller.colorPalette.length];
                        final icon = controller.iconSet[index % controller.iconSet.length];

                        return Container(
                          margin: EdgeInsets.fromLTRB(
                            16,
                            0,
                            16,
                            index == controller.questionnaires.length - 1
                                ? 100
                                : 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSubmitted
                                ? AppTheme.tertiary.withAlpha(8)
                                : AppTheme.surfaceContainerLowest,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSubmitted
                                  ? AppTheme.tertiary.withAlpha(38)
                                  : AppTheme.outlineVariant.withAlpha(77),
                            ),
                            boxShadow: isSubmitted ? null : AppTheme.cardShadow,
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: isSubmitted
                                  ? null
                                  : () => controller.openQuestionnaire(q),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: c,
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                        ),
                                        child: Icon(
                                          isSubmitted
                                              ? Icons.check_circle_rounded
                                              : icon,
                                          color: isSubmitted
                                              ? AppTheme.tertiary
                                              : AppTheme.onSurface,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: isSubmitted
                                                      ? AppTheme.tertiary
                                                            .withAlpha(26)
                                                      : c.withAlpha(102),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        999,
                                                      ),
                                                ),
                                                    child: Text(
                                                      isSubmitted
                                                          ? 'Submitted'
                                                          : controller.statusSet[index %
                                                                controller.statusSet.length],
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: isSubmitted
                                                        ? AppTheme.tertiary
                                                        : AppTheme
                                                              .onSurfaceVariant,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              q.title,
                                              style: GoogleFonts.inter(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: isSubmitted
                                                    ? AppTheme.onSurface
                                                          .withAlpha(153)
                                                    : AppTheme.primary,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              q.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: isSubmitted
                                                    ? AppTheme.onSurfaceVariant
                                                          .withAlpha(128)
                                                    : AppTheme.onSurfaceVariant,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSubmitted
                                                ? AppTheme.tertiary.withAlpha(
                                                    77,
                                                  )
                                                : AppTheme.primary,
                                          ),
                                        ),
                                        child: Icon(
                                          isSubmitted
                                              ? Icons.check_rounded
                                              : Icons.play_arrow_rounded,
                                          color: isSubmitted
                                              ? AppTheme.tertiary
                                              : AppTheme.primary,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: AppBottomNav(
        selectedIndex: 0,
        items: [
          navItem(Icons.home_rounded, 'Home'),
          navItem(
            Icons.person_rounded,
            'Profile',
            onTap: () => Get.toNamed('/profile'),
          ),
        ],
      ),
    );
  }
}
