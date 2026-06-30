import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talktomylawyer/app/core/config/api_constant.dart';
import 'package:talktomylawyer/app/core/widgets/no_data_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/app_badge.dart';
import '../../../../core/widgets/app_category_card.dart';
import '../../../../core/widgets/app_lawyer_card.dart';
import '../../../../core/widgets/app_section_header.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import '../../controllers/client_dashboard_controller.dart';
import '../../controllers/client_home_controller.dart';

class ClientHomeTab extends GetView<ClientHomeController> {
  const ClientHomeTab({super.key});

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
                      child: Obx(() {
                        final client = controller.clientModel.value;
                        final name = client?.name ?? 'User';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_greeting()},',
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: secondaryText,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$name 👋'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: primaryText,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    AppBadge(
                      count: 3,
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: primaryText,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search Bar ──
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: SizedBox(
            //             height: 52,
            //             child: AppSearchField(
            //               primaryText: primaryText,
            //               secondaryText: secondaryText,
            //               cardColor: cardColor,
            //             ),
            //           ),
            //         ),
            //         const SizedBox(width: 12),
            //         Container(
            //           width: 48,
            //           height: 48,
            //           decoration: BoxDecoration(
            //             color: kPrimaryBlue,
            //             borderRadius: BorderRadius.circular(14),
            //           ),
            //           child: const Icon(
            //             Icons.tune_rounded,
            //             color: Colors.white,
            //             size: 20,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // ── Premium Banner ──
            Obx(() {
              final client = controller.clientModel.value;
              if (client != null && client.hasActiveSubscription) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              return SliverToBoxAdapter(
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
                          onTap: () => Get.find<ClientDashboardController>()
                              .changeTab(3),
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
              );
            }),

            // ── Legal Categories ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'legal_categories'.tr,
                  actionLabel: 'see_all'.tr,
                  onActionTap: () =>
                      Get.find<ClientDashboardController>().changeTab(1),
                ),
              ),
            ),

            Obx(() {
              if (controller.isCategoriesLoading.value) {
                return Skeletonizer.sliver(
                  child: SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return const AppCategoryCard(
                          title: 'Loading Category',
                          lawyerCount: 0,
                          icon: Icons.gavel_rounded,
                          iconBg: Colors.grey,
                          iconColor: Colors.grey,
                        );
                      }, childCount: 4),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.4,
                          ),
                    ),
                  ),
                );
              }
              if (controller.categoriesList.isEmpty) {
                return SliverToBoxAdapter(
                  child: NoDataWidget(message: 'no_categories_found'.tr),
                );
              }

              final displayCats = controller.categoriesList.take(4).toList();
              final icons = [
                Icons.gavel_rounded,
                Icons.family_restroom_rounded,
                Icons.business_center_rounded,
                Icons.account_balance_rounded,
              ];
              final bgColors = [0x1A3B5BDB, 0x1AF59E0B, 0x1A22C55E, 0x1AC9A227];
              final iconColors = [
                0xFF3B5BDB,
                0xFFF59E0B,
                0xFF22C55E,
                0xFFC9A227,
              ];

              return SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((ctx, i) {
                    final cat = displayCats[i];
                    final icon = icons[i % icons.length];
                    final bg = bgColors[i % bgColors.length];
                    final ic = iconColors[i % iconColors.length];

                    return AppCategoryCard(
                      title: cat.name ?? '',
                      lawyerCount: int.tryParse(cat.lawyersCount ?? '0') ?? 0,
                      icon: icon,
                      iconBg: Color(bg),
                      iconColor: Color(ic),
                    );
                  }, childCount: displayCats.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.4,
                  ),
                ),
              );
            }),

            // ── Featured Lawyers ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'featured_lawyers'.tr,
                  actionLabel: 'see_all'.tr,
                  onActionTap: () =>
                      Get.find<ClientDashboardController>().changeTab(1),
                ),
              ),
            ),

            Obx(() {
              if (controller.isFeaturedLawyersLoading.value) {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    child: SizedBox(
                      height: 250,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 320,
                            child: AppLawyerCard(
                              name: 'Loading...',
                              title: 'Loading...',
                              tags: const ['Tag 1', 'Tag 2'],
                              rating: 0,
                              reviewCount: 0,
                              experience: 0,
                              location: 'Loading...',
                              availability: 'Loading...',
                              rate: 0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }
              if (controller.featuredLawyersList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: NoDataWidget(message: 'no_lawyers_found'.tr),
                  ),
                );
              }

              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 250,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.featuredLawyersList.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final lawyer = controller.featuredLawyersList[index];
                      final hasAvatar =
                          lawyer.profilePic != null &&
                          lawyer.profilePic != 'default.png';
                      final avatar = hasAvatar
                          ? '${ApiConstant.serverIpPort}/storage/${lawyer.profilePic}'
                          : null;

                      final initials =
                          lawyer.name != null && lawyer.name!.isNotEmpty
                          ? lawyer.name!
                                .trim()
                                .split(' ')
                                .map(
                                  (e) => e.isNotEmpty ? e.substring(0, 1) : '',
                                )
                                .join()
                                .toUpperCase()
                          : 'L';

                      final title =
                          lawyer.categories != null &&
                              lawyer.categories!.isNotEmpty
                          ? '${lawyer.categories!.first.name} • ${lawyer.numberOfExperience ?? '1'} yr exp'
                          : 'Lawyer • ${lawyer.numberOfExperience ?? '1'} yr exp';

                      final tags =
                          lawyer.categories
                              ?.map((e) => e.name ?? '')
                              .toList() ??
                          [];

                      return SizedBox(
                        width: 320,
                        child: AppLawyerCard(
                          name: lawyer.name ?? 'Jane Lawyer',
                          title: title,
                          tags: tags,
                          rating: 4.8,
                          reviewCount: 120,
                          experience:
                              int.tryParse(lawyer.numberOfExperience ?? '1') ??
                              1,
                          location: lawyer.address ?? 'Dhaka',
                          availability: 'available_today'.tr,
                          rate: 2000,
                          avatarUrl: avatar,
                          initials: initials,
                          isSaved: lawyer.isSaved ?? false,
                          onSave: () => controller.toggleSaveLawyer(lawyer),
                          onTap: () => Get.toNamed(
                            Routes.lawyerDetails,
                            arguments: lawyer.id,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
