import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Choose your role',
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please select how you want to use the app',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 48),
            _buildRoleCard(
              title: 'I am a Client',
              description: 'Find a lawyer and get legal advice',
              icon: Icons.person_outline,
              onTap: controller.selectClient,
            ),
            const SizedBox(height: 24),
            _buildRoleCard(
              title: 'I am a Lawyer',
              description: 'Provide legal services and find clients',
              icon: Icons.gavel_outlined,
              onTap: controller.selectLawyer,
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isSecondary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSecondary ? Colors.white : const Color(0xFF1A237E),
          borderRadius: BorderRadius.circular(20),
          border: isSecondary ? Border.all(color: Colors.grey.shade300) : null,
          boxShadow: isSecondary
              ? []
              : [
                  BoxShadow(
                    color: const Color(0xFF1A237E).withValues(alpha: .3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSecondary
                    ? const Color(0xFFF5F7FA)
                    : Colors.white.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSecondary ? const Color(0xFF1A237E) : Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSecondary
                          ? const Color(0xFF1A1A1A)
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: isSecondary
                          ? Colors.grey.shade600
                          : Colors.white.withValues(alpha: .7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isSecondary
                  ? Colors.grey.shade400
                  : Colors.white.withValues(alpha: .5),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
