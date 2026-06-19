import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_step_indicator.dart';
import 'package:talktomylawyer/app/core/widgets/app_tag_chip.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import '../controllers/lawyer_register_controller.dart';

class LawyerRegisterView extends GetView<LawyerRegisterController> {
  const LawyerRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: controller.step.value > 0
                          ? controller.prevStep
                          : Get.back,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isDark ? kDarkCard : kLightCard,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: primaryText,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'lawyer_registration'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                AppStepIndicator(
                  steps: 4,
                  currentStep: controller.step.value,
                  stepLabels: ['Profile', 'Expertise', 'Documents', 'Verify'],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildStep(
                      context,
                      controller.step.value,
                      isDark,
                      primaryText,
                      secondaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(
    BuildContext ctx,
    int step,
    bool isDark,
    Color primaryText,
    Color secondaryText,
  ) {
    switch (step) {
      case 0:
        return _Step1Profile(
          controller: controller,
          isDark: isDark,
          primaryText: primaryText,
        );
      case 1:
        return _Step2Expertise(
          controller: controller,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        );
      case 2:
        return _Step3Documents(
          controller: controller,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        );
      case 3:
        return _Step4Verify(
          controller: controller,
          isDark: isDark,
          primaryText: primaryText,
          secondaryText: secondaryText,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ─── Step 1: Profile ──────────────────────────
class _Step1Profile extends StatelessWidget {
  const _Step1Profile({
    required this.controller,
    required this.isDark,
    required this.primaryText,
  });
  final LawyerRegisterController controller;
  final bool isDark;
  final Color primaryText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('ls1'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'step_1_profile'.tr,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: kAccentGold,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'personal_information'.tr,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 20),
          // Upload photo
          Center(
            child: GestureDetector(
              onTap: () => controller.photoPath.value =
                  controller.photoPath.value.isEmpty ? 'dummy_profile.jpg' : '',
              child: Obx(() {
                final hasPhoto = controller.photoPath.value.isNotEmpty;
                return Container(
                  width: Get.width * 0.9,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                    color: isDark ? kDarkInputFill : kLightInputFill,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: hasPhoto ? kSuccess : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      radius: const Radius.circular(24),
                      color: hasPhoto ? kSuccess : kDarkTextHint,
                      dashPattern: const [8, 4],
                      strokeWidth: 2,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            hasPhoto ? Icons.check_circle : Icons.camera_alt,
                            color: hasPhoto ? kSuccess : kPrimaryBlue,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            hasPhoto
                                ? 'Profile photo uploaded ✓'
                                : 'upload_profile_photo'.tr,
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              color: hasPhoto ? kSuccess : kPrimaryBlue,
                              fontWeight: hasPhoto ? FontWeight.w600 : null,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'full_name'.tr,
            hint: 'your_full_name'.tr,
            prefixIcon: Icons.person_outline,
            onChanged: (v) => controller.fullName = v,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'email'.tr,
            hint: 'email_placeholder'.tr,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => controller.email = v,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'phone'.tr,
            hint: '+880 1XXX-XXXXXX',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onChanged: (v) => controller.phone = v,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'password'.tr,
            hint: 'enter_password'.tr,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            onChanged: (v) => controller.password = v,
          ),
          const SizedBox(height: 28),
          AppButton(label: 'next'.tr, onPressed: controller.nextStep),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ─── Step 2: Expertise ────────────────────────
class _Step2Expertise extends StatelessWidget {
  const _Step2Expertise({
    required this.controller,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });
  final LawyerRegisterController controller;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('ls2'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'step_2_expertise'.tr,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: kAccentGold,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'professional_details'.tr,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'bar_registration'.tr,
            hint: 'BD-BAR-XXXXX',
            prefixIcon: Icons.badge_outlined,
            onChanged: (v) => controller.barNumber = v,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'years_of_experience'.tr,
            hint: 'e.g. 8',
            prefixIcon: Icons.work_outline,
            keyboardType: TextInputType.number,
            onChanged: (v) => controller.yearsOfExp = v,
          ),
          const SizedBox(height: 14),
          AppTextField(
            label: 'education'.tr,
            hint: 'education_hint'.tr,
            prefixIcon: Icons.school_outlined,
            onChanged: (v) => controller.education = v,
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
            children: controller.allPracticeAreas
                .map(
                  (area) => AppTagChip(
                    label: area.tr,
                    isSelected: controller.practiceAreas.contains(area),
                    onTap: () => controller.togglePracticeArea(area),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 28),
          AppButton(label: 'next'.tr, onPressed: controller.nextStep),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ─── Step 3: Documents ────────────────────────
class _Step3Documents extends StatelessWidget {
  const _Step3Documents({
    required this.controller,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });
  final LawyerRegisterController controller;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('ls3'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'step_3_documents'.tr,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: kAccentGold,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'upload_documents'.tr,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => _DocumentUploadTile(
              label: 'bar_license'.tr,
              isUploaded: controller.barLicensePath.value.isNotEmpty,
              onTap: () => controller.barLicensePath.value =
                  controller.barLicensePath.value.isEmpty
                  ? 'dummy_license.pdf'
                  : '',
              isDark: isDark,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => _DocumentUploadTile(
              label: 'national_id'.tr,
              isUploaded: controller.nidPath.value.isNotEmpty,
              onTap: () => controller.nidPath.value =
                  controller.nidPath.value.isEmpty ? 'dummy_nid.pdf' : '',
              isDark: isDark,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => _DocumentUploadTile(
              label: 'professional_photo'.tr,
              isUploaded: controller.photoPath.value.isNotEmpty,
              onTap: () => controller.photoPath.value =
                  controller.photoPath.value.isEmpty ? 'dummy_profile.jpg' : '',
              isDark: isDark,
              primaryText: primaryText,
              secondaryText: secondaryText,
            ),
          ),
          const SizedBox(height: 28),
          AppButton(label: 'next'.tr, onPressed: controller.nextStep),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _DocumentUploadTile extends StatelessWidget {
  const _DocumentUploadTile({
    required this.label,
    required this.isUploaded,
    required this.onTap,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });
  final String label;
  final bool isUploaded;
  final VoidCallback onTap;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? kDarkCard : kLightCard;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUploaded
                ? kSuccess
                : (isDark ? kDarkDivider : kLightDivider),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (isUploaded ? kSuccess : kPrimaryBlue).withValues(
                  alpha: 0.15,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isUploaded ? Icons.check_circle_outline : Icons.upload_file,
                color: isUploaded ? kSuccess : kPrimaryBlue,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryText,
                    ),
                  ),
                  Text(
                    isUploaded ? 'File uploaded ✓' : 'tap_to_upload'.tr,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: isUploaded ? kSuccess : secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Step 4: Pending Verify ────────────────────
class _Step4Verify extends StatelessWidget {
  const _Step4Verify({
    required this.controller,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
  });
  final LawyerRegisterController controller;
  final bool isDark;
  final Color primaryText;
  final Color secondaryText;

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? kDarkCard : kLightCard;
    return SingleChildScrollView(
      key: const ValueKey('ls4'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'step_4_verify'.tr,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: kAccentGold,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: kAccentGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hourglass_top_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'verification_pending'.tr,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: kAccentGold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'verification_pending_body'.tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: secondaryText,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Obx(
            () => AppButton(
              label: 'submit_for_review'.tr,
              onPressed: controller.nextStep,
              isLoading: controller.isLoading.value,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
