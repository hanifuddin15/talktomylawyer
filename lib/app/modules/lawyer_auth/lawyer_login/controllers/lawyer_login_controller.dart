import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class LawyerLoginController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> onSignIn(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.offAllNamed(Routes.lawyerDashboard);
  }

  void goToRegister() => Get.toNamed(Routes.lawyerRegister);
  void goToClientLogin() => Get.toNamed(Routes.clientLogin);
}
