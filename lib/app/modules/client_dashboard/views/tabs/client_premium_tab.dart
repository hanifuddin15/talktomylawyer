import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/modules/client_dashboard/controllers/client_premium_controller.dart';
import 'package:talktomylawyer/app/models/client_models/subscription_model.dart';
import '../../../client_subscription/checkout/views/checkout_view.dart';

class ClientPremiumTab extends GetView<ClientPremiumController> {
  const ClientPremiumTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final isBn = Get.locale?.languageCode == 'bn';

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Obx(() {
            final selected = controller.selectedPlan.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Icon(Icons.star_rounded, color: kAccentGold, size: 36),
                const SizedBox(height: 12),
                Text(
                  'go_premium'.tr,
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'go_premium_subtitle'.tr,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: secondaryText,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),

                if (controller.isLoading.value) ...[
                  const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ] else if (controller.subscriptions.isEmpty) ...[
                  SizedBox(
                    height: 200,
                    child: Center(
                      child: Text(
                        'No subscription packages available.',
                        style: GoogleFonts.outfit(color: secondaryText, fontSize: 16),
                      ),
                    ),
                  ),
                ] else ...[
                  ...controller.subscriptions.asMap().entries.map((MapEntry<int, SubscriptionModel> entry) {
                    final index = entry.key;
                    final plan = entry.value;
                    final isHighlighted = index == 1 || (plan.badgeText != null && plan.badgeText!.isNotEmpty);

                    final title = plan.name ?? 'Premium';
                    final currency = plan.currency ?? '৳';
                    
                    String priceText = plan.price ?? '1500';
                    try {
                      final doubleVal = double.parse(priceText);
                      priceText = '$currency${doubleVal.toInt()}';
                    } catch (_) {
                      priceText = '$currency$priceText';
                    }

                    String durationText = '';
                    if (plan.duration != null && plan.durationType != null) {
                      final dur = plan.duration;
                      final type = plan.durationType;
                      if (dur == '1') {
                        durationText = 'per_$type'.tr;
                      } else {
                        durationText = 'per_${dur}_${type}s'.tr;
                      }
                      if (durationText.startsWith('per_')) {
                        final trVal = durationText.tr;
                        if (trVal == durationText) {
                          final typePlural = type == 'month' ? 'months' : (type == 'year' ? 'years' : 'days');
                          durationText = dur == '1' ? 'per $type' : 'per $dur $typePlural';
                        } else {
                          durationText = trVal;
                        }
                      }
                    } else {
                      durationText = 'per_month'.tr;
                    }

                    final features = plan.features ?? [];

                    String? badgeText;
                    if (plan.savePercentage != null && plan.savePercentage!.isNotEmpty && plan.savePercentage != '0') {
                      badgeText = isBn ? 'সাশ্রয় ${plan.savePercentage}%' : 'Save ${plan.savePercentage}%';
                    } else if (plan.badgeText != null && plan.badgeText!.isNotEmpty) {
                      badgeText = plan.badgeText;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildPlanCard(
                        index: index,
                        title: title,
                        price: priceText,
                        duration: durationText,
                        features: features,
                        isHighlighted: isHighlighted,
                        isDark: isDark,
                        primaryText: primaryText,
                        secondaryText: secondaryText,
                        badgeText: badgeText,
                        selectedPlan: selected,
                      ),
                    );
                  }),
                ],
                const SizedBox(height: 24),

                // CTA Button (Subscribe Now)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      if (selected >= 0 && selected < controller.subscriptions.length) {
                        final plan = controller.subscriptions[selected];
                        final currency = plan.currency ?? '৳';
                        
                        String priceText = plan.price ?? '1500';
                        try {
                          final doubleVal = double.parse(priceText);
                          priceText = '$currency${doubleVal.toInt()}';
                        } catch (_) {
                          priceText = '$currency$priceText';
                        }

                        final planName = plan.name ?? 'Premium';
                        final planKey = plan.name?.toLowerCase() ?? 'premium';
                        
                        final dur = plan.duration ?? '1';
                        final type = plan.durationType ?? 'month';
                        final typePlural = type == 'month' ? 'months' : (type == 'year' ? 'years' : 'days');
                        final durationString = dur == '1' ? '1 $type' : '$dur $typePlural';

                        String? savings;
                        if (plan.savePercentage != null && plan.savePercentage!.isNotEmpty && plan.savePercentage != '0') {
                          savings = isBn ? '${plan.savePercentage}% সাশ্রয়' : '${plan.savePercentage}% savings';
                        }

                        Get.to(() => CheckoutView(
                              planName: planName,
                              planKey: planKey,
                              duration: durationString,
                              savings: savings,
                              price: priceText,
                            ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB300), // Orange/Gold
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFF0A1128),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'subscribe_now'.tr,
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0A1128),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'cancel_anytime_hidden'.tr,
                    style: GoogleFonts.outfit(fontSize: 13, color: secondaryText),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required int index,
    required String title,
    required String price,
    required String duration,
    required List<String> features,
    required bool isHighlighted,
    required bool isDark,
    required Color primaryText,
    required Color secondaryText,
    required int selectedPlan,
    String? badgeText,
    Color? badgeBg,
    Color? badgeTextColor,
  }) {
    final cardColor = isHighlighted
        ? kPrimaryBlue
        : (isDark ? kDarkCard : kLightCard);
    final textPrimary = isHighlighted ? Colors.white : primaryText;
    final textSecondary = isHighlighted ? Colors.white70 : secondaryText;
    final isSelected = selectedPlan == index;

    return GestureDetector(
      onTap: () => controller.selectedPlan.value = index,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? kAccentGold
                : (isHighlighted ? Colors.transparent : (isDark ? kDarkDivider : kLightDivider)),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: kAccentGold.withValues(alpha: 0.15),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: textPrimary,
                  ),
                ),
                if (badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeBg ?? Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeText,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: badgeTextColor ?? Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              price,
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              duration,
              style: GoogleFonts.outfit(fontSize: 14, color: textSecondary),
            ),
            const SizedBox(height: 16),
            Divider(
              color: isHighlighted ? Colors.white24 : (isDark ? kDarkDivider : kLightDivider),
              height: 1,
            ),
            const SizedBox(height: 16),
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: isHighlighted ? Colors.white : kSuccess,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        f,
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: textPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
