import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF1B5E9F);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD4E4FF);
  static const Color onPrimaryContainer = Color(0xFF003258);

  static const Color secondary = Color(0xFFBF5E00);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFFFDCBC);
  static const Color onSecondaryContainer = Color(0xFF3D1B00);

  static const Color tertiary = Color(0xFF006A58);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF7DF7D8);
  static const Color onTertiaryContainer = Color(0xFF002019);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  static const Color surface = Color(0xFFFFFBF8);
  static const Color onSurface = Color(0xFF1B1B1F);
  static const Color surfaceVariant = Color(0xFFF0EFEA);
  static const Color onSurfaceVariant = Color(0xFF49454F);
  static const Color outline = Color(0xFF7A757F);
  static const Color outlineVariant = Color(0xFFCAC5D0);

  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3EF);
  static const Color surfaceContainer = Color(0xFFF0EDE9);
  static const Color surfaceContainerHigh = Color(0xFFEBE7E3);
  static const Color surfaceContainerHighest = Color(0xFFE5E2DD);
  static const Color surfaceDim = Color(0xFFD5D2CD);
  static const Color surfaceBright = Color(0xFFFFFBF8);

  static const Color inverseSurface = Color(0xFF303034);
  static const Color inverseOnSurface = Color(0xFFF3F0EC);
  static const Color inversePrimary = Color(0xFFA5C8FF);

  static const Color secondaryFixedDim = Color(0xFFFFB77C);
  static const Color tertiaryFixedDim = Color(0xFF60DABC);

  static const Color shadow = Color(0xFF000000);

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x05000000),
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static ThemeData get light {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
      surfaceDim: surfaceDim,
      surfaceBright: surfaceBright,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
      shadow: shadow,
      scrim: Color(0xFF000000),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.interTextTheme(
        ThemeData(brightness: Brightness.light, useMaterial3: true).textTheme,
      ).copyWith(
        displayLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: onSurface,
          letterSpacing: -0.02,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: onSurface,
          letterSpacing: -0.01,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
      scaffoldBackgroundColor: surface,
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: primary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          disabledBackgroundColor: onSurface.withAlpha(20),
          disabledForegroundColor: onSurface.withAlpha(97),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return onPrimary.withAlpha(38);
            }
            if (states.contains(WidgetState.hovered)) {
              return onPrimary.withAlpha(20);
            }
            return null;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return 0;
            return 1;
          }),
          shadowColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) return Colors.transparent;
            return primary.withAlpha(77);
          }),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: secondary,
          disabledForegroundColor: onSurface.withAlpha(97),
          side: WidgetStateBorderSide.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: onSurface.withAlpha(30));
            }
            return const BorderSide(color: secondary, width: 1.5);
          }),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return secondary.withAlpha(38);
            }
            if (states.contains(WidgetState.hovered)) {
              return secondary.withAlpha(20);
            }
            return null;
          }),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          disabledForegroundColor: onSurface.withAlpha(97),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: outlineVariant.withAlpha(102)),
        ),
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurfaceVariant,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: onSurfaceVariant.withAlpha(153),
        ),
        prefixIconColor: outline,
        suffixIconColor: onSurfaceVariant,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: outlineVariant.withAlpha(77)),
        ),
        color: surfaceContainerLowest,
        shadowColor: shadow.withAlpha(26),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: const EdgeInsets.all(16),
        contentTextStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceContainer,
        selectedItemColor: onSecondaryContainer,
        unselectedItemColor: onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return onPrimary;
          return null;
        }),
        side: BorderSide(color: outlineVariant),
      ),
      dividerTheme: DividerThemeData(
        color: outlineVariant.withAlpha(102),
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: secondary,
        linearTrackColor: surfaceContainerHighest,
      ),
    );
  }
}
