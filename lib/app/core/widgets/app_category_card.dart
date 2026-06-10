import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Legal category card shown in home grid
class AppCategoryCard extends StatelessWidget {
  const AppCategoryCard({
    super.key,
    required this.title,
    required this.lawyerCount,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.onTap,
  });

  final String title;
  final int lawyerCount;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primaryText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$lawyerCount lawyers',
              style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}
