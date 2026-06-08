import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_button.dart';
import 'package:talktomylawyer/app/core/widgets/app_payment_option.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  int _selectedPayment = 0; // 0=bkash, 1=ssl, 2=stripe

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    // final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: cardColor,
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
                    'secure_checkout'.tr,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Plan Summary Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1A2F6A), kPrimaryBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: kAccentGold,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'quarterly_premium'.tr,
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          _SummaryRow(
                            label: 'plan'.tr,
                            value: 'quarterly'.tr,
                            isWhite: true,
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'duration'.tr,
                            value: '3_months'.tr,
                            isWhite: true,
                          ),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'savings'.tr,
                            value: '৳৪৯৮ (17% off)',
                            isWhite: true,
                          ),
                          const Divider(color: Colors.white24, height: 20),
                          _SummaryRow(
                            label: 'total'.tr,
                            value: '৳২,৪৯৯',
                            isWhite: true,
                            isBold: true,
                            valueColor: kAccentGold,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Method
                    Text(
                      'payment_method'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    AppPaymentOption(
                      label: 'bkash'.tr,
                      icon: Icons.account_balance_wallet_rounded,
                      iconBg: const Color(0xFFE2136E),
                      isSelected: _selectedPayment == 0,
                      onTap: () => setState(() => _selectedPayment = 0),
                    ),
                    const SizedBox(height: 10),
                    AppPaymentOption(
                      label: 'ssl_commerz'.tr,
                      icon: Icons.payment_rounded,
                      iconBg: const Color(0xFF2563EB),
                      isSelected: _selectedPayment == 1,
                      onTap: () => setState(() => _selectedPayment = 1),
                    ),
                    const SizedBox(height: 10),
                    AppPaymentOption(
                      label: 'stripe_card'.tr,
                      icon: Icons.credit_card_rounded,
                      iconBg: const Color(0xFF6366F1),
                      isSelected: _selectedPayment == 2,
                      onTap: () => setState(() => _selectedPayment = 2),
                    ),
                    const SizedBox(height: 20),

                    // SSL Note
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: kSuccess.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: kSuccess.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.lock_rounded,
                            color: kSuccess,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'ssl_note'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: kSuccess,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pay Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: AppButton(
                label: '${'pay'.tr} ৳২,৪৯৯',
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Payment Successful',
                    'Your premium plan is now active',
                    backgroundColor: kSuccess,
                    colorText: Colors.white,
                  );
                },
                variant: AppButtonVariant.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isWhite = false,
    this.isBold = false,
    this.valueColor,
  });
  final String label;
  final String value;
  final bool isWhite;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textColor = isWhite ? Colors.white70 : kDarkTextSecondary;
    final valColor = valueColor ?? (isWhite ? Colors.white : kDarkTextPrimary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 14, color: textColor)),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: valColor,
          ),
        ),
      ],
    );
  }
}
