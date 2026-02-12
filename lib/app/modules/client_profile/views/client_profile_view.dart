import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/modules/client_profile/widgets/profile_info_card.dart';

import '../controllers/client_profile_controller.dart';

class ClientProfileView extends GetView<ClientProfileController> {
  const ClientProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 30,
                left: 24,
                right: 24,
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Icon(Icons.edit, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: context.theme.primaryColor.withValues(
                            alpha: 0.3,
                          ),
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Obx(
                        () => Text(
                          controller.initials,
                          style: GoogleFonts.outfit(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Client Account',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ProfileInfoCard(
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    value: controller.user['firstName'] ?? '',
                    isEditable: false,
                  ),
                  const SizedBox(height: 16),
                  ProfileInfoCard(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: controller.user['email'] ?? '',
                    helperText: 'Email cannot be changed',
                    isEditable: false,
                  ),
                  const SizedBox(height: 16),
                  ProfileInfoCard(
                    icon: Icons.phone_outlined,
                    label: 'Phone Number',
                    value: controller.user['phone'] ?? '',
                    isEditable: false,
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
