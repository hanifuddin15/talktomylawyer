import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/widgets/buttons/primary_button.dart';
import 'package:talktomylawyer/app/modules/client_subscription/widgets/subscription_card.dart';

import '../controllers/client_subscription_controller.dart';

class ClientSubscriptionView extends GetView<ClientSubscriptionController> {
  const ClientSubscriptionView({super.key});
  @override
  Widget build(BuildContext context) {
    final isSelected = true;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              height: 160,
              padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: Color(0xFF1A237E),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription',
                    style: GoogleFonts.outfit(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Unlock full access to all lawyers',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: .6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No More Subscription',
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  Text(
                    'Subscribe to unlock full access to all lawyers profile and contact information',
                    style: GoogleFonts.outfit(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),

            // Native Subscription Banner (Placeholder for system UI if needed, but using custom UI here)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Features',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    context,
                    'Unlock all lawyer contact details',
                  ),
                  _buildFeatureItem(context, 'Direct messaging with lawyers'),
                  _buildFeatureItem(context, 'Priority support'),
                  _buildFeatureItem(context, 'Save favorite lawyers'),
                  _buildFeatureItem(context, 'Advanced search filters'),
                  _buildFeatureItem(context, 'Unlimited profile views'),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Plan Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Choose Your Plan',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Monthly Plan Card
            SubscriptionCard(
              isSelected: true,
              planName: 'Monthly Plan',
              price: '29.99',
              subText: 'Best for short-term legal needs',
            ),
            const SizedBox(height: 16),
            SubscriptionCard(
              isSelected: false,
              planName: 'Annual Plan',
              price: '249',
              subText: 'Best for short-term legal needs',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withValues(alpha: .2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: const Color(0xFF424242),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
