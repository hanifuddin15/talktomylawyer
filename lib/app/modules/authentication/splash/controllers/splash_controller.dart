import 'dart:async';

import 'package:get/get.dart';

import '../../../../repository/auth_repository.dart';
import '../../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    navigate();
  }

  void navigate() async {
    AuthRepository repository = AuthRepository();
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
