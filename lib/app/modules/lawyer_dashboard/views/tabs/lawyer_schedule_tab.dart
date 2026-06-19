import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';
import 'package:talktomylawyer/app/modules/lawyer_dashboard/controllers/lawyer_schedule_controller.dart';

class LawyerScheduleTab extends GetView<LawyerScheduleController> {
  const LawyerScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'manage_availability'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 20),

              // Available Days
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'available_days'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Wrap(
                      spacing: 8,
                      children: controller.days
                          .asMap()
                          .entries
                          .map(
                            (e) => AppTagChip(
                              label: e.value,
                              isSelected: controller.selectedDays.contains(e.key),
                              onTap: () => controller.toggleDay(e.key),
                            ),
                          )
                          .toList(),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Mini Calendar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'June 2026',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: primaryText,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.chevron_left, color: secondaryText),
                            Icon(Icons.chevron_right, color: secondaryText),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Day headers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
                          .map(
                            (d) => Text(
                              d,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: secondaryText,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    // Day numbers (simplified)
                    Obx(() => GridView.count(
                      crossAxisCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.1,
                      children: List.generate(30, (i) {
                        final day = i + 1;
                        final isSelected = controller.selectedCalDay.value == day;
                        return GestureDetector(
                          onTap: () => controller.selectedCalDay.value = day,
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? kPrimaryBlue
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '$day',
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isSelected ? Colors.white : primaryText,
                              ),
                            ),
                          ),
                        );
                      }),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Time Slots
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'time_slots'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.timeSlots
                          .asMap()
                          .entries
                          .map(
                            (e) => AppTagChip(
                              label: e.value,
                              isSelected: controller.selectedSlots.contains(e.key),
                              onTap: () => controller.toggleSlot(e.key),
                            ),
                          )
                          .toList(),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              AppButton(
                label: 'save_schedule'.tr,
                onPressed: () => Get.snackbar(
                  'Schedule Saved',
                  'Your availability has been updated',
                  backgroundColor: kSuccess,
                  colorText: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
