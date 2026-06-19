import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';

class LawyerLoginController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> onSignIn(String email, String password) async {
    isLoading.value = true;
    try {
      final lawyer = await LawyerAuthRepository.instance.loginLawyer(
        email: email,
        password: password,
      );
      if (lawyer != null) {
        Get.offAllNamed(Routes.lawyerDashboard);
      }
    } catch (e) {
      // Handled by ApiCommunication, but caught here for safety
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() => Get.toNamed(Routes.lawyerRegister);
  void goToClientLogin() => Get.toNamed(Routes.clientLogin);
}
