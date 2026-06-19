import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/book_consultation_controller.dart';

class BookingTimeSelector extends GetView<BookConsultationController> {
  const BookingTimeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final borderCol = isDark ? kDarkDivider : kLightDivider;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.4,
      ),
      itemCount: controller.timeSlots.length,
      itemBuilder: (context, index) {
        final slot = controller.timeSlots[index];

        return Obx(() {
          final isSelected = controller.selectedTimeIndex.value == index;

          return GestureDetector(
            onTap: () => controller.selectedTimeIndex.value = index,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryBlue : cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? kPrimaryBlue : borderCol.withValues(alpha: .5),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                slot,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : primaryText,
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
