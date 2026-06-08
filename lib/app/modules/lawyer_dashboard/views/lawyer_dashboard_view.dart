import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/lawyer_dashboard_controller.dart';
import 'tabs/lawyer_home_tab.dart';
import 'tabs/lawyer_profile_tab.dart';
import 'tabs/lawyer_schedule_tab.dart';
import 'tabs/lawyer_status_tab.dart';

class LawyerDashboardView extends GetView<LawyerDashboardController> {
  const LawyerDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? kDarkSurface : kLightSurface;

    final tabs = [
      const LawyerHomeTab(),
      const LawyerProfileTab(),
      const LawyerScheduleTab(),
      const LawyerStatusTab(),
    ];

    final navItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.dashboard_outlined),
        activeIcon: const Icon(Icons.dashboard_rounded),
        label: 'dashboard'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline_rounded),
        activeIcon: const Icon(Icons.person_rounded),
        label: 'profile'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.calendar_month_outlined),
        activeIcon: const Icon(Icons.calendar_month_rounded),
        label: 'schedule'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.verified_outlined),
        activeIcon: const Icon(Icons.verified_rounded),
        label: 'status'.tr,
      ),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(index: controller.currentTab.value, children: tabs),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: navBg,
            border: Border(
              top: BorderSide(
                color: isDark ? kDarkDivider : kLightDivider,
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: BottomNavigationBar(
              currentIndex: controller.currentTab.value,
              onTap: controller.changeTab,
              type: BottomNavigationBarType.fixed,
              backgroundColor: navBg,
              selectedItemColor: kPrimaryBlue,
              unselectedItemColor:
                  isDark ? kDarkTextSecondary : kLightTextSecondary,
              selectedLabelStyle: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.outfit(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              elevation: 0,
              items: navItems,
            ),
          ),
        ),
      ),
    );
  }
}
