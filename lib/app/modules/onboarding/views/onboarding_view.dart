import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();

    final slides = [
      _OnboardingSlide(
        icon: Icons.balance_rounded,
        iconBg: const Color(0xFF3B5BDB),
        title: 'onboarding_title_1'.tr,
        body: 'onboarding_body_1'.tr,
      ),
      _OnboardingSlide(
        icon: Icons.flash_on_rounded,
        iconBg: const Color(0xFFF59E0B),
        title: 'onboarding_title_2'.tr,
        body: 'onboarding_body_2'.tr,
      ),
      _OnboardingSlide(
        icon: Icons.verified_user_rounded,
        iconBg: const Color(0xFFC9A227),
        title: 'onboarding_title_3'.tr,
        body: 'onboarding_body_3'.tr,
      ),
    ];

    return Scaffold(
      backgroundColor: kDarkBg,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 20, 0),
                child: GestureDetector(
                  onTap: controller.skip,
                  child: Text(
                    'skip'.tr,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kDarkTextSecondary,
                    ),
                  ),
                ),
              ),
            ),
            // PageView
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (i) => controller.currentPage.value = i,
                itemCount: slides.length,
                itemBuilder: (_, i) => slides[i],
              ),
            ),
            // Dots + Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                children: [
                  // Dot Indicators
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (i) {
                        final isActive = i == controller.currentPage.value;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: isActive ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isActive ? kPrimaryBlue : kDarkDivider,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Button
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: controller.nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.currentPage.value < 2
                                  ? 'next'.tr
                                  : 'get_started'.tr,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
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

class _OnboardingSlide extends StatelessWidget {
  const _OnboardingSlide({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Illustration Card
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
              color: kDarkCard,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Big faint circle
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: iconBg.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Medium circle
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: iconBg.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                  ),
                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 40),
                  ),
                  // Corner badge
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: kDarkSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: iconBg, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: kDarkTextPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          // Body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              body,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: kDarkTextSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
