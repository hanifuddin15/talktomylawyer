import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class StatusBanner extends StatelessWidget {
  final String status;

  const StatusBanner({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final String displayStatus = status.toLowerCase();
    
    Color cardBgColor;
    Color contentColor;
    IconData icon;
    String title;
    String description;

    if (displayStatus == 'cancelled' || displayStatus == 'rejected') {
      cardBgColor = kError.withValues(alpha: 0.1);
      contentColor = kError;
      icon = Icons.cancel_outlined;
      title = 'Cancelled / Declined';
      description = 'This consultation was cancelled by the user or declined by the lawyer.';
    } else if (displayStatus == 'accepted' || displayStatus == 'upcoming') {
      cardBgColor = kPrimaryBlue.withValues(alpha: 0.1);
      contentColor = kPrimaryBlue;
      icon = Icons.check_circle_outline_rounded;
      title = 'Confirmed Consultation';
      description = 'Your consultation has been confirmed. You can join at the scheduled time.';
    } else if (displayStatus == 'completed') {
      cardBgColor = kSuccess.withValues(alpha: 0.1);
      contentColor = kSuccess;
      icon = Icons.check_circle_outline_rounded;
      title = 'Consultation Completed';
      description = 'This consultation has been completed. Thank you for using our service.';
    } else {
      // pending
      cardBgColor = kPending.withValues(alpha: 0.1);
      contentColor = kPending;
      icon = Icons.access_time_rounded;
      title = 'Pending Approval';
      description = 'Waiting for the lawyer to confirm your consultation slot.';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36,
            color: contentColor,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: contentColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: contentColor.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
