import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String displayStatus = status.toLowerCase();

    if (displayStatus == 'cancelled' || displayStatus == 'rejected') {
      bgColor = kError.withValues(alpha: 0.12);
      textColor = kError;
      displayStatus = 'cancelled';
    } else if (displayStatus == 'accepted' || displayStatus == 'upcoming') {
      bgColor = kPrimaryBlue.withValues(alpha: 0.12);
      textColor = kPrimaryBlue;
      displayStatus = 'upcoming';
    } else if (displayStatus == 'completed') {
      bgColor = kSuccess.withValues(alpha: 0.12);
      textColor = kSuccess;
      displayStatus = 'completed';
    } else {
      // pending or default
      bgColor = kPending.withValues(alpha: 0.12);
      textColor = kPending;
      displayStatus = 'pending';
    }

    // Capitalize status string
    final String label = displayStatus.substring(0, 1).toUpperCase() + displayStatus.substring(1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
