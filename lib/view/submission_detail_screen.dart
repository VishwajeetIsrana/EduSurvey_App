import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../app/app_theme.dart';
import '../controllers/submission_detail_controller.dart';
import '../models/submission_model.dart';
import '../widgets/edu_survey_app_bar.dart';

class SubmissionDetailScreen extends StatefulWidget {
  final SubmissionModel submission;
  const SubmissionDetailScreen({super.key, required this.submission});

  @override
  State<SubmissionDetailScreen> createState() => _SubmissionDetailScreenState();
}

class _SubmissionDetailScreenState extends State<SubmissionDetailScreen>
    with SingleTickerProviderStateMixin {
  late final SubmissionDetailController controller;
  late final AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      SubmissionDetailController(submission: widget.submission),
    );
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    if (controller.isLoadingAddress.value) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final submission = widget.submission;

    return Scaffold(
      body: Column(
        children: [
          EduSurveyAppBar(
            topPadding: topPad,
            title: submission.questionnaireName,
            showBack: true,
            showAvatar: false,
            onBackTap: () => Get.back(),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 32 + bottomPad),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppTheme.outlineVariant.withAlpha(77),
                    ),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: AppTheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              DateFormat('MMM dd, yyyy \u2022 hh:mm a')
                                  .format(submission.submittedAt),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: AppTheme.onSurfaceVariant,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: 16,
                            color: AppTheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Obx(() {
                              if (controller.isLoadingAddress.value) {
                                _shimmerController.repeat();
                                return SizedBox(
                                  height: 20,
                                  child: Row(
                                    children: List.generate(3, (i) {
                                      return Padding(
                                        padding: EdgeInsets.only(right: i < 2 ? 6 : 0),
                                        child: _BounceDot(
                                          index: i,
                                          controller: _shimmerController,
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              }
                              if (_shimmerController.isAnimating) {
                                _shimmerController.stop();
                              }
                              return GestureDetector(
                                onTap: controller.hasAddressError
                                    ? () => controller.fetchAddress()
                                    : null,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        controller.address.value,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: controller.hasAddressError
                                              ? AppTheme.error
                                              : AppTheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                    if (controller.hasAddressError)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Icon(
                                          Icons.refresh_rounded,
                                          size: 18,
                                          color: AppTheme.primary,
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ...List.generate(submission.questionTexts.length, (index) {
                  final question = submission.questionTexts[index];
                  final options = submission.questionOptions[index];
                  final selected = submission.selectedAnswers[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.outlineVariant.withAlpha(77),
                      ),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                question,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppTheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(options.length, (optIndex) {
                          final isSelected = optIndex == selected;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppTheme.primary.withAlpha(13)
                                  : AppTheme.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(8),
                              border: isSelected
                                  ? Border.all(
                                      color: AppTheme.primary.withAlpha(51),
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  size: 20,
                                  color: isSelected
                                      ? AppTheme.primary
                                      : AppTheme.outline,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    options[optIndex],
                                    style: GoogleFonts.inter(
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? AppTheme.primary
                                          : AppTheme.onSurface,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BounceDot extends StatelessWidget {
  final int index;
  final AnimationController controller;

  const _BounceDot({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final phase = (controller.value + index * 0.3) % 1.0;
        final scale = 0.5 + 0.5 * (1 - (phase - 0.5).abs() * 2).clamp(0.0, 1.0);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppTheme.primary.withAlpha(179 - (index * 25)),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}