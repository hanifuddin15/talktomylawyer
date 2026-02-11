import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/onboarding_controller.dart';
import 'widgets/onboarding_page.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              OnboardingPage(
                title: 'Talk to Lawyer',
                description: 'On-demand legal guidance tailored to you',
                tags: ['Instant matching', 'Secure calls', 'Flat pricing'],
                // TODO: Add image/animation
              ),
              OnboardingPage(
                iconData: Icons.gpp_good_outlined,
                gradientColors: [
                  Color.fromARGB(255, 4, 6, 31),
                  Color.fromARGB(255, 4, 6, 31),
                  Color.fromARGB(255, 3, 205, 227),
                ],
                title: 'Verified Experts',
                description:
                    'Licensed lawyers with domain expertise you can trust',
                tags: [
                  'Identity verified',
                  'Bar status checked',
                  'Client ratings',
                ],
                // TODO: Add image/animation
              ),
              OnboardingPage(
                iconData: Icons.access_time,
                gradientColors: [
                  Color.fromARGB(255, 10, 22, 18),
                  Color.fromARGB(255, 16, 43, 31),
                  Color.fromARGB(255, 32, 202, 137),
                ],
                title: 'Pick your role',
                description: 'We customize the flow based on who you are',
                tags: [
                  'Personalized dashboard',
                  'Smart intake',
                  'Live support',
                ],
                // TODO: Add image/animation
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Page Indicator
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: controller.currentIndex.value == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: controller.currentIndex.value == index
                              ? const Color(0xFF1A237E) // Deep Blue
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                // Next Button
                ElevatedButton(
                  onPressed: controller.next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E), // Deep Blue
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
