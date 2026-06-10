import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<NavItemData> items;

  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: bottomPad + 2),
      height: 64 + bottomPad,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final selected = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: item.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  gradient: selected
                      ? LinearGradient(
                          colors: [
                            AppTheme.primary,
                            AppTheme.primary.withAlpha(210),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: selected
                      ? [
                          BoxShadow(
                            color: AppTheme.primary.withAlpha(51),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: selected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
                      size: 22,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                        color: selected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavItemData {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  NavItemData({required this.icon, required this.label, this.onTap});
}

NavItemData navItem(IconData icon, String label, {VoidCallback? onTap}) {
  return NavItemData(icon: icon, label: label, onTap: onTap);
}
