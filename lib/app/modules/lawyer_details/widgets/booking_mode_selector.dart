import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/book_consultation_controller.dart';

class BookingModeSelector extends GetView<BookConsultationController> {
  const BookingModeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final borderCol = isDark ? kDarkDivider : kLightDivider;

    final modes = [
      {'key': 'online', 'label': 'Video Call', 'icon': Icons.videocam_outlined},
      {'key': 'phone', 'label': 'Phone', 'icon': Icons.phone_outlined},
      {'key': 'in_person', 'label': 'In-person', 'icon': Icons.people_outline_rounded},
    ];

    return Row(
      children: modes.map((mode) {
        final key = mode['key'] as String;
        final label = mode['label'] as String;
        final icon = mode['icon'] as IconData;

        return Expanded(
          child: Obx(() {
            final isSelected = controller.selectedMode.value == key;

            return GestureDetector(
              onTap: () => controller.selectedMode.value = key,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimaryBlue : cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? kPrimaryBlue : borderCol.withValues(alpha: .5),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: isSelected ? Colors.white : kPrimaryBlue,
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }).toList(),
    );
  }
}
