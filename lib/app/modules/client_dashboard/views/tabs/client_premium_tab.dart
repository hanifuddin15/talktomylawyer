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
  int _selectedPlan = 1; // 0=monthly, 1=quarterly

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

              // Plan Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? kDarkCard : kLightCard,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    _PlanTab(
                      label: 'monthly'.tr,
                      isSelected: _selectedPlan == 0,
                      onTap: () => setState(() => _selectedPlan = 0),
                    ),
                    _PlanTab(
                      label: 'quarterly'.tr,
                      isSelected: _selectedPlan == 1,
                      onTap: () => setState(() => _selectedPlan = 1),
                      badge: 'save_17'.tr,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Monthly Plan Card
              if (_selectedPlan == 0)
                _buildMonthlyCard(isDark, primaryText, secondaryText),

              // Quarterly Plan Card
              if (_selectedPlan == 1)
                _buildQuarterlyCard(isDark, primaryText, secondaryText),

              const SizedBox(height: 20),
              // CTA
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const CheckoutView()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kAccentGold,
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
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'upgrade'.tr,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Cancel anytime. No hidden fees.',
                  style: GoogleFonts.outfit(fontSize: 13, color: secondaryText),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthlyCard(
    bool isDark,
    Color primaryText,
    Color secondaryText,
  ) {
    final cardColor = isDark ? kDarkCard : kLightCard;
    final features = [
      'unlimited_consultations'.tr,
      'doc_review'.tr,
      'Access to all lawyers',
      'Priority support',
      'Secure messaging',
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryBlue, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'monthly'.tr,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '৳৯৯৯',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: primaryText,
                  ),
                ),
                TextSpan(
                  text: ' /${'per_month'.tr}',
                  style: GoogleFonts.outfit(fontSize: 14, color: secondaryText),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: kSuccess,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    f,
                    style: GoogleFonts.outfit(fontSize: 14, color: primaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterlyCard(
    bool isDark,
    Color primaryText,
    Color secondaryText,
  ) {
    final cardColor = isDark ? kDarkCard : kLightCard;
    final features = [
      'everything_monthly'.tr,
      'unlimited_consultations'.tr,
      'doc_review'.tr,
      'Access to all lawyers',
      'Priority support',
      'Secure messaging',
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kAccentGold.withValues(alpha: 0.15), cardColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kAccentGold, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'quarterly'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: kAccentGold,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'save_17'.tr,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '৳২,৪৯৯',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: primaryText,
                  ),
                ),
                TextSpan(
                  text: ' /${'per_3_months'.tr}',
                  style: GoogleFonts.outfit(fontSize: 14, color: secondaryText),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...features.map(
            (f) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: kSuccess,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    f,
                    style: GoogleFonts.outfit(fontSize: 14, color: primaryText),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanTab extends StatelessWidget {
  const _PlanTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? kPrimaryBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : kDarkTextSecondary,
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: kAccentGold,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    badge!,
                    style: GoogleFonts.outfit(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
