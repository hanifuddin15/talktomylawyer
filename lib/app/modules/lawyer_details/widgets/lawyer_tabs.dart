import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class LawyerTabs extends StatelessWidget {
  const LawyerTabs({
    super.key,
    required this.activeIndex,
    required this.onTabChanged,
    required this.dividerColor,
  });

  final int activeIndex;
  final ValueChanged<int> onTabChanged;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: dividerColor, width: 1.5),
        ),
      ),
      child: Row(
        children: [
          _buildTabItem('About', 0),
          _buildTabItem('Reviews', 1),
          _buildTabItem('Availability', 2),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = activeIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? kPrimaryBlue : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? kPrimaryBlue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
