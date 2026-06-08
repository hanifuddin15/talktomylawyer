import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Verification timeline step row
class AppTimelineItem extends StatelessWidget {
  const AppTimelineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.status, // 'done', 'active', 'pending'
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final String date;
  final String status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    Color dotColor;
    Widget dotChild;

    switch (status) {
      case 'done':
        dotColor = kSuccess;
        dotChild = const Icon(Icons.check, color: Colors.white, size: 14);
        break;
      case 'active':
        dotColor = kAccentGold;
        dotChild = const SizedBox.shrink();
        break;
      default:
        dotColor = isDark ? kDarkDivider : kLightDivider;
        dotChild = const SizedBox.shrink();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dot + line
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: dotChild,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: status == 'done'
                    ? kSuccess.withValues(alpha: .4)
                    : (isDark ? kDarkDivider : kLightDivider),
              ),
          ],
        ),
        const SizedBox(width: 14),
        // Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: status == 'pending' ? secondaryText : primaryText,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
                ),
                if (!isLast) const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
