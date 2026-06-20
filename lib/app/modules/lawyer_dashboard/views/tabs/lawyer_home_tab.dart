import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import 'package:talktomylawyer/app/core/widgets/app_analytics_card.dart';
import 'package:talktomylawyer/app/core/widgets/app_section_header.dart';
import 'package:talktomylawyer/app/models/client_models/appointment_model.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/modules/lawyer_appointments_list/views/widgets/lawyer_appointment_card.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

import 'package:talktomylawyer/app/modules/lawyer_dashboard/controllers/lawyer_home_controller.dart';

class LawyerHomeTab extends GetView<LawyerHomeController> {
  const LawyerHomeTab({super.key});

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
                        final lawyer = controller.lawyerModel.value;
                        final name = lawyer?.name ?? 'Adv. Rahman Khan';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'dashboard'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: primaryText,
                              ),
                            ),
                            Text(
                              name,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                color: secondaryText,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    GestureDetector(
                      onTap: () => Get.offAllNamed('/role_selection'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kError.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: kError.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.logout_rounded,
                              color: kError,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'sign_out'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: kError,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Pending Verification Banner ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: kAccentGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: kAccentGold.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: kAccentGold.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.hourglass_top_rounded,
                          color: kAccentGold,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'pending_verification'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kAccentGold,
                              ),
                            ),
                            Text(
                              'profile_under_review'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 12,
                                color: isDark
                                    ? kDarkTextSecondary
                                    : kLightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Analytics 2x2 Grid ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: AppSectionHeader(title: 'analytics_overview'.tr),
              ),
            ),
            Obx(() {
              if (controller.isOverviewLoading.value) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              final profileView = controller.overviewData['profile_view']?.toString() ?? '0';
              final leadOfThisMonth = controller.overviewData['lead_of_this_month']?.toString() ?? '0';
              final consultation = controller.overviewData['consultation']?.toString() ?? '0';
              final rating = controller.overviewData['rating']?.toString() ?? '0';

              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                    children: [
                      AppAnalyticsCard(
                        icon: Icons.visibility_outlined,
                        value: profileView,
                        label: 'profile_views'.tr,
                        growth: '+12% this month',
                      ),
                      AppAnalyticsCard(
                        icon: Icons.people_outline,
                        value: leadOfThisMonth,
                        label: 'leads_this_month'.tr,
                        growth: '+5 vs last month',
                      ),
                      AppAnalyticsCard(
                        icon: Icons.handshake_outlined,
                        value: consultation,
                        label: 'consultations'.tr,
                        growth: '+2 this week',
                      ),
                      AppAnalyticsCard(
                        icon: Icons.star_outline_rounded,
                        value: rating,
                        label: 'avg_rating'.tr,
                        growth: 'From 128 reviews',
                        isPositive: true,
                      ),
                    ],
                  ),
                ),
              );
            }),

            // ── Pending Bookings ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'Pending Bookings',
                  actionLabel: 'see_all'.tr,
                  onActionTap: () => Get.toNamed(Routes.lawyerAppointmentsList, arguments: 'pending'),
                ),
              ),
            ),
            Obx(() {
              if (controller.isPendingLoading.value) {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: List.generate(2, (index) => _buildSkeletonCard()),
                      ),
                    ),
                  ),
                );
              }
              if (controller.pendingBookings.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'No pending bookings',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: secondaryText,
                        ),
                      ),
                    ),
                  ),
                );
              }
              final displayList = controller.pendingBookings.take(3).toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final appointment = displayList[index];
                    return LawyerAppointmentCard(
                      appointment: appointment,
                      onTap: () => Get.toNamed(
                        Routes.consultationDetails,
                        arguments: appointment.id,
                      )?.then((_) {
                        controller.fetchPendingBookings();
                        controller.fetchUpcomingBookings();
                        controller.fetchOverview();
                      }),
                      onAccept: () => controller.acceptAppointment(appointment.id!),
                      onJoinCall: () => controller.joinCall(appointment),
                    );
                  },
                  childCount: displayList.length,
                ),
              );
            }),

            // ── Upcoming Sessions ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(
                  title: 'Upcoming Sessions',
                  actionLabel: 'see_all'.tr,
                  onActionTap: () => Get.toNamed(Routes.lawyerAppointmentsList, arguments: 'upcoming'),
                ),
              ),
            ),
            Obx(() {
              if (controller.isUpcomingLoading.value) {
                return SliverToBoxAdapter(
                  child: Skeletonizer(
                    enabled: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        children: List.generate(2, (index) => _buildSkeletonCard()),
                      ),
                    ),
                  ),
                );
              }
              if (controller.upcomingBookings.isEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'No upcoming sessions',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: secondaryText,
                        ),
                      ),
                    ),
                  ),
                );
              }
              final displayList = controller.upcomingBookings.take(3).toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final appointment = displayList[index];
                    return LawyerAppointmentCard(
                      appointment: appointment,
                      onTap: () => Get.toNamed(
                        Routes.consultationDetails,
                        arguments: appointment.id,
                      )?.then((_) {
                        controller.fetchPendingBookings();
                        controller.fetchUpcomingBookings();
                        controller.fetchOverview();
                      }),
                      onAccept: () => controller.acceptAppointment(appointment.id!),
                      onJoinCall: () => controller.joinCall(appointment),
                    );
                  },
                  childCount: displayList.length,
                ),
              );
            }),

            // ── Quick Actions 2x2 ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: AppSectionHeader(title: 'quick_actions'.tr),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
                children: [
                  _QuickActionBtn(
                    icon: Icons.edit_outlined,
                    label: 'edit_profile'.tr,
                    color: kPrimaryBlue,
                    isDark: isDark,
                    primaryText: primaryText,
                    cardColor: cardColor,
                  ),
                  _QuickActionBtn(
                    icon: Icons.calendar_today_outlined,
                    label: 'availability'.tr,
                    color: kSuccess,
                    isDark: isDark,
                    primaryText: primaryText,
                    cardColor: cardColor,
                  ),
                  _QuickActionBtn(
                    icon: Icons.folder_outlined,
                    label: 'documents'.tr,
                    color: kAccentGold,
                    isDark: isDark,
                    primaryText: primaryText,
                    cardColor: cardColor,
                  ),
                  _QuickActionBtn(
                    icon: Icons.star_outline_rounded,
                    label: 'go_premium_lawyer'.tr,
                    color: const Color(0xFF8B5CF6),
                    isDark: isDark,
                    primaryText: primaryText,
                    cardColor: cardColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSkeletonCard() {
  return LawyerAppointmentCard(
    appointment: AppointmentModel(
      id: 0,
      scheduleDate: '2026-06-20',
      scheduleTime: '10:30:00',
      status: 'pending',
      consultationMode: 'online',
      consultationFee: '5000',
      issue: 'Loading issue details description here...',
      client: ClientModel(
        id: 0,
        name: 'Loading Client Name',
        email: 'client@app.com',
        phone: '01700000000',
      ),
    ),
  );
}

class _QuickActionBtn extends StatelessWidget {
  const _QuickActionBtn({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.primaryText,
    required this.cardColor,
  });
  final IconData icon;
  final String label;
  final Color color, primaryText, cardColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.outfit(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryText,
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
