import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/lawyer_details_controller.dart';

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

          final hasAvatar =
              lawyer.profilePic != null && lawyer.profilePic != 'default.png';
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

          final primaryCategory =
              (lawyer.categories != null && lawyer.categories!.isNotEmpty)
              ? lawyer.categories!.first.name ?? 'Lawyer'
              : 'Lawyer';

          final biography =
              'Experienced $primaryCategory attorney with over ${lawyer.numberOfExperience ?? '5'} years of practice in ${lawyer.address ?? 'Dhaka'} courts. Specializes in providing expert legal representation and strategic counsel to clients.';

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
                      Row(
                        children: [
                          _buildStatCard(
                            context,
                            '${lawyer.numberOfExperience ?? "5"} yrs',
                            'Experience',
                            isDark,
                          ),
                          const SizedBox(width: 12),
                          _buildStatCard(context, '127+', 'Reviews', isDark),
                          const SizedBox(width: 12),
                          _buildStatCard(context, '৳2K', 'Rate/hr', isDark),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ── Tabs ──
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: dividerColor, width: 1.5),
                          ),
                        ),
                        child: Obx(
                          () => Row(
                            children: [
                              _buildTabItem('About', 0),
                              _buildTabItem('Reviews', 1),
                              _buildTabItem('Availability', 2),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Tab Content ──
                      Obx(() {
                        switch (controller.activeTab.value) {
                          case 0:
                            return _buildAboutTab(
                              biography,
                              lawyer.lastEducation,
                              lawyer.barCouncilNumber,
                              lawyer.categories,
                              primaryText,
                              secondaryText,
                            );
                          case 1:
                            return _buildReviewsTab(
                              primaryText,
                              secondaryText,
                              cardColor,
                            );
                          case 2:
                            return _buildAvailabilityTab(
                              primaryText,
                              secondaryText,
                              cardColor,
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
                child: Row(
                  children: [
                    // Premium Unlock Button
                    Expanded(
                      flex: 6,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: kAccentGold,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: kAccentGold.withValues(alpha: .25),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.crown,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: Text(
                            'Unlock with Premium',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Book Paid Button
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: kPrimaryBlue.withValues(alpha: .4),
                            width: 1.5,
                          ),
                        ),
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: kPrimaryBlue,
                            size: 16,
                          ),
                          label: Text(
                            'Book Paid',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryBlue,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    bool isDark,
  ) {
    final cardBg = isDark ? kDarkInputFill : kLightInputFill;
    final dividerColor = isDark ? kDarkDivider : kLightDivider;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: dividerColor),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : kLightTextPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: isDark ? kDarkTextSecondary : kLightTextSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = controller.activeTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.activeTab.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? kPrimaryBlue : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? kPrimaryBlue : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutTab(
    String bio,
    String? education,
    String? barRegistration,
    List<dynamic>? categories,
    Color primaryText,
    Color secondaryText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Biography
        Text(
          'Biography',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          bio,
          style: GoogleFonts.outfit(
            fontSize: 13.5,
            color: secondaryText,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),

        // Education
        Text(
          'Education',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          education ?? 'LLB, University of Dhaka | LLM, BUET Law',
          style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
        ),
        const SizedBox(height: 20),

        // Bar Registration
        Text(
          'Bar Registration',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          barRegistration ?? 'BD-2012-04521',
          style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
        ),
        const SizedBox(height: 20),

        // Practice Areas
        Text(
          'Practice Areas',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 10),
        if (categories == null || categories.isEmpty)
          Text(
            'General Law Practice',
            style: GoogleFonts.outfit(fontSize: 13.5, color: secondaryText),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((cat) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryBlue.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  cat.name ?? '',
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryBlue,
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildReviewsTab(
    Color primaryText,
    Color secondaryText,
    Color cardColor,
  ) {
    // Return a mock reviews list
    final reviews = [
      {
        'name': 'Rahat Hossain',
        'rating': 5.0,
        'comment':
            'Advocate Jane provided exceptional help with our civil litigation. Extremely knowledgeable and supportive throughout.',
        'time': '2 weeks ago',
      },
      {
        'name': 'Sharmin Akter',
        'rating': 4.8,
        'comment':
            'Very professional and responsive. Got sound advice on corporate registry issues.',
        'time': '1 month ago',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Client Reviews',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 12),
        ...reviews.map(
          (rev) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rev['name'] as String,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        color: primaryText,
                        fontSize: 13.5,
                      ),
                    ),
                    Text(
                      rev['time'] as String,
                      style: GoogleFonts.outfit(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kAccentGold, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      rev['rating'].toString(),
                      style: GoogleFonts.outfit(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  rev['comment'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 12.5,
                    color: secondaryText,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailabilityTab(
    Color primaryText,
    Color secondaryText,
    Color cardColor,
  ) {
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Consultation Schedule',
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: primaryText,
          ),
        ),
        const SizedBox(height: 12),
        ...days.map(
          (day) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                    fontSize: 13.5,
                  ),
                ),
                Text(
                  '04:00 PM - 07:00 PM',
                  style: GoogleFonts.outfit(
                    color: kPrimaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
