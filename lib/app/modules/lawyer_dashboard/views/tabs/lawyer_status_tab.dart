import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_section_header.dart';
import 'package:talktomylawyer/app/core/widgets/app_timeline_item.dart';

import 'package:talktomylawyer/app/modules/lawyer_dashboard/controllers/lawyer_status_controller.dart';

class LawyerStatusTab extends GetView<LawyerStatusController> {
  const LawyerStatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final cardColor = isDark ? kDarkCard : kLightCard;
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
              Text(
                'verification_status'.tr,
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
              const SizedBox(height: 20),

              // Status Banner
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
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: kAccentGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.hourglass_top_rounded,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'pending'.tr,
                      style: GoogleFonts.outfit(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: kAccentGold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'your_app_under_review'.tr,
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
              const SizedBox(height: 24),

              // Verification Timeline
              AppSectionHeader(title: 'verification_timeline'.tr),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    AppTimelineItem(
                      title: 'profile_created'.tr,
                      subtitle: 'Account successfully created',
                      date: 'June 1, 2026',
                      status: 'done',
                    ),
                    AppTimelineItem(
                      title: 'docs_submitted'.tr,
                      subtitle: 'Bar license and NID submitted',
                      date: 'June 2, 2026',
                      status: 'done',
                    ),
                    AppTimelineItem(
                      title: 'under_review'.tr,
                      subtitle: 'Our team is reviewing your application',
                      date: 'June 3, 2026',
                      status: 'active',
                    ),
                    AppTimelineItem(
                      title: 'verification_complete'.tr,
                      subtitle: "You'll receive a notification",
                      date: '${'expected'.tr} June 5',
                      status: 'pending',
                      isLast: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Submitted Documents
              AppSectionHeader(title: 'submitted_documents'.tr),
              const SizedBox(height: 12),
              _DocumentItem(
                icon: Icons.card_membership_rounded,
                label: 'bar_license'.tr,
                fileName: 'bar_license_rahman.pdf',
                status: 'Verified',
                statusColor: kSuccess,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
                cardColor: cardColor,
              ),
              const SizedBox(height: 8),
              _DocumentItem(
                icon: Icons.badge_outlined,
                label: 'national_id'.tr,
                fileName: 'nid_rahman_scan.jpg',
                status: 'Pending',
                statusColor: kAccentGold,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
                cardColor: cardColor,
              ),
              const SizedBox(height: 8),
              _DocumentItem(
                icon: Icons.photo_camera_outlined,
                label: 'professional_photo'.tr,
                fileName: 'profile_photo.jpg',
                status: 'Verified',
                statusColor: kSuccess,
                isDark: isDark,
                primaryText: primaryText,
                secondaryText: secondaryText,
                cardColor: cardColor,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentItem extends StatelessWidget {
  const _DocumentItem({
    required this.icon,
    required this.label,
    required this.fileName,
    required this.status,
    required this.statusColor,
    required this.isDark,
    required this.primaryText,
    required this.secondaryText,
    required this.cardColor,
  });
  final IconData icon;
  final String label, fileName, status;
  final Color statusColor, primaryText, secondaryText, cardColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: kPrimaryBlue.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kPrimaryBlue, size: 22),
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
                  fileName,
                  style: GoogleFonts.outfit(fontSize: 11, color: secondaryText),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
