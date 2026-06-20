import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import '../controllers/client_profile_controller.dart';

class ClientProfileView extends GetView<ClientProfileController> {
  const ClientProfileView({super.key});

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryText,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
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
          final client = controller.clientData.value;
          final name = client?.name ?? 'User Name';
          final email = client?.email ?? 'user@email.com';
          final initials = controller.initials;
          final isEditing = controller.isEditing.value;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar Area
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: kPrimaryBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                initials,
                                style: GoogleFonts.outfit(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // Photo edit trigger mockup
                                  Get.snackbar(
                                    'Change Photo',
                                    'Photo uploads will be supported soon!',
                                    backgroundColor: kPrimaryBlue,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (isEditing) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Tap camera to change photo',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: secondaryText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Form fields
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: dividerColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      AppTextField(
                        label: 'Full Name',
                        hint: 'John Doe',
                        prefixIcon: Icons.person_outline,
                        controller: controller.nameController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Email Address',
                        hint: 'email@example.com',
                        prefixIcon: Icons.email_outlined,
                        controller: TextEditingController(text: email),
                        enabled: false,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Phone Number',
                        hint: '+880 1700-000000',
                        prefixIcon: Icons.phone_outlined,
                        controller: controller.phoneController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      AppTextField(
                        label: 'Address',
                        hint: '123 New Road',
                        prefixIcon: Icons.location_on_outlined,
                        controller: controller.addressController,
                        enabled: isEditing,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField(
                              label: 'City',
                              hint: 'Dhaka',
                              prefixIcon: Icons.location_city_outlined,
                              controller: controller.cityController,
                              enabled: isEditing,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AppTextField(
                              label: 'Country',
                              hint: 'Bangladesh',
                              prefixIcon: Icons.public_outlined,
                              controller: controller.countryController,
                              enabled: isEditing,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

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
                                isEditing ? 'Save Changes' : 'Edit Profile',
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      ),
    );
  }
}
