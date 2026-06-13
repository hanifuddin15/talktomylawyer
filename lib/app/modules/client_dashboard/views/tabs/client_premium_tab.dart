import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../../../client_subscription/checkout/views/checkout_view.dart';

class ClientPremiumTab extends StatefulWidget {
  const ClientPremiumTab({super.key});

  @override
  State<ClientPremiumTab> createState() => _ClientPremiumTabState();
}

class _ClientPremiumTabState extends State<ClientPremiumTab> {
  int _selectedPlan = 1; // 0=monthly, 1=quarterly, 2=yearly

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final isBn = Get.locale?.languageCode == 'bn';

    final monthlyFeatures = [
      'feature_monthly_1'.tr,
      'feature_monthly_2'.tr,
      'feature_monthly_3'.tr,
      'feature_monthly_4'.tr,
      'feature_monthly_5'.tr,
    ];

    final quarterlyFeatures = [
      'everything_monthly'.tr,
      'unlimited_consultations'.tr,
      'doc_review'.tr,
      'feature_quarterly_4'.tr,
      'feature_quarterly_5'.tr,
    ];

    final yearlyFeatures = [
      'everything_quarterly'.tr,
      'feature_yearly_2'.tr,
      'feature_yearly_3'.tr,
      'feature_yearly_4'.tr,
      'feature_yearly_5'.tr,
    ];

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
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

              // 1. Monthly Plan Card
              _buildPlanCard(
                index: 0,
                title: 'monthly'.tr,
                price: isBn ? '৳৯৯৯' : '৳999',
                duration: 'per_month'.tr,
                features: monthlyFeatures,
                isHighlighted: false,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
              ),
              const SizedBox(height: 16),

              // 2. Quarterly Plan Card (Highlighted blue)
              _buildPlanCard(
                index: 1,
                title: 'quarterly'.tr,
                price: isBn ? '৳২,৪৯৯' : '৳2,499',
                duration: 'per_3_months'.tr,
                features: quarterlyFeatures,
                isHighlighted: true,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
                badgeText: 'save_17'.tr,
              ),
              const SizedBox(height: 16),

              // 3. Yearly Plan Card
              _buildPlanCard(
                index: 2,
                title: 'yearly'.tr,
                price: isBn ? '৳৭,৯৯৯' : '৳7,999',
                duration: 'per_year'.tr,
                features: yearlyFeatures,
                isHighlighted: false,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
                badgeText: 'save_33'.tr,
                badgeBg: const Color(0xFFD1FAE5),
                badgeTextColor: const Color(0xFF065F46),
              ),
              const SizedBox(height: 24),

              // CTA Button (Subscribe Now)
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    String planName = 'quarterly_premium'.tr;
                    String planKey = 'quarterly'.tr;
                    String duration = '3_months'.tr;
                    String? savings = isBn ? '৳৪৯৮ (১৭% সাশ্রয়)' : '৳498 (17% off)';
                    String price = isBn ? '৳২,৪৯৯' : '৳2,499';

                    if (_selectedPlan == 0) {
                      planName = 'monthly_premium'.tr;
                      planKey = 'monthly'.tr;
                      duration = '1_month'.tr;
                      savings = null;
                      price = isBn ? '৳৯৯৯' : '৳999';
                    } else if (_selectedPlan == 2) {
                      planName = 'yearly_premium'.tr;
                      planKey = 'yearly'.tr;
                      duration = '12_months'.tr;
                      savings = isBn ? '৳৩,৯৮৯ (৩৩% সাশ্রয়)' : '৳3,989 (33% off)';
                      price = isBn ? '৳৭,৯৯৯' : '৳7,999';
                    }

                    Get.to(() => CheckoutView(
                          planName: planName,
                          planKey: planKey,
                          duration: duration,
                          savings: savings,
                          price: price,
                        ));
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
          ),
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
    String? badgeText,
    Color? badgeBg,
    Color? badgeTextColor,
  }) {
    final cardColor = isHighlighted
        ? kPrimaryBlue
        : (isDark ? kDarkCard : kLightCard);
    final textPrimary = isHighlighted ? Colors.white : primaryText;
    final textSecondary = isHighlighted ? Colors.white70 : secondaryText;
    final isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = index),
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
