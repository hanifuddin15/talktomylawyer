import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_step_indicator.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import '../controllers/client_register_controller.dart';

class ClientRegisterView extends GetView<ClientRegisterController> {
  const ClientRegisterView({super.key});

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
                // Header Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 20,
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
                    Text(
                      'create_account'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Step Indicator
                AppStepIndicator(
                  steps: 3,
                  currentStep: controller.step.value,
                  stepLabels: ['personal_info'.tr, 'contact'.tr, 'verify'.tr],
                ),
                const SizedBox(height: 24),
                // Step content
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStep(
                    context,
                    controller.step.value,
                    isDark,
                    primaryText,
                    secondaryText,
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
    BuildContext context,
    int step,
    bool isDark,
    Color primaryText,
    Color secondaryText,
  ) {
    switch (step) {
      case 0:
        return _Step1PersonalInfo(
          controller: controller,
          primaryText: primaryText,
          isDark: isDark,
        );
      case 1:
        return _Step2Contact(
          controller: controller,
          primaryText: primaryText,
          isDark: isDark,
        );
      case 2:
        return _Step3Verify(
          controller: controller,
          primaryText: primaryText,
          secondaryText: secondaryText,
          isDark: isDark,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

// ───── Step 1: Personal Information ──────
class _Step1PersonalInfo extends StatelessWidget {
  const _Step1PersonalInfo({
    required this.controller,
    required this.primaryText,
    required this.isDark,
  });
  final ClientRegisterController controller;
  final Color primaryText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController(text: controller.fullName);
    final emailCtrl = TextEditingController(text: controller.email);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        key: const ValueKey('step1'),
        children: [
          Text(
            'personal_information'.tr,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'full_name'.tr,
            hint: 'your_full_name'.tr,
            controller: nameCtrl,
            prefixIcon: Icons.person_outline,
            onChanged: (v) => controller.fullName = v,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'email_address'.tr,
            hint: 'your_email'.tr,
            controller: emailCtrl,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => controller.email = v,
          ),
          const SizedBox(height: 32),
          AppButton(label: 'next'.tr, onPressed: controller.nextStep),
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: controller.goToLogin,
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: isDark ? kDarkTextSecondary : kLightTextSecondary,
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ───── Step 2: Contact Details ────────────
class _Step2Contact extends StatelessWidget {
  const _Step2Contact({
    required this.controller,
    required this.primaryText,
    required this.isDark,
  });
  final ClientRegisterController controller;
  final Color primaryText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final phoneCtrl = TextEditingController(text: controller.phone);
    final passCtrl = TextEditingController(text: controller.password);
    final confirmCtrl = TextEditingController();

    return SingleChildScrollView(
      key: const ValueKey('step2'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'contact_details'.tr,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'phone_number'.tr,
            hint: 'phone_placeholder'.tr,
            controller: phoneCtrl,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            onChanged: (v) => controller.phone = v,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'password'.tr,
            hint: 'create_password'.tr,
            controller: passCtrl,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
            onChanged: (v) => controller.password = v,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'confirm_password'.tr,
            hint: 'confirm_password_hint'.tr,
            controller: confirmCtrl,
            prefixIcon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 32),
          AppButton(label: 'continue'.tr, onPressed: controller.nextStep),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ───── Step 3: OTP Verify ─────────────────
class _Step3Verify extends StatelessWidget {
  const _Step3Verify({
    required this.controller,
    required this.primaryText,
    required this.secondaryText,
    required this.isDark,
  });
  final ClientRegisterController controller;
  final Color primaryText;
  final Color secondaryText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('step3'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'verify_phone'.tr,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: isDark ? kDarkCard : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark ? kDarkDivider : kLightDivider,
                width: 1,
              ),
            ),
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Icon(Icons.info_outlined, color: kPrimaryBlue),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: secondaryText,
                    ),
                    children: [
                      TextSpan(text: '${'otp_sent_to'.tr} '),
                      TextSpan(
                        text: controller.phone.isNotEmpty
                            ? controller.phone
                            : '+880 XXXX-XXXXXX',
                        style: GoogleFonts.outfit(
                          // fontWeight: FontWeight.w600,
                          color: secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'otp_code'.tr,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 12),
          // OTP Fields
          _OtpInputRow(onChanged: (v) => controller.otp = v, isDark: isDark),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'resend_otp'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => AppButton(
              label: 'create_account_btn'.tr,
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

class _OtpInputRow extends StatelessWidget {
  const _OtpInputRow({required this.onChanged, required this.isDark});
  final void Function(String) onChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final fillColor = isDark ? kDarkInputFill : kLightInputFill;
    final textColor = isDark ? kDarkTextPrimary : kLightTextPrimary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        6,
        (i) => SizedBox(
          width: 50,
          height: 60,
          child: TextField(
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: kPrimaryBlue, width: 2),
              ),
            ),
            onChanged: (v) {
              if (v.isNotEmpty && i < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}
