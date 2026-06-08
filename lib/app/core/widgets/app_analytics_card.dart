import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Dashboard analytics stat card (icon + number + label + growth)
class AppAnalyticsCard extends StatelessWidget {
  const AppAnalyticsCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.growth,
    this.isPositive = true,
  });

  final IconData icon;
  final String value;
  final String label;
  final String growth;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final growthColor = isPositive ? kSuccess : kError;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: kPrimaryBlue.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kPrimaryBlue, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 12, color: secondaryText),
          ),
          const SizedBox(height: 4),
          Text(
            growth,
            style: GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: growthColor,
            ),
          ),
        ],
      ),
    );
  }
}
