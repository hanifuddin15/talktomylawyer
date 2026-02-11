import 'dart:async';

import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    navigate();
  }

  void navigate() async {
    Timer(const Duration(seconds: 3), () {
      Get.offNamed(Routes.onboarding);

      /* 
      // Original Logic
      if (repository.isUserLoggedIn()) {
        Get.offNamed(Routes.home);
      } else {
        Get.offNamed(Routes.onboarding);
      }
      */
    });
  }
}
