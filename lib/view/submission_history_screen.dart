import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../app/app_theme.dart';
import '../models/submission_model.dart';
import '../services/mock_api_service.dart';
import '../view/submission_detail_screen.dart';
import '../widgets/edu_survey_app_bar.dart';

class SubmissionHistoryScreen extends StatelessWidget {
  final List<SubmissionModel> submissions;

  const SubmissionHistoryScreen({super.key, required this.submissions});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    final questionnaires = MockApiService().getQuestionnaires();
    final colorPalette = [
      AppTheme.secondaryFixedDim,
      AppTheme.tertiaryFixedDim,
      AppTheme.errorContainer,
      AppTheme.primaryContainer.withAlpha(51),
      AppTheme.secondaryContainer.withAlpha(77),
    ];
    final iconSet = [
      Icons.menu_book_rounded,
      Icons.amp_stories_rounded,
      Icons.science_rounded,
      Icons.fact_check_rounded,
      Icons.school_rounded,
    ];

    return Scaffold(
      body: Column(
        children: [
          EduSurveyAppBar(
            topPadding: topPad,
            showBack: true,
            title: 'Submission History',
            onBackTap: () => Get.back(),
          ),
          Expanded(
            child:             submissions.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    itemCount: submissions.length,
                    itemBuilder: (context, index) {
                      final submission = submissions[index];
                      final qIndex = questionnaires.indexWhere(
                        (q) => q.id == submission.questionnaireId,
                      );
                      final idx = qIndex >= 0 ? qIndex : index;
                      final bg = colorPalette[idx % colorPalette.length];
                      final icn = iconSet[idx % iconSet.length];

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
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
