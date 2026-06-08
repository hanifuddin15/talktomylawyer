import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Selectable tag/filter chip
class AppTagChip extends StatelessWidget {
  const AppTagChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.small = false,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final selectedBg = kPrimaryBlue;
    final unselectedBg = isDark ? kDarkInputFill : kLightInputFill;
    final selectedText = Colors.white;
    final unselectedText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final border = isSelected
        ? BorderSide.none
        : BorderSide(color: isDark ? kDarkDivider : kLightDivider, width: 1);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: small ? 12 : 16,
          vertical: small ? 6 : 9,
        ),
        decoration: BoxDecoration(
          color: isSelected ? selectedBg : unselectedBg,
          borderRadius: BorderRadius.circular(50),
          border: Border.fromBorderSide(border),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: small ? 12 : 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? selectedText : unselectedText,
          ),
        ),
      ),
    );
  }
}
