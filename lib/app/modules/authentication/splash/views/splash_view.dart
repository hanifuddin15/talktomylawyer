import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talktomylawyer/app/core/constants/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.navigate();
    return Scaffold(
      backgroundColor: kDarkBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: kDarkCard,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryBlue.withValues(alpha: .3),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.verified_user_rounded,
                  color: kAccentGold,
                  size: 56,
                ),
              ),
            ),
            const SizedBox(height: 28),
            // App Name
            Text(
              'talk_to_my_lawyer'.tr.isNotEmpty
                  ? 'app_name'.tr
                  : 'Talk to My Lawyer',
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: kDarkTextPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            Text(
              'app_tagline'.tr,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: kDarkTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
