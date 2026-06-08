import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class ClientLoginController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> onSignIn(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    // TODO: call actual auth API
    Get.offAllNamed(Routes.clientDashboard);
  }

  void goToRegister() => Get.toNamed(Routes.clientRegister);
  void goToLawyerLogin() => Get.toNamed(Routes.lawyerLogin);
}
