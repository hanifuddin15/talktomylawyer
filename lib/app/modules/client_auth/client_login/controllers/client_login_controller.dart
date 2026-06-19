import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';

class ClientLoginController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> onSignIn(String email, String password) async {
    isLoading.value = true;
    try {
      final client = await ClientAuthRepository.instance.loginClient(
        email: email,
        password: password,
      );
      if (client != null) {
        Get.offAllNamed(Routes.clientDashboard);
      }
    } catch (e) {
      // Handled by ApiCommunication, but caught here for safety
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() => Get.toNamed(Routes.clientRegister);
  void goToLawyerLogin() => Get.toNamed(Routes.lawyerLogin);
}
