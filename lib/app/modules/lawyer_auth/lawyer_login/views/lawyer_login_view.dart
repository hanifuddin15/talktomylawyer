import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import '../controllers/lawyer_login_controller.dart';

class LawyerLoginView extends GetView<LawyerLoginController> {
  const LawyerLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardBg = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
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
                    const Spacer(),
                    // Role badge — Lawyer
                    GestureDetector(
                      onTap: controller.goToClientLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kLawyerBadgeBg.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: kLawyerBadgeBg.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.work_rounded,
                              color: kLawyerBadgeBg,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'lawyer_badge'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: kLawyerBadgeBg,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.swap_horiz,
                              color: kLawyerBadgeBg,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'welcome_back'.tr,
                  style: GoogleFonts.outfit(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'sign_in_lawyer'.tr,
                  style: GoogleFonts.outfit(fontSize: 15, color: secondaryText),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTextField(
                        label: 'email_address'.tr,
                        hint: 'enter_email'.tr,
                        controller: emailCtrl,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'password'.tr,
                        hint: 'enter_password'.tr,
                        controller: passCtrl,
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        validator: (v) => v!.isEmpty ? 'Required' : null,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'forgot_password'.tr,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: kPrimaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => AppButton(
                          label: 'sign_in'.tr,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.onSignIn(
                                emailCtrl.text,
                                passCtrl.text,
                              );
                            }
                          },
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: controller.goToRegister,
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: secondaryText,
                        ),
                        children: [
                          TextSpan(text: '${'no_account'.tr} '),
                          TextSpan(
                            text: 'register'.tr,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
