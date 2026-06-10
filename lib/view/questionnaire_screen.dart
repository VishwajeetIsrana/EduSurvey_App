import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';
import '../controllers/questionnaire_controller.dart';
import '../widgets/edu_survey_app_bar.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuestionnaireController());
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final topPad = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Obx(
        () {
          if (controller.questionnaire == null) {
            return const Center(child: Text('No questions available'));
          }
          final questionnaire = controller.questionnaire!;
          final answers = controller.selectedAnswers;
          final totalQ = questionnaire.questions.length;
          final answeredCount = answers.where((e) => e != null).length;
          final progress = totalQ > 0 ? answeredCount / totalQ : 0.0;
          controller.refreshKey.value;

          return Column(
            children: [
              EduSurveyAppBar(
                topPadding: topPad,
                showBack: true,
                onBackTap: () => Get.back(),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withAlpha(204),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Course: ${questionnaire.title}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$answeredCount of $totalQ Answered',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: AppTheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.secondary),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 100 + bottomPad),
                  itemCount: questionnaire.questions.length,
                  itemBuilder: (context, index) {
                    final question = questionnaire.questions[index];
                    final selected = answers[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${question.text}',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(question.options.length, (optIndex) {
                            final isSelected = selected == optIndex;
                            return GestureDetector(
                              onTap: () => controller.selectAnswer(index, optIndex),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.primary.withAlpha(13)
                                      : AppTheme.surfaceContainerLowest,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.primary
                                        : AppTheme.outlineVariant,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? AppTheme.primary
                                              : AppTheme.outline,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? Center(
                                              child: Container(
                                                width: 14,
                                                height: 14,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppTheme.primary,
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        question.options[optIndex],
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppTheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          controller.refreshKey.value;
          final enabled = controller.allAnswered && !controller.isSubmitting.value;
          return Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomPad),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.shadow.withAlpha(15),
                  blurRadius: 16,
                  offset: const Offset(0, -2),
                ),
                BoxShadow(
                  color: AppTheme.shadow.withAlpha(8),
                  blurRadius: 32,
                  offset: const Offset(0, -8),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                if (controller.isSubmitting.value) {
                  _pulseController.repeat(reverse: true);
                } else {
                  _pulseController.reset();
                }

                final isSubmitting = controller.isSubmitting.value;

                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Material(
                    color: Colors.transparent,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        gradient: isSubmitting
                            ? LinearGradient(
                                colors: [
                                  Color.lerp(AppTheme.primary, AppTheme.primary.withAlpha(180), _pulseAnimation.value)!,
                                  Color.lerp(AppTheme.primary.withAlpha(180), AppTheme.secondary.withAlpha(120), _pulseAnimation.value)!,
                                  Color.lerp(AppTheme.secondary, AppTheme.secondary.withAlpha(120), _pulseAnimation.value)!,
                                ],
                                stops: const [0.0, 0.6, 1.0],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : enabled
                                ? LinearGradient(
                                    colors: [
                                      AppTheme.primary,
                                      AppTheme.primary.withAlpha(200),
                                      AppTheme.secondary.withAlpha(180),
                                    ],
                                    stops: const [0.0, 0.6, 1.0],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  )
                                : null,
                        color: !isSubmitting && !enabled
                            ? AppTheme.onSurface.withAlpha(10)
                            : null,
                        border: !isSubmitting && !enabled
                            ? Border.all(
                                color: AppTheme.outlineVariant.withAlpha(77),
                                width: 1.5,
                              )
                            : null,
                        boxShadow: !isSubmitting && enabled
                            ? [
                                BoxShadow(
                                  color: AppTheme.primary.withAlpha(77),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : isSubmitting
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primary.withAlpha(51),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ]
                                : null,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(9999),
                        onTap: enabled ? () => controller.submit() : null,
                        child: Center(
                          child: isSubmitting
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: AppTheme.onPrimary.withAlpha(230),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      'Submitting\u2026',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.onPrimary.withAlpha(230),
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (!enabled)
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Icon(
                                          Icons.lock_outline_rounded,
                                          size: 18,
                                          color: AppTheme.onSurface.withAlpha(97),
                                        ),
                                      ),
                                    Text(
                                      enabled ? 'Submit Feedback' : 'Answer all questions',
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: enabled
                                            ? AppTheme.onPrimary
                                            : AppTheme.onSurface.withAlpha(97),
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
