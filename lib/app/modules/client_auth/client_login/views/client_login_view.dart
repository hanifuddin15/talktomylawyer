import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_text_field.dart';
import '../controllers/client_login_controller.dart';

class ClientLoginView extends GetView<ClientLoginController> {
  const ClientLoginView({super.key});

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
                // Back + Role Switch
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
                    // Role badge + switch
                    GestureDetector(
                      onTap: controller.goToLawyerLogin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kClientBadgeBg.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: kClientBadgeBg.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_rounded,
                              color: kClientBadgeBg,
                              size: 14,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'client_badge'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: kClientBadgeBg,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              Icons.swap_horiz,
                              color: kClientBadgeBg,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Title
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
                  'sign_in_client'.tr,
                  style: GoogleFonts.outfit(fontSize: 15, color: secondaryText),
                ),
                const SizedBox(height: 32),
                // Form Card
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
                const SizedBox(height: 20),
                // Or divider
                // Row(
                //   children: [
                //     Expanded(
                //       child: Divider(
                //         color: isDark ? kDarkDivider : kLightDivider,
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 12),
                //       child: Text(
                //         'or_continue_with'.tr,
                //         style: GoogleFonts.outfit(
                //           fontSize: 13,
                //           color: secondaryText,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Divider(
                //         color: isDark ? kDarkDivider : kLightDivider,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 16),
                // // Social Buttons
                // Row(
                //   children: [
                //     Expanded(
                //       child: _SocialButton(
                //         label: 'google'.tr,
                //         icon: Icons.g_mobiledata_rounded,
                //         iconColor: Colors.red,
                //         onTap: () {},
                //       ),
                //     ),
                //     const SizedBox(width: 12),
                //     Expanded(
                //       child: _SocialButton(
                //         label: 'facebook'.tr,
                //         icon: Icons.facebook_rounded,
                //         iconColor: const Color(0xFF1877F2),
                //         onTap: () {},
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 24),

                // Register link
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isDark ? kDarkCard : kLightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? kDarkDivider : kLightDivider),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? kDarkTextPrimary : kLightTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
