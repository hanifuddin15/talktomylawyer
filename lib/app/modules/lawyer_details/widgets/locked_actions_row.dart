import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LockedActionsRow extends StatelessWidget {
  const LockedActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textStyle = GoogleFonts.outfit(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: isDark ? kDarkTextPrimary : kLightTextPrimary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(Icons.phone_in_talk_outlined, 'Direct Call', textStyle),
          _buildActionItem(Icons.chat_bubble_outline_rounded, 'Message', textStyle),
          _buildActionItem(Icons.group_outlined, 'All Lawyers', textStyle),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, TextStyle style) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: kAccentGold, size: 18),
        const SizedBox(width: 6),
        Text(label, style: style),
      ],
    );
  }
}
