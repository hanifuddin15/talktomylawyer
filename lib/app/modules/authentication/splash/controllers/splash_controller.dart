import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    final box = GetStorage();
    final bool onboardingDone = box.read('onboarding_done') ?? false;
    final String? token = box.read('auth_token');

    if (token != null && token.isNotEmpty) {
      final String? role = box.read('user_role');
      if (role == 'lawyer') {
        Get.offAllNamed(Routes.lawyerDashboard);
      } else {
        Get.offAllNamed(Routes.clientDashboard);
      }
    } else if (onboardingDone) {
      Get.offAllNamed(Routes.roleSelection);
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
