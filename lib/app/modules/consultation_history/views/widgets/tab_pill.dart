import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class TabPill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const TabPill({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? kPrimaryBlue 
              : (isDark ? kDarkCard : Colors.white),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected 
                ? Colors.transparent 
                : (isDark ? kDarkDivider : Colors.grey.shade300),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected 
                ? Colors.white 
                : (isDark ? kDarkTextSecondary : kLightTextSecondary),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
