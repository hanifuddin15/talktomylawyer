import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_avatar.dart';
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
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: isDark ? kDarkBg : Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: const SizedBox(), // No back button on a dashboard tab
        title: Obx(() {
          return Text(
            controller.isEditing.value ? 'Edit Profile' : 'My Profile',
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          );
        }),
        actions: [
          Obx(() {
            if (controller.isEditing.value) {
              return TextButton(
                onPressed: () => controller.toggleEdit(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.outfit(
                    color: kError,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }
            return const SizedBox();
          }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: dividerColor,
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          final lawyer = controller.lawyerData.value;
          final name = lawyer?.name ?? 'Rahman Khan';
          final email = lawyer?.email ?? 'lawyer@app.com';
          final initials = controller.initials;
          final isEditing = controller.isEditing.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: dividerColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          AppAvatar(
                            initials: initials,
                            radius: 44,
                            showEditButton: isEditing,
                            onEditTap: () {
                              Get.snackbar(
                                'Change Photo',
                                'Photo uploads will be supported soon!',
                                backgroundColor: kPrimaryBlue,
                                colorText: Colors.white,
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        isEditing ? 'Tap camera to change photo' : 'change_photo'.tr,
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
                    border: Border.all(color: dividerColor, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: 'full_name'.tr,
                        hint: 'Rahman Khan',
                        prefixIcon: Icons.person_outline,
                        controller: controller.nameController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Email Address',
                        hint: 'lawyer@example.com',
                        prefixIcon: Icons.email_outlined,
                        controller: TextEditingController(text: email),
                        enabled: false,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Phone Number',
                        hint: '+880 1800-000000',
                        prefixIcon: Icons.phone_outlined,
                        controller: controller.phoneController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Address',
                        hint: '456 Court Street',
                        prefixIcon: Icons.location_on_outlined,
                        controller: controller.addressController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'Last Education',
                              hint: 'LL.M',
                              prefixIcon: Icons.school_outlined,
                              controller: controller.educationController,
                              enabled: isEditing,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'Experience',
                              hint: '6 years',
                              prefixIcon: Icons.work_history_outlined,
                              controller: controller.experienceController,
                              enabled: isEditing,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'hourly_rate_bdt'.tr,
                        hint: '5000',
                        prefixIcon: Icons.attach_money_rounded,
                        keyboardType: TextInputType.number,
                        controller: controller.rateController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'professional_bio'.tr,
                        hint: 'Write a short bio...',
                        maxLines: 4,
                        controller: controller.bioController,
                        enabled: isEditing,
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
                      Wrap(
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
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Save or Edit Button
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isEditing) {
                        controller.saveChanges();
                      } else {
                        controller.toggleEdit();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isEditing
                                    ? Icons.check_circle_outline
                                    : Icons.edit_outlined,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isEditing ? 'save_changes'.tr : 'Edit Profile',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
