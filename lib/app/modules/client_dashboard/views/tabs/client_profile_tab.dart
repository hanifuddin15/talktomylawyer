import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_settings_tile.dart';
import '../../../client_subscription/checkout/views/checkout_view.dart';

import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_profile_controller.dart';

class ClientProfileTab extends GetView<ClientProfileController> {
  const ClientProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    final name = controller.clientModel.name ?? 'User Name';
    final email = controller.clientModel.email ?? 'user@email.com';
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase()
        : 'U';

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header Card
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    AppAvatar(
                      initials: initials,
                      radius: 40,
                      showEditButton: true,
                      onEditTap: () {},
                    ),
                    const SizedBox(height: 12),
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Premium upgrade banner
                    GestureDetector(
                      onTap: () => Get.to(() => const CheckoutView()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1E3A8A), kPrimaryBlue],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: kAccentGold,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'upgrade_to_premium'.tr,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'upgrade_premium_sub'.tr,
                                    style: GoogleFonts.outfit(
                                      fontSize: 11,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Settings Group 1
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    AppSettingsTile(
                      icon: Icons.edit_outlined,
                      title: 'edit_profile'.tr,
                      subtitle: 'edit_profile_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.card_membership_rounded,
                      title: 'subscription_status'.tr,
                      subtitle: 'subscription_status_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.bookmark_outline,
                      title: 'saved_lawyers'.tr,
                      subtitle: 'saved_lawyers_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.history_rounded,
                      title: 'consultation_history'.tr,
                      subtitle: 'consultation_history_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.folder_outlined,
                      title: 'my_documents'.tr,
                      subtitle: 'my_documents_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.notifications_outlined,
                      title: 'notifications'.tr,
                      subtitle: 'notifications_sub'.tr,
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Settings Group 2
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    AppSettingsTile(
                      icon: Icons.security_outlined,
                      title: 'privacy_security'.tr,
                      subtitle: 'privacy_security_sub'.tr,
                      onTap: () {},
                    ),
                    AppSettingsTile(
                      icon: Icons.help_outline_rounded,
                      title: 'help_support'.tr,
                      subtitle: 'help_support_sub'.tr,
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Sign Out
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Get.offAllNamed('/role_selection'),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: kError.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: kError.withValues(alpha: 0.4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.logout_rounded,
                          color: kError,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'sign_out'.tr,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: kError,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
