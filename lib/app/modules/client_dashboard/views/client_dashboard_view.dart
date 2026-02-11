import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/client_dashboard_controller.dart';
import '../../client_home/views/client_home_view.dart';
import '../../client_search/views/client_search_view.dart';
import '../../client_subscription/views/client_subscription_view.dart';
import '../../client_profile/views/client_profile_view.dart';

class ClientDashboardView extends GetView<ClientDashboardController> {
  const ClientDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            const ClientHomeView(),
            const ClientSearchView(),
            ClientSubscriptionView(),
            const ClientProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 8,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          items: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'Home'),
            _buildNavItem(Icons.search, Icons.search, 'Search'),
            _buildNavItem(
              Icons.card_membership_outlined,
              Icons.card_membership,
              'Subscription',
            ),
            _buildNavItem(Icons.person_outline, Icons.person, 'Profile'),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}
