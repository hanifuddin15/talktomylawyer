import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
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
              const SizedBox(height: 24),
              Text(
                'how_will_you_use'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'select_role_subtitle'.tr,
                style: GoogleFonts.outfit(fontSize: 15, color: secondaryText),
              ),
              const SizedBox(height: 28),
              // Client Card
              Obx(
                () => _RoleCard(
                  role: 'client',
                  isSelected: controller.selectedRole.value == 'client',
                  icon: Icons.person_rounded,
                  title: 'continue_as_client'.tr,
                  description: 'client_desc'.tr,
                  features: [
                    'client_feature_1'.tr,
                    'client_feature_2'.tr,
                    'client_feature_3'.tr,
                  ],
                  onTap: () => controller.selectRole('client'),
                ),
              ),
              const SizedBox(height: 16),
              // Lawyer Card
              Obx(
                () => _RoleCard(
                  role: 'lawyer',
                  isSelected: controller.selectedRole.value == 'lawyer',
                  icon: Icons.work_rounded,
                  title: 'continue_as_lawyer'.tr,
                  description: 'lawyer_desc'.tr,
                  features: [
                    'lawyer_feature_1'.tr,
                    'lawyer_feature_2'.tr,
                    'lawyer_feature_3'.tr,
                  ],
                  onTap: () => controller.selectRole('lawyer'),
                ),
              ),
              const SizedBox(height: 24),
              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'continue'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Login link
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed('/client_login'),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: secondaryText,
                      ),
                      children: [
                        TextSpan(text: '${'already_account'.tr} '),
                        TextSpan(
                          text: 'sign_in_link'.tr,
                          style: const TextStyle(
                            color: kPrimaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.role,
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.description,
    required this.features,
    required this.onTap,
  });

  final String role;
  final bool isSelected;
  final IconData icon;
  final String title;
  final String description;
  final List<String> features;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? kPrimaryBlue : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: kPrimaryBlue.withValues(alpha: .15),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: kPrimaryBlue.withValues(alpha: .15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: kPrimaryBlue, size: 26),
                    ),
                    // Radio indicator
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? kPrimaryBlue
                              : (isDark ? kDarkTextHint : kLightTextHint),
                          width: 2,
                        ),
                        color: isSelected ? kPrimaryBlue : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 10,
                            )
                          : null,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? kPrimaryBlue : primaryText,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: secondaryText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...features.map(
                      (f) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_rounded,
                              size: 16,
                              color: isSelected
                                  ? kPrimaryBlue
                                  : (isDark ? kDarkTextHint : kLightTextHint),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              f,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                color: isSelected ? primaryText : secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}
