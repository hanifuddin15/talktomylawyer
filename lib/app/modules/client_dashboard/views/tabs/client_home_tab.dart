import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/app_category_card.dart';
import '../../../../core/widgets/app_lawyer_card.dart';
import '../../../../core/widgets/app_section_header.dart';
import '../../../client_subscription/checkout/views/checkout_view.dart';

class ClientHomeTab extends StatelessWidget {
  const ClientHomeTab({super.key});

  static const _categories = [
    {
      'icon': Icons.gavel_rounded,
      'key': 'criminal_law',
      'count': 48,
      'bg': 0x1A3B5BDB,
      'ic': 0xFF3B5BDB,
    },
    {
      'icon': Icons.family_restroom_rounded,
      'key': 'family_law',
      'count': 35,
      'bg': 0x1AF59E0B,
      'ic': 0xFFF59E0B,
    },
    {
      'icon': Icons.business_center_rounded,
      'key': 'corporate_law',
      'count': 62,
      'bg': 0x1A22C55E,
      'ic': 0xFF22C55E,
    },
    {
      'icon': Icons.account_balance_rounded,
      'key': 'civil_law',
      'count': 29,
      'bg': 0x1AC9A227,
      'ic': 0xFFC9A227,
    },
    {
      'icon': Icons.home_work_rounded,
      'key': 'property_law',
      'count': 41,
      'bg': 0x1AEF4444,
      'ic': 0xFFEF4444,
    },
    {
      'icon': Icons.engineering_rounded,
      'key': 'labour_law',
      'count': 22,
      'bg': 0x1A8B5CF6,
      'ic': 0xFF8B5CF6,
    },
    {
      'icon': Icons.flight_rounded,
      'key': 'immigration',
      'count': 18,
      'bg': 0x1A06B6D4,
      'ic': 0xFF06B6D4,
    },
    {
      'icon': Icons.receipt_long_rounded,
      'key': 'tax_law',
      'count': 31,
      'bg': 0x1AFF7043,
      'ic': 0xFFFF7043,
    },
  ];

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'good_morning'.tr;
    if (h < 17) return 'good_afternoon'.tr;
    return 'good_evening'.tr;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? kDarkBg : kLightBg;
    final primaryText = isDark ? kDarkTextPrimary : kLightTextPrimary;
    final secondaryText = isDark ? kDarkTextSecondary : kLightTextSecondary;
    final cardColor = isDark ? kDarkCard : kLightCard;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_greeting()}, User 👋',
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: secondaryText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'app_name'.tr,
                            style: GoogleFonts.outfit(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppBadge(
                      count: 3,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: primaryText,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search Bar ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      Icon(Icons.search, color: secondaryText, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: () {},
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: primaryText,
                          ),
                          decoration: InputDecoration(
                            hintText: 'search_hint'.tr,
                            hintStyle: GoogleFonts.outfit(
                              fontSize: 14,
                              color: secondaryText,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kPrimaryBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Premium Banner ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1E3A8A), kPrimaryBlue],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'get_premium'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'unlock_premium'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const CheckoutView()),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: kAccentGold,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'upgrade'.tr,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Legal Categories ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'legal_categories'.tr,
                  actionLabel: 'see_all'.tr,
                  onActionTap: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  itemCount: _categories.length,
                  itemBuilder: (ctx, i) {
                    final cat = _categories[i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SizedBox(
                        width: 130,
                        child: AppCategoryCard(
                          title: (cat['key'] as String).tr,
                          lawyerCount: cat['count'] as int,
                          icon: cat['icon'] as IconData,
                          iconBg: Color(cat['bg'] as int),
                          iconColor: Color(cat['ic'] as int),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // ── Featured Lawyers ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'featured_lawyers'.tr,
                  actionLabel: 'see_all'.tr,
                  onActionTap: () {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  AppLawyerCard(
                    name: 'Adv. Rahman Khan',
                    title: '${'corporate_law'.tr} • 12 yr exp',
                    tags: ['corporate_law'.tr, 'tax_law'.tr],
                    rating: 4.9,
                    reviewCount: 128,
                    experience: 12,
                    location: 'Dhaka',
                    availability: 'available_today'.tr,
                    rate: 2500,
                    initials: 'RK',
                  ),
                  AppLawyerCard(
                    name: 'Adv. Fatema Begum',
                    title: '${'family_law'.tr} • 8 yr exp',
                    tags: ['family_law'.tr, 'civil_law'.tr],
                    rating: 4.7,
                    reviewCount: 96,
                    experience: 8,
                    location: 'Chittagong',
                    availability: 'available_tomorrow'.tr,
                    rate: 2000,
                    initials: 'FB',
                  ),
                  AppLawyerCard(
                    name: 'Adv. Kamal Hossain',
                    title: '${'criminal_law'.tr} • 15 yr exp',
                    tags: ['criminal_law'.tr],
                    rating: 4.8,
                    reviewCount: 203,
                    experience: 15,
                    location: 'Dhaka',
                    availability: 'available_today'.tr,
                    rate: 3000,
                    initials: 'KH',
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
