import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/client_home_controller.dart';

class ClientHomeView extends GetView<ClientHomeController> {
  const ClientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  // Using IconData for placeholders since local assets might not exist yet
                  // Listing icons somewhat matching the category names
                  IconData iconData;
                  switch (category['name']) {
                    case 'Civil Law':
                      iconData = Icons.description_outlined;
                      break;
                    case 'Corporate Law':
                      iconData = Icons.business_outlined;
                      break;
                    case 'Criminal Law':
                      iconData = Icons.gavel_outlined;
                      break;
                    case 'Environmental Law':
                      iconData = Icons.eco_outlined;
                      break;
                    case 'Family Law':
                      iconData = Icons.favorite_border;
                      break;
                    case 'Immigration Law':
                      iconData = Icons.flight_takeoff_outlined;
                      break;
                    case 'Intellectual Property':
                      iconData = Icons.lightbulb_outline;
                      break;
                    case 'Labor Law':
                      iconData = Icons.group_outlined;
                      break;
                    case 'Property Law':
                      iconData = Icons.home_outlined;
                      break;
                    default:
                      iconData = Icons.category_outlined;
                  }

                  return _buildCategoryCard(
                    category['name'] as String,
                    iconData,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF1A237E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, Anik',
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find the right lawyer for your needs',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: .8),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white.withValues(alpha: .2),
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Search Bar Placeholder
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.white70),
                const SizedBox(width: 12),
                Text(
                  'Search for lawyers, practice areas...',
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1A237E), size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}
