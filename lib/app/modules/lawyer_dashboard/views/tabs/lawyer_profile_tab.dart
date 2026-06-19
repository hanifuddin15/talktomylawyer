import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_avatar.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import 'package:talktomylawyer/app/modules/lawyer_dashboard/controllers/lawyer_profile_controller.dart';

class LawyerProfileTab extends GetView<LawyerProfileController> {
  const LawyerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;

    final name = controller.lawyerModel.name ?? 'Rahman Khan';
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase()
        : 'L';

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'my_profile'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 20),

              // Avatar Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    AppAvatar(
                      initials: initials,
                      radius: 44,
                      showEditButton: true,
                      onEditTap: () {},
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'change_photo'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: kPrimaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Form Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      label: 'full_name'.tr,
                      hint: 'Rahman Khan',
                      prefixIcon: Icons.person_outline,
                      controller: controller.nameController,
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      label: 'hourly_rate_bdt'.tr,
                      hint: '2500',
                      prefixIcon: Icons.attach_money_rounded,
                      keyboardType: TextInputType.number,
                      controller: controller.rateController,
                    ),
                    const SizedBox(height: 14),
                    AppTextField(
                      label: 'professional_bio'.tr,
                      hint: 'Write a short bio...',
                      maxLines: 4,
                      controller: controller.bioController,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'practice_areas'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: controller.allAreas
                          .map(
                            (a) => AppTagChip(
                              label: a.tr,
                              isSelected: controller.selectedAreas.contains(a),
                              onTap: () => controller.toggleArea(a),
                            ),
                          )
                          .toList(),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              AppButton(
                label: 'save_changes'.tr,
                onPressed: () => Get.snackbar(
                  'Profile Updated',
                  'Your changes have been saved',
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
