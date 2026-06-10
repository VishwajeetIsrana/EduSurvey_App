import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';

class EduSurveyAppBar extends StatelessWidget {
  final String title;
  final bool showBack;
  final bool showAvatar;
  final String? avatarText;
  final String? avatarImage;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onBackTap;
  final double topPadding;

  const EduSurveyAppBar({
    super.key,
    this.title = 'EduSurvey',
    this.showBack = false,
    this.showAvatar = false,
    this.avatarText,
    this.avatarImage,
    this.leading,
    this.trailing,
    this.onBackTap,
    this.topPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: topPadding),
      color: AppTheme.surface,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: Border(
            bottom: BorderSide(
              color: AppTheme.outlineVariant.withAlpha(38),
            ),
          ),
        ),
        child: Row(
          children: [
            leading ??
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(999),
                onTap: onBackTap ?? () {},
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    showBack ? Icons.arrow_back_rounded : Icons.menu_rounded,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: title == 'EduSurvey' ? 22 : 18,
                  fontWeight: FontWeight.w600,
                  color: title == 'EduSurvey' ? AppTheme.primary : AppTheme.onSurface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) trailing!,
            if (showAvatar)
              SizedBox(
                width: 40,
                height: 40,
                child: Stack(
                  children: [
                    ClipOval(
                      child: avatarImage != null && avatarImage!.isNotEmpty
                          ? Image.memory(
                              base64Decode(avatarImage!),
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            )
                          : Container(
                              width: 40,
                              height: 40,
                              color: AppTheme.secondaryContainer,
                              child: Center(
                                child: Text(
                                  avatarText ?? '?',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.onSecondaryContainer,
                                    fontWeight: FontWeight.w600,
                                    fontSize: avatarText != null && avatarText!.length > 1 ? 14 : 16,
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
                              color: AppTheme.primaryContainer.withAlpha(51),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
