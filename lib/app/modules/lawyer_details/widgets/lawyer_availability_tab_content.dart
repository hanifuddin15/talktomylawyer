import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LawyerAvailabilityTabContent extends StatelessWidget {
  const LawyerAvailabilityTabContent({
    super.key,
    required this.primaryText,
    required this.secondaryText,
    required this.cardColor,
  });

  final Color primaryText;
  final Color secondaryText;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Consultation Schedule',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 12),
        ...days.map(
          (day) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                    fontSize: 13.5,
                  ),
                ),
                Text(
                  '04:00 PM - 07:00 PM',
                  style: GoogleFonts.outfit(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
