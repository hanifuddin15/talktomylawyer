import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/lawyer_details_controller.dart';
import '../widgets/lawyer_stats_row.dart';
import '../widgets/lawyer_tabs.dart';
import '../widgets/lawyer_about_tab_content.dart';
import '../widgets/lawyer_reviews_tab_content.dart';
import '../widgets/lawyer_availability_tab_content.dart';
import '../widgets/unlock_premium_banner.dart';
import '../widgets/premium_contact_info_box.dart';
import '../widgets/locked_actions_row.dart';

class LawyerDetailsView extends GetView<LawyerDetailsController> {
  const LawyerDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final cardColor = isDark ? kDarkCard : kLightCard;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final lawyer = controller.lawyer.value;
          if (lawyer == null) {
            return Center(
              child: Text(
                'Lawyer details not found',
                style: GoogleFonts.outfit(color: secondaryText, fontSize: 16),
              ),
            );
          }

          final hasAvatar = lawyer.profilePic != null && lawyer.profilePic != 'default.png';
          final avatarUrl = hasAvatar
              ? '${ApiConstant.serverIpPort}/storage/${lawyer.profilePic}'
              : null;

          final initials = lawyer.name != null && lawyer.name!.isNotEmpty
              ? lawyer.name!
                    .trim()
                    .split(' ')
                    .map((e) => e.isNotEmpty ? e.substring(0, 1) : '')
                    .join()
                    .toUpperCase()
              : 'L';

          final primaryCategory = (lawyer.categories != null && lawyer.categories!.isNotEmpty)
              ? lawyer.categories!.first.name ?? 'Lawyer'
              : 'Lawyer';

          final biography = 'Experienced $primaryCategory attorney with over ${lawyer.numberOfExperience ?? '5'} years of practice in ${lawyer.address ?? 'Dhaka'} courts. Specializes in providing expert legal representation and strategic counsel to clients.';

          final hasSub = controller.hasSubscription.value;

          return Column(
            children: [
              // ── Header Custom AppBar ──
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cardColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: dividerColor),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: primaryText,
                          size: 20,
                        ),
                      ),
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.toggleSave,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: dividerColor),
                          ),
                          child: Icon(
                            controller.isSaved.value
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: controller.isSaved.value
                                ? kAccentGold
                                : primaryText,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Profile Section ──
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          // Large Rounded Profile Avatar
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kPrimaryBlue.withValues(alpha: .3),
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: kPrimaryBlue.withValues(
                                alpha: .15,
                              ),
                              backgroundImage: avatarUrl != null
                                  ? NetworkImage(avatarUrl)
                                  : null,
                              child: avatarUrl == null
                                  ? Text(
                                      initials,
                                      style: GoogleFonts.outfit(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w800,
                                        color: kPrimaryBlue,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Lawyer Name and Badge
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        lawyer.name ?? 'Jane Lawyer',
                                        style: GoogleFonts.outfit(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          color: primaryText,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.verified,
                                      color: kPrimaryBlue,
                                      size: 18,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Senior $primaryCategory Lawyer',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: secondaryText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Star and Location Row
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      color: kAccentGold,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4.9 (127 reviews)',
                                      style: GoogleFonts.outfit(
                                        fontSize: 13,
                                        color: primaryText,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: secondaryText,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        lawyer.address ?? 'Dhaka',
                                        style: GoogleFonts.outfit(
                                          fontSize: 13,
                                          color: secondaryText,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ── Quick Stats Grid ──
                      LawyerStatsRow(
                        experience: lawyer.numberOfExperience ?? '5',
                        reviewsCount: '127',
                        rate: '5K',
                        isDark: isDark,
                      ),
                      const SizedBox(height: 24),

                      // ── Tabs ──
                      Obx(() => LawyerTabs(
                        activeIndex: controller.activeTab.value,
                        onTabChanged: (val) => controller.activeTab.value = val,
                        dividerColor: dividerColor,
                      )),
                      const SizedBox(height: 20),

                      // ── Tab Content ──
                      Obx(() {
                        if (!controller.hasSubscription.value) {
                          return const Column(
                            children: [
                              PremiumContactInfoBox(),
                              LockedActionsRow(),
                            ],
                          );
                        }
                        switch (controller.activeTab.value) {
                          case 0:
                            return LawyerAboutTabContent(
                              bio: biography,
                              education: lawyer.lastEducation,
                              barRegistration: lawyer.barCouncilNumber,
                              categories: lawyer.categories,
                              primaryText: primaryText,
                              secondaryText: secondaryText,
                              phoneNumber: lawyer.phone,
                              email: lawyer.email,
                            );
                          case 1:
                            return LawyerReviewsTabContent(
                              primaryText: primaryText,
                              secondaryText: secondaryText,
                              cardColor: cardColor,
                            );
                          case 2:
                            return LawyerAvailabilityTabContent(
                              primaryText: primaryText,
                              secondaryText: secondaryText,
                              cardColor: cardColor,
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      }),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // ── Sticky Bottom Bar ──
              Container(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                decoration: BoxDecoration(
                  color: bg,
                  border: Border(
                    top: BorderSide(color: dividerColor, width: 1),
                  ),
                ),
                child: hasSub
                    ? SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Book appoinment',
                            style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : UnlockPremiumBanner(
                        onTap: controller.navigateToPremiumTab,
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
