import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/client_dashboard_controller.dart';
import 'tabs/client_home_tab.dart';
import 'tabs/client_search_tab.dart';
import 'tabs/client_saved_tab.dart';
import 'tabs/client_premium_tab.dart';
import 'tabs/client_profile_tab.dart';

class ClientDashboardView extends GetView<ClientDashboardController> {
  const ClientDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? kDarkSurface : kLightSurface;
    final selectedColor = kPrimaryBlue;
    final unselectedColor = isDark ? kDarkTextSecondary : kLightTextSecondary;

    final tabs = [
      const ClientHomeTab(),
      const ClientSearchTab(),
      const ClientSavedTab(),
      const ClientPremiumTab(),
      const ClientProfileTab(),
    ];

    final navItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home_rounded),
        label: 'home'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.search_outlined),
        activeIcon: const Icon(Icons.search_rounded),
        label: 'search'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.bookmark_outline),
        activeIcon: const Icon(Icons.bookmark_rounded),
        label: 'saved'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.star_outline_rounded),
        activeIcon: const Icon(Icons.star_rounded),
        label: 'premium'.tr,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline_rounded),
        activeIcon: const Icon(Icons.person_rounded),
        label: 'profile'.tr,
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
              selectedItemColor: selectedColor,
              unselectedItemColor: unselectedColor,
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
