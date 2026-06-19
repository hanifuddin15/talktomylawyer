import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/book_consultation_controller.dart';

class BookingDateSelector extends GetView<BookConsultationController> {
  const BookingDateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final borderCol = isDark ? kDarkDivider : kLightDivider;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.availableDates.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = controller.availableDates[index];
          final String dayName = DateFormat('EEE').format(date).toUpperCase();
          final String dayNum = DateFormat('d').format(date);

          return Obx(() {
            final isSelected = controller.selectedDateIndex.value == index;

            return GestureDetector(
              onTap: () => controller.selectedDateIndex.value = index,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 66,
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryBlue : cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? kPrimaryBlue : borderCol.withValues(alpha: .5),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dayName,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white.withValues(alpha: .85)
                            : secondaryText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dayNum,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: isSelected ? Colors.white : primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
