import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LawyerStatsRow extends StatelessWidget {
  const LawyerStatsRow({
    super.key,
    required this.experience,
    required this.reviewsCount,
    required this.rate,
    required this.isDark,
  });

  final String experience;
  final String reviewsCount;
  final String rate;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, '$experience yrs', 'Experience'),
        const SizedBox(width: 12),
        _buildStatCard(context, '$reviewsCount+', 'Reviews'),
        const SizedBox(width: 12),
        _buildStatCard(context, '৳$rate', 'Rate/hr'),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label) {
    final cardBg = isDark ? kDarkInputFill : kLightInputFill;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dividerColor),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : kLightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: isDark ? kDarkTextSecondary : kLightTextSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
