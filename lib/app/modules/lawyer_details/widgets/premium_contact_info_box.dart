import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';

class PremiumContactInfoBox extends StatelessWidget {
  const PremiumContactInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryText = isDark ? Colors.white : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final containerBg = isDark ? const Color(0xFF1E2E4A) : const Color(0xFFE2E8F0);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // ── Blurred Phone Number Row ──
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: .06) : Colors.black.withValues(alpha: .06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.phone_rounded, color: isDark ? Colors.white60 : Colors.black54, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Simulated blur/placeholder line
                    Container(
                      height: 10,
                      width: 180,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: .12) : Colors.black.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // ── Blurred Email Address Row ──
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: .06) : Colors.black.withValues(alpha: .06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.email_rounded, color: isDark ? Colors.white60 : Colors.black54, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: secondaryText,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Simulated blur/placeholder line
                    Container(
                      height: 10,
                      width: 150,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withValues(alpha: .12) : Colors.black.withValues(alpha: .12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ── Lock Icon ──
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: kAccentGold,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kAccentGold.withValues(alpha: .3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 16),

          // ── Subtitle and Title ──
          Text(
            'Premium Contact Info',
            style: GoogleFonts.outfit(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: primaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Upgrade to view & contact directly',
            style: GoogleFonts.outfit(
              fontSize: 12.5,
              color: secondaryText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
